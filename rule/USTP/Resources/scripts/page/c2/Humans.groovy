package page.c2

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat


class Humans extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {
        def page = formData.getNumberValueSilently("page", 1)

        def eventId = formData.getValue("event_id")
        def formula = "form='human' and parentdocddbid='$eventId'"

        def db = session.getCurrentDatabase()
        def col = db.getCollectionOfDocuments(formula, page, true, true, new SimpleDateFormat("dd.MM.yyyy"))

        setContent(col)
    }
}