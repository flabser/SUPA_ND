package supa_nd.plans_work.form.workplan

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        if (doc.isNewDoc) {
            doc.setForm("workplan")
        }

        def action = webFormData.getValue("_action");

        if (action == "move") {
            doMove(session, doc, webFormData)
        } else {
            doSave(session, doc, webFormData)
        }
    }

    private void doSave(_Session session, _Document doc, _WebFormData webFormData) {
        doc.addStringField("name", webFormData.getValue("name"))
        doc.addNumberField("index", webFormData.getNumberValueSilently("index"), 0)
        doc.setViewText(doc.getValueString("name"))
        doc.setViewNumber(doc.getValueNumber("index"))
    }

    private void doMove(_Session session, _Document doc, _WebFormData webFormData) {

    }
}
