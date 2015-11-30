package form.c2.risk_zone

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("risk-zone")

        doc.addStringField("riskType", webFormData.getValueSilently("riskType"))
        doc.addStringField("coordinates", webFormData.getValueSilently("coordinates"))
        doc.addStringField("distance", webFormData.getValueSilently("distance"))

        doc.setViewText(doc.getValueString("riskType"))
        doc.addViewText(doc.getValueString("riskType"))
        doc.addViewText(doc.getValueString("coordinates"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor("[supervisor]")
    }
}
