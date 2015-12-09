package supa_nd.plans_work.form.event

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQueryOpen


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {}

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        publishValue("event_type", doc.getValueString("event_type"))
        publishEmployer("author", doc.getAuthorID())
        publishValue("created_at", doc.getRegDate())

    }
}
