package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.coordination._Coordinator
import kz.nextbase.script.events._FormQueryOpen


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar()
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", "save"))
        actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "coord_start"))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def coordinator
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        if (blockCollection.hasCoordination()) {
            def block = blockCollection.currentBlock
            coordinator = (_Coordinator) block.currentCoordinators[0]
        }
        //
        boolean hasEditAccess = doc.editors.contains(session.user.userID)
        boolean isCurrentCoordinator = coordinator && coordinator.userID == session.user.userID
        //
        def actionBar = session.createActionBar()
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))

        if (isCurrentCoordinator || hasEditAccess) {
            actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", "save"))
        }

        def status = doc.getValueString("status")
        if (status == "coordination") {
            if (isCurrentCoordinator) {
                actionBar.addAction(new _Action(getLocalizedWord("На доработку", lang), "", "coord_revision"))
                actionBar.addAction(new _Action(getLocalizedWord("Исключить", lang), "", "coord_reject"))
                actionBar.addAction(new _Action(getLocalizedWord("Отправить", lang), "", "coord_agree"))
            }
        } else {
            actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "coord_start"))
        }

        publishElement(actionBar)
        //
        publishValue("description", doc.getValueString("description"))
        publishEmployer("assignee", doc.getValueString("assignee"))
        publishDepartment("department", Integer.valueOf(doc.getValueString("department")))
        publishValue("dueDateType", doc.getValueString("dueDateType"))
        publishValue("dueDate", doc.getValueString("dueDate"))
        publishValue("status", status)
        publishValue("coordination", blockCollection)
        publishValue("coordination_direction", doc.getValueString("coordination_direction"))
        publishEmployer("author", doc.authorID)
        publishValue("created_at", doc.regDate)
        //
        def history = session.getPage("proposal-events", webFormData)
        publishElement(history)
    }
}
