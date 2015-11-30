package form.c2.first_aider

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("first-aider")

        doc.addStringField("name", webFormData.getValue("name"))
        doc.addStringField("address", webFormData.getValue("address"))
        doc.addStringField("phone", webFormData.getValue("phone"))
        doc.addStringField("details", webFormData.getValue("details"))

        doc.setViewText(doc.getValueString("name"))
        doc.addViewText(doc.getValueString("name"))
        doc.addViewText(doc.getValueString("address"))
        doc.addViewText(doc.getValueString("phone"))
        doc.addViewText(doc.getValueString("details"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor("[supervisor]")
    }
}
