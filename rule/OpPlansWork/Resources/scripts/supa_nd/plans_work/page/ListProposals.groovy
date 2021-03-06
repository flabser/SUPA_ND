package supa_nd.plans_work.page

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat


class ListProposals extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def actionBar = new _ActionBar(session);
        def newDocAction = new _Action(getLocalizedWord("Добавить", lang), "", "add_proposal")
        newDocAction.setURL("Provider?type=edit&element=document&id=proposal&docid=")
        actionBar.addAction(newDocAction)
        actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "coord_start"))
        actionBar.addAction(new _Action(getLocalizedWord("На доработку", lang), "", "coord_revision"))
        actionBar.addAction(new _Action(getLocalizedWord("Исключить", lang), "", "coord_reject"))
        actionBar.addAction(new _Action(getLocalizedWord("Согласовать", lang), "", "coord_agree"))

        def viewParam = session.createViewEntryCollectionParam()
        viewParam.setQuery("form = 'proposal' & viewtext7 != 'coordinated'")
                .setPageNum(formData.getNumberValueSilently("page", 1))
                .setCheckResponse(false)
                .setDateFormat(new SimpleDateFormat("dd.MM.yyyy"))
        def col = session.getCurrentDatabase().getCollectionOfDocuments(viewParam)

        setContent(actionBar)
        setContent(col)
    }
}
