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

        doc.addStringField("name", webFormData.getValue("name"))
        doc.setViewText(doc.getValueString("name"))
    }
}
