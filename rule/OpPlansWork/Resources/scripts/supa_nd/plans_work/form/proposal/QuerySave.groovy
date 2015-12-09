package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    // status: draft, coordination, revision, excluded, coordinated
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
        doc.addStringField("assignee", webFormData.getValue("assignee"))
        doc.addStringField("department", assigneeUser.getDepartmentID())
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
        doc.addViewText(webFormData.getValueSilently("comment")) // viewtext6 = last comment
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
        if (webFormData.containsField("comment")) {
            // add comment
        }

        def assigneeUser
        if (webFormData.containsField("assignee")) {
            def currentAssignee = doc.getValueString("assignee")
            if (currentAssignee != webFormData.getValue("assignee")) {
                assigneeUser = session.getStructure().getEmployer(webFormData.getValue("assignee"))
                doc.addStringField("assignee", webFormData.getValue("assignee"))
                doc.addStringField("department", assigneeUser.getDepartmentID())
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
        if (webFormData.getValueSilently("comment")) {
            doc.setViewText(webFormData.getValueSilently("comment"), 6) // viewtext6 = last comment
        }
        doc.setViewText(doc.getValueString("status"), 7) // viewtext7 = status
        //---------------------------------------------
    }

    private void doCoordination(_Session session, _Document doc, _WebFormData webFormData, String status) {

    }
}
