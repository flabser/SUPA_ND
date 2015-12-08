package supa_nd.plans_work.form.comment

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQueryOpen


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {}

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        // if is new
        publishValue("text", doc.getValueString("text"))
        publishEmployer("author", doc.getValueString("author"))
        publishValue("reg_date", doc.getRegDate())
    }
}
