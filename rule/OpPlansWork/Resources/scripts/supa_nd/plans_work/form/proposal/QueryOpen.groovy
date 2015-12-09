package supa_nd.plans_work.form.proposal

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
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", "save"))
        actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "coordination"))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar()
        actionBar.addAction(new _Action(getLocalizedWord("Согласен", lang), "", "agree"))
        actionBar.addAction(new _Action(getLocalizedWord("На доработку", lang), "", "revision"))
        actionBar.addAction(new _Action(getLocalizedWord("Исключить", lang), "", "reject"))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))
        publishElement(actionBar)

        publishValue("description", doc.getValueString("description"))
        publishEmployer("assignee", doc.getValueString("assignee"))
        publishValue("dueDateType", doc.getValueString("dueDateType"))
        publishValue("dueDate", doc.getValueString("dueDate"))
        publishValue("status", doc.getValueString("status"))
    }
}
