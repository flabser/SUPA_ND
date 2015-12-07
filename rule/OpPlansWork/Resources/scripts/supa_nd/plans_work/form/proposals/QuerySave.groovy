package supa_nd.plans_work.form.proposals

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("proposals")

        doc.addStringField("title", webFormData.getValue("title"))

        doc.setViewText(doc.getValueString("title"))
        doc.addViewText(doc.getValueString("title"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor("[supervisor]")
    }
}
