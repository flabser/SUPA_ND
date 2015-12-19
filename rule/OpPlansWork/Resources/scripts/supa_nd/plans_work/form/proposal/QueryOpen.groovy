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

        def currentCoordinator
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        if (blockCollection.hasCoordination()) {
            def block = blockCollection.currentBlock
            currentCoordinator = (_Coordinator) block.currentCoordinators[0]
        }
        //
        boolean hasEditAccess = doc.editors.contains(session.user.userID)
        boolean isCurrentCoordinator = currentCoordinator?.userID == session.user.userID
        //
        def actionBar = session.createActionBar()
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), "", _ActionType.CLOSE))

        def status = doc.getValueString("status")
        if (status == "draft") {
            if (hasEditAccess) {
                actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", "save"))
                actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "coord_start"))
            }
        } else if (status == "coordination") {
            if (isCurrentCoordinator) {
                actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", "save"))
                actionBar.addAction(new _Action(getLocalizedWord("На доработку", lang), "", "coord_revision"))
                actionBar.addAction(new _Action(getLocalizedWord("Исключить", lang), "", "coord_reject"))
                actionBar.addAction(new _Action(getLocalizedWord("Согласовать", lang), "", "coord_agree"))
            }
        } else if (status == "revision") {
            if (hasEditAccess) {
                actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", "save"))
                actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "coord_start"))
            }
        } else if (status == "reject") {
            if (hasEditAccess) {
                actionBar.addAction(new _Action(getLocalizedWord("Сохранить", lang), "", "save"))
                actionBar.addAction(new _Action(getLocalizedWord("Отправить на согласование", lang), "", "coord_start"))
            }
        } else if (status == "coordinated") {
            //
        }

        publishElement(actionBar)
        //
        publishValue("description", doc.getValueString("description"))
        publishEmployer("assignee", doc.getValueString("assignee"))
        publishDepartment("assigneeDepartment", doc.getValueNumber("assigneeDepartment"))
        publishValue("dueDateType", doc.getValueString("dueDateType"))
        publishValue("dueDate", doc.getValueString("dueDate"))
        publishValue("status", status)
        publishValue("coordination", blockCollection)
        publishValue("coordinationDirection", doc.getValueString("coordinationDirection"))
        publishGlossaryValue("workPlan", doc.getValueString("workPlan"))
        //
        publishEmployer("author", doc.authorID)
        publishDepartment("authorDepartment", doc.getValueNumber("authorDepartment"))
        publishValue("createdAt", doc.regDate)
    }
}
