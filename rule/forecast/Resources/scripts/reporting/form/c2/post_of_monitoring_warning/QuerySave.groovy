package reporting.form.c2.post_of_monitoring_warning

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("post-of-monitoring-warning")

        doc.addStringField("postType", webFormData.getValueSilently("postType"))
        doc.addStringField("name", webFormData.getValueSilently("name"))
        doc.addStringField("location", webFormData.getValueSilently("location"))
        doc.addStringField("appointment", webFormData.getValueSilently("appointment"))
        doc.addStringField("zoneResponsibility", webFormData.getValueSilently("zoneResponsibility"))

        doc.setViewText(doc.getValueString("name"))
        doc.addViewText(doc.getValueString("name"))
        doc.addViewText(doc.getValueString("postType"))
        doc.addViewText(doc.getValueString("location"))
        doc.addViewText(doc.getValueString("appointment"))
        doc.addViewText(doc.getValueString("zoneResponsibility"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor("[supervisor]")
    }
}
