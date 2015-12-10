package supa_nd.plans_work.form.proposal

import kz.flabs.users.User
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    // status (viewtext7): draft, coordination, revision, excluded, coordinated
    // action: (save:''), coordination, coord_agree, coord_revision, coord_reject
    //
    // izmenilos' mnenie, ne budet roditel'skogo documenta.
    // esli nuzhna sviaznost' predlozhenii, budem sviazyvat' logicheski
    // po avtoru, departamentu avtora...
    //
    // vse deistvija proishodjashie s predlozheniem otobrazhat' v vide timeline po regDate

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        if (doc.isNewDoc) {
            doSaveNew(session, doc, webFormData)
        } else {
            doSave(session, doc, webFormData)
        }

        def action = webFormData.getValueSilently("_action")
        switch (action) {
            case "coordination":
            case "coord_agree":
            case "coord_revision":
            case "coord_reject":
                doCoordination(session, doc, webFormData, action)
                break
        }
    }

    private void doSaveNew(_Session session, _Document doc, _WebFormData webFormData) {
        doc.setForm("proposal")

        def assigneeUser = session.getStructure().getEmployer(webFormData.getValue("assignee"))

        doc.addStringField("description", webFormData.getValue("description"))
        doc.addStringField("dueDateType", webFormData.getValue("dueDateType"))
        doc.addStringField("dueDate", webFormData.getValueSilently("dueDate"))
        doc.addStringField("status", "draft")
        doc.addStringField("assignee", assigneeUser.getUserID())
        doc.addStringField("department", "" + assigneeUser.getDepartmentID())
        //---------------------------------------------
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        def vt = """${doc.getValueString("description")} > ${assigneeUser.getFullName()}, ${
            doc.getValueString("dueDateType")
        } : ${doc.getValueString("dueDate")}"""
        doc.setViewText(vt)
        doc.addViewText(doc.getValueString("description"))
        doc.addViewText(assigneeUser.getFullName())
        doc.addViewText(assigneeUser.getUserID())
        doc.addViewText(doc.getValueString("dueDateType"))
        doc.addViewText(doc.getValueString("dueDate"))
        doc.addViewText("") // viewtext6
        doc.addViewText(doc.getValueString("status")) // viewtext7 = status
        //---------------------------------------------
        doc.addEditor(session.getUser().getUserID())
        doc.addReader(assigneeUser.getUserID())
        doc.addEditor("[supervisor]")
    }

    private void doSave(_Session session, _Document doc, _WebFormData webFormData) {
        if (webFormData.containsField("description")) {
            doc.addStringField("description", webFormData.getValue("description"))
            // add event: change: description
        }
        if (webFormData.containsField("dueDateType")) {
            doc.addStringField("dueDateType", webFormData.getValue("dueDateType"))
            // add event: change: dueDateType
        }
        if (webFormData.containsField("dueDate")) {
            doc.addStringField("dueDate", webFormData.getValue("dueDate"))
            // add event: change: dueDate
        }
        if (webFormData.containsField("status")) {
            doc.addStringField("status", webFormData.getValue("status"))
            // add event: change: status
        }

        def assigneeUser
        if (webFormData.containsField("assignee")) {
            def currentAssignee = doc.getValueString("assignee")
            if (currentAssignee != webFormData.getValue("assignee")) {
                assigneeUser = session.getStructure().getEmployer(webFormData.getValue("assignee"))
                doc.addStringField("assignee", assigneeUser.getUserID())
                doc.addStringField("department", "" + assigneeUser.getDepartmentID())
            } else {
                assigneeUser = session.getStructure().getEmployer(doc.getValueString("assignee"))
            }
        } else {
            assigneeUser = session.getStructure().getEmployer(doc.getValueString("assignee"))
        }
        //---------------------------------------------
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        def vt = """${doc.getValueString("description")} > ${assigneeUser.getFullName()}, ${
            doc.getValueString("dueDateType")
        } : ${doc.getValueString("dueDate")}"""
        doc.setViewText(vt, 0)
        doc.setViewText(doc.getValueString("description"), 1)
        doc.setViewText(assigneeUser.getFullName(), 2)
        doc.setViewText(assigneeUser.getUserID(), 3)
        doc.setViewText(doc.getValueString("dueDateType"), 4)
        doc.setViewText(doc.getValueString("dueDate"), 5)
        // viewtext6
        doc.setViewText(doc.getValueString("status"), 7) // viewtext7 = status
        //---------------------------------------------
    }

    private void addComment(_Session session, _Document doc, User author, String commentText) {
        def commentDoc = new _Document(session.getCurrentDatabase())
        commentDoc.setForm("comment")
        commentDoc.setParentDoc(doc)
        //
        commentDoc.addStringField("text", commentText)
        //
        commentDoc.setViewNumber(0)
        commentDoc.setViewDate(new Date()) // update time
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        commentDoc.setViewText(commentText)
        commentDoc.addViewText(author.getFullName())
        //
        commentDoc.addEditor(author.getUserID())
        commentDoc.addEditor("[supervisor]")
        commentDoc.save("[supervisor]")
    }

    private void addEvent(_Session session, _Document doc, String eventType, String text) {
        def commentDoc = new _Document(session.getCurrentDatabase())
        commentDoc.setForm("event")
        commentDoc.setParentDoc(doc)
        //
        commentDoc.addStringField("eventType", eventType)
        commentDoc.addStringField("text", text)
        //
        commentDoc.setViewDate(new Date())
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        commentDoc.setViewText(eventType)
        commentDoc.addViewText(text)
        commentDoc.addViewText(session.getUser().getFullName())
        //
        commentDoc.save("[supervisor]")
    }

    private void doCoordination(_Session session, _Document doc, _WebFormData webFormData, String action) {

        // def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        // doc.addCoordinationField('coordination', "new`pos`0`-")

        addComment(session, doc, session.getUser(), action)

        switch (action) {
            case "coordination":
                doc.addStringField("status", "coordination")
                doc.setViewText("coordination", 7)
                //
                addEvent(session, doc, "coordination", "start")
                break
            case "coord_agree":
                doc.addStringField("status", "agree")
                doc.setViewText("agree", 7)
                //
                addEvent(session, doc, "coordination", "agree")
                break
            case "coord_revision":
                doc.addStringField("status", "revision")
                doc.setViewText("revision", 7)
                //
                addEvent(session, doc, "coordination", "revision")
                break
            case "coord_reject":
                doc.addStringField("status", "reject")
                doc.setViewText("reject", 7)
                //
                addEvent(session, doc, "coordination", "reject")
                break
        }
    }
}
