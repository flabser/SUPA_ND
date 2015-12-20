package reporting.page.c2

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript


class DomesticAnimals extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def eventId = formData.getValueSilently("event_id")
        def viewParam = session.createViewEntryCollectionParam()
        viewParam.setQuery("form = 'domestic-animal'")
                .setPageNum(0)
                .setPageSize(0)
                .setCheckResponse(false)

        def col = session.getCurrentDatabase().getCollectionOfDocuments(viewParam)
        setContent(col)
    }
}
