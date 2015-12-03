package ustp.modules.operational_plans_work.form.suggestion

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("suggestion")

        doc.addStringField("description", webFormData.getValue("description"))
        doc.addStringField("assignee", webFormData.getValue("assignee"))
        doc.addStringField("dueDateType", webFormData.getValue("dueDateType"))
        doc.addStringField("dueDate", webFormData.getValueSilently("dueDate"))
        doc.addStringField("sendMark", webFormData.getValueSilently("sendMark"))

        def struct = session.getStructure();
        def assignee = struct.getEmployer(webFormData.getValue("assignee"));

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
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addReader(assignee.getUserID())
        doc.addEditor("[supervisor]")
    }
}
