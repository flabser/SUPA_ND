package supa_nd.plans_work.form.workplan

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar()
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", _ActionType.SAVE_AND_CLOSE))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar()
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", _ActionType.SAVE_AND_CLOSE))
        publishElement(actionBar)
        //
        publishValue("name", doc.getValueString("name"))
    }
}
