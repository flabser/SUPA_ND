package supa_nd.plans_work.page

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.events._DoScript


class Workplans extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def actionBar = new _ActionBar(session);
        def newDocAction = new _Action(getLocalizedWord("Добавить", lang), "", "add_workplan")
        newDocAction.setURL("Provider?type=edit&element=document&id=workplan&docid=")
        actionBar.addAction(newDocAction)

        def viewParam = session.createViewEntryCollectionParam()
        viewParam.setQuery("form = 'workplan'")
                .setPageNum(formData.getNumberValueSilently("page", 1))
                .setCheckResponse(true)
        def col = session.getCurrentDatabase().getCollectionOfGlossaries(viewParam)

        setContent(actionBar)
        setContent(col)
    }
}
