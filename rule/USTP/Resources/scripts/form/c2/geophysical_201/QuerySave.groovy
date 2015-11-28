package form.c2.geophysical_201

import kz.nextbase.script.*
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("geophysical-201")

        doc.addStringField("card_number", webFormData.getValue("card_number"))
        doc.addStringField("card_date", webFormData.getValue("card_date"))

        def returnURL = session.getURLOfLastPage()

        doc.setViewText(doc.getValueString("card_number"))
        doc.addViewText(doc.getValueString("card_number"))
        doc.addViewText(doc.getValueString("card_date"))
        //
        doc.addEditor(session.getUser().getUserID())

        setRedirectURL(returnURL)
    }
}
