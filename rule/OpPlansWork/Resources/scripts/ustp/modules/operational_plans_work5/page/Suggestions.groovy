package ustp.modules.operational_plans_work5.page

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat


class Suggestions extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def actionBar = new _ActionBar(session);
        def newDocAction = new _Action(getLocalizedWord("Новое предложение", lang), "", "new_document")
        newDocAction.setURL("Provider?type=edit&element=document&id=suggestion&docid=")
        actionBar.addAction(newDocAction);
        actionBar.addAction(new _Action(getLocalizedWord("Удалить", lang), "", _ActionType.DELETE_DOCUMENT));

        //
        def viewParam = session.createViewEntryCollectionParam()
        viewParam.setQuery("form = 'suggestion'")
                .setPageNum(formData.getNumberValueSilently("page", 1))
                .setCheckResponse(false)
                .setDateFormat(new SimpleDateFormat("dd.MM.yyyy"))
        def col = session.getCurrentDatabase().getCollectionOfDocuments(viewParam)

        //
        def content = []
        content << actionBar
        content << col
        setContent(content)
    }
}
