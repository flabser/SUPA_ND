package supa_nd.plans_work.form.suggestion

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

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "send"))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Согласовать", lang), "", "agree"))
        actionBar.addAction(new _Action(getLocalizedWord("Отклонить", lang), "", "reject"))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))
        publishElement(actionBar)

        publishValue("description", doc.getValueString("description"))
        publishEmployer("assignee", doc.getValueString("assignee"))
        // publishValue("assignee", doc.getValueString("assignee"))
        publishValue("dueDateType", doc.getValueString("dueDateType"))
        publishValue("dueDate", doc.getValueString("dueDate"))
        publishValue("sendMark", doc.getValueString("sendMark"))
    }
}
