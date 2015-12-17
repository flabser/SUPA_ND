package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.constants._BlockStatusType
import kz.nextbase.script.constants._BlockType
import kz.nextbase.script.constants._CoordStatusType
import kz.nextbase.script.constants._DecisionType
import kz.nextbase.script.coordination._Block
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    // status (viewtext7): draft, coordination, revision, reject, coordinated
    // coordination_direction: up, down
    // action: (save:''), coord_start, coord_agree, coord_revision, coord_reject
    //
    // izmenilos' mnenie, ne budet roditel'skogo documenta.
    // esli nuzhna sviaznost' predlozhenii, budem sviazyvat' logicheski
    // po avtoru, departamentu avtora...
    //
    // vse deistvija proishodjashie s predlozheniem otobrazhat' v vide timeline po regDate

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        // TODO validate

        if (doc.isNewDoc) {
            doSaveNew(session, doc, webFormData)
        } else {
            doSave(session, doc, webFormData)
        }

        def action = webFormData.getValueSilently("_action")
        switch (action) {
            case "coord_start":
            case "coord_agree":
            case "coord_revision":
            case "coord_reject":
                doCoordination(session, doc, webFormData, action)
                break
        }

        doc.addStringField("_action", action)
    }

    private void doSaveNew(_Session session, _Document doc, _WebFormData webFormData) {
        doc.setForm("proposal")

        // Coordination block
        doc.addField("coordination", new _BlockCollection(session))
        doc.addStringField("coordination_direction", "up")
        //

        def assigneeUser = session.getStructure().getEmployer(webFormData.getValue("assignee"))

        doc.addStringField("description", webFormData.getValue("description"))
        doc.addStringField("dueDateType", webFormData.getValue("dueDateType"))
        doc.addStringField("dueDate", webFormData.getValueSilently("dueDate"))
        doc.addStringField("status", "draft")
        doc.addStringField("assignee", assigneeUser.getUserID())
        doc.addStringField("department", "" + assigneeUser.getDepartmentID())
        //---------------------------------------------
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        doc.setViewText(doc.getValueString("description"))
        doc.addViewText(assigneeUser.getFullName())
        doc.addViewText(assigneeUser.getUserID())
        doc.addViewText(doc.getValueString("dueDateType"))
        doc.addViewText(doc.getValueString("dueDate"))
        doc.addViewText("") // viewtext5
        doc.addViewText("") // viewtext6
        doc.addViewText(doc.getValueString("status")) // viewtext7 = status
        //---------------------------------------------
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor(assigneeUser.getUserID())
        doc.addEditor("[supervisor]")
    }

    private void doSave(_Session session, _Document doc, _WebFormData webFormData) {
        def changes = []

        if (webFormData.containsField("description")) {
            def desc = doc.getValueString("description")
            def newDesc = webFormData.getValue("description")
            if (desc != newDesc) {
                doc.addStringField("description", newDesc)
                //
                changes << ["description", desc, newDesc]
            }
        }
        if (webFormData.containsField("dueDateType")) {
            def dueDateType = doc.getValueString("dueDateType")
            def newDueDateType = webFormData.getValue("dueDateType")
            if (dueDateType != newDueDateType) {
                doc.addStringField("dueDateType", newDueDateType)
                //
                changes << ["dueDateType", dueDateType, newDueDateType]
            }
        }
        if (webFormData.containsField("dueDate")) {
            def dueDate = doc.getValueString("dueDate")
            def newDueDate = webFormData.getValue("dueDate")
            if (dueDate != newDueDate) {
                doc.addStringField("dueDate", newDueDate)
                //
                changes << ["dueDate", dueDate, newDueDate]
            }
        }
        if (webFormData.containsField("status")) {
            def status = doc.getValueString("status")
            def newStatus = webFormData.getValue("newStatus")
            if (status != newStatus) {
                doc.addStringField("status", status)
                //
                changes << ["status", status, newStatus]
            }
        }

        def assigneeUser
        if (webFormData.containsField("assignee")) {
            def currentAssigneeId = doc.getValueString("assignee")
            if (currentAssigneeId != webFormData.getValue("assignee")) {
                assigneeUser = session.getStructure().getEmployer(webFormData.getValue("assignee"))
                doc.addStringField("assignee", assigneeUser.getUserID())
                doc.addStringField("department", "" + assigneeUser.getDepartmentID())
                //
                changes << ["assignee", currentAssigneeId, assigneeUser.userID]
            } else {
                assigneeUser = session.getStructure().getEmployer(doc.getValueString("assignee"))
            }
        } else {
            assigneeUser = session.getStructure().getEmployer(doc.getValueString("assignee"))
        }
        //---------------------------------------------
        if (!changes.empty) {
            // WARNING. Pomni porjadok viewtext[n] kriti4en
            doc.setViewText(doc.getValueString("description"), 0)
            doc.setViewText(assigneeUser.getFullName(), 1)
            doc.setViewText(assigneeUser.getUserID(), 2)
            doc.setViewText(doc.getValueString("dueDateType"), 3)
            doc.setViewText(doc.getValueString("dueDate"), 4)
            // viewtext5
            // viewtext6
            doc.setViewText(doc.getValueString("status"), 7) // viewtext7 = status
            //
            def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
            if (blockCollection.hasCoordination()) {
                ProposalService.addChangeEvent(session, doc, changes.join(","))
            }
        }
        //---------------------------------------------
    }

    private void doCoordination(_Session session, _Document doc, _WebFormData webFormData, String action) {

        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")

        switch (action) {
            case "coord_start":
                def block = new _Block(session)
                block.setBlockStatus(_BlockStatusType.COORDINATING)
                block.setBlockType(_BlockType.SERIAL_COORDINATION)
                blockCollection.setBlocks([block])
                blockCollection.setCoordStatus(_CoordStatusType.COORDINATING)
                //
                doc.addStringField("coordination_direction", "up")
                doc.addStringField("status", "coordination")
                doc.setViewText("coordination", 7)
                break

            case "coord_agree":
                def block = blockCollection.getCurrentBlock()
                def coordinator = block.getCurrentCoordinators().get(0)
                def comment = webFormData.getValueSilently("coordination_comment")
                coordinator.setDecision(_DecisionType.AGREE, comment)
                //
                def nextCoordinator = block.getNextCoordinator(coordinator)
                nextCoordinator.setCurrent(true)
                //
                doc.addStringField("coordination_direction", "up")
                break

            case "coord_revision":
                def block = blockCollection.getCurrentBlock()
                def coordinator = block.getCurrentCoordinators().get(0)
                def comment = webFormData.getValue("coordination_comment")
                coordinator.setDecision(_DecisionType.DISAGREE, comment)
                //
                def buff
                def prevCoordinator
                block.coordinators.each {
                    if (coordinator.userID == it.userID) {
                        prevCoordinator = buff
                        return
                    }
                    buff = it
                }
                prevCoordinator?.setCurrent(true)
                //
                doc.addStringField("coordination_direction", "down")
                //
                ProposalService.addCoordEvent(session, doc, "revision", comment)
                break

            case "coord_reject":
                def block = blockCollection.getCurrentBlock()
                def coordinator = block.getCurrentCoordinators().get(0)
                def comment = webFormData.getValueSilently("coordination_comment")
                coordinator.setDecision(_DecisionType.DISAGREE, comment)
                //
                def buff
                def prevCoordinator
                block.coordinators.each {
                    if (coordinator.userID == it.userID) {
                        prevCoordinator = buff
                        return
                    }
                    buff = it
                }
                prevCoordinator?.setCurrent(true)
                //
                doc.addStringField("coordination_direction", "down")
                break
        }
    }
}
