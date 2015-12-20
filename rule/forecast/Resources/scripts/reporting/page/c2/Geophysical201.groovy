package reporting.page.c2

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat


class Geophysical201 extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def viewParam = session.createViewEntryCollectionParam()
        viewParam.setQuery("form = 'geophysical-201'")
                .setPageNum(formData.getNumberValueSilently("page", 1))
                .setCheckResponse(false)
                .setDateFormat(new SimpleDateFormat("dd.MM.yyyy"))

        def col = session.getCurrentDatabase().getCollectionOfDocuments(viewParam)
        setContent(col)
    }
}
