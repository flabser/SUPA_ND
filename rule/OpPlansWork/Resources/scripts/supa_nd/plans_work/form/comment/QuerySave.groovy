package supa_nd.plans_work.form.comment

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("comment")

        doc.addStringField("text", webFormData.getValue("text"))

        def struct = session.getStructure();
        def assignee = struct.getEmployer(webFormData.getValue("assignee"));

        def vt = """${doc.getValueString("text")} > ${doc.getValueString("assignee")}, ${
            doc.getValueString("dueDateType")
        } : ${doc.getValueString("dueDate")}"""
        doc.setViewText(vt)
        doc.addViewText(doc.getValueString("text"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addReader(assignee.getUserID())
        doc.addEditor("[supervisor]")
    }
}
