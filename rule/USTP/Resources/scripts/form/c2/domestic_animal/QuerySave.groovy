package form.c2.domestic_animal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("domestic-animal")

        doc.addStringField("animalType", webFormData.getValueSilently("animalType"))
        doc.addNumberField("deadCount", webFormData.getNumberValueSilently("deadCount", 0))
        doc.addNumberField("evacueesCount", webFormData.getNumberValueSilently("evacueesCount", 0))

        doc.setViewText(doc.getValueString("animalType"))
        doc.addViewText(doc.getValueString("animalType"))
        doc.addViewText(doc.getValueString("deadCount"))
        doc.addViewText(doc.getValueString("evacueesCount"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor("[supervisor]")
    }
}
