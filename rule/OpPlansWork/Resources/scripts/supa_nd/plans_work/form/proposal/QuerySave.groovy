package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    // status: draft, revision, excluded, coordinated
    //
    // izmenilos' mnenie, ne budet roditel'skogo documenta.
    // esli nuzhna sviaznost' predlozhenii, budem sviazyvat' logicheski
    // po avtoru, departamentu avtora
    //
    // vse deistvija proishodjashie s predlozheniem hranit' v vide timeline

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("proposal")

        doc.addStringField("description", webFormData.getValue("description"))
        doc.addStringField("assignee", webFormData.getValue("assignee"))
        doc.addStringField("dueDateType", webFormData.getValue("dueDateType"))
        doc.addStringField("dueDate", webFormData.getValueSilently("dueDate"))
        doc.addStringField("sendMark", webFormData.getValueSilently("sendMark"))

        doc.addStringField("status", webFormData.getValueSilently("status"))

        def struct = session.getStructure();
        def assignee = struct.getEmployer(webFormData.getValue("assignee"));

        doc.addStringField("department", assignee.getDepartmentID());

        def vt = """${doc.getValueString("description")} > ${doc.getValueString("assignee")}, ${
            doc.getValueString("dueDateType")
        } : ${doc.getValueString("dueDate")}"""
        doc.setViewText(vt)
        doc.addViewText(doc.getValueString("description"))
        doc.addViewText(assignee.getFullName())
        doc.addViewText(assignee.getUserID())
        doc.addViewText(doc.getValueString("dueDateType"))
        doc.addViewText(doc.getValueString("dueDate"))
        doc.addViewText(doc.getValueString("sendMark"))
        doc.addViewText(doc.getValueString("status")) // viewtext7 = status
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addReader(assignee.getUserID())
        doc.addEditor("[supervisor]")
    }
}
