package form.c2.geophysical_201

import kz.nextbase.script.*
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("geophysical-201")

        doc.addStringField("card_number", webFormData.getValue("card_number"))
        doc.addStringField("card_date", webFormData.getValue("card_date"))
        doc.addStringField("emergency_code", webFormData.getValue("emergency_code"))
        doc.addStringField("emergency_type", webFormData.getValue("emergency_type"))
        doc.addStringField("emergency_date", webFormData.getValue("emergency_date"))
        doc.addStringField("short_description", webFormData.getValue("short_description"))
        doc.addStringField("incident_place", webFormData.getValue("incident_place"))
        doc.addStringField("coordinates", webFormData.getValue("coordinates"))

        doc.setViewText(doc.getValueString("card_number"))
        doc.addViewText(doc.getValueString("card_number"))
        doc.addViewText(doc.getValueString("card_date"))
        doc.addViewText(doc.getValueString("emergency_code"))
        doc.addViewText(doc.getValueString("emergency_type"))
        doc.addViewText(doc.getValueString("emergency_date"))
        doc.addViewText(doc.getValueString("short_description"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor("[supervisor]")
        //
        setRedirectURL(session.getURLOfLastPage())
    }
}
