package ustp.modules.operational_plans_work.form.suggestion

import kz.flabs.util.Util
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
        doc.addDateField("dueDate", webFormData.getValue("dueDate"))

        def struct = session.getStructure();
        def assignee = struct.getEmployer(webFormData.getValue("assignee"));

        def vt = """${doc.getValueString("description")} > ${doc.getValueString("assignee")}, ${
            doc.getValueString("dueDate")
        }"""
        doc.setViewText(vt)
        doc.addViewText(doc.getValueString("description"))
        doc.addViewText(assignee.getFullName())
        doc.addViewText(assignee.getUserID())
        doc.setViewDate(Util.convertStringToDateTime(doc.getValueString("dueDate")))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addReader(assignee.getUserID())
        doc.addEditor("[supervisor]")
    }
}
