package form.c2.human

import kz.nextbase.script.*
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        publishValue("title", "Human")

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть", lang), _ActionType.CLOSE))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        publishValue("title", "Human")

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть", lang), _ActionType.CLOSE))
        publishElement(actionBar)

        publishValue("fio", doc.getValueString("fio"))
        publishValue("sex", doc.getValueString("sex"))
        publishValue("age", doc.getValueNumber("age"))

        publishValue("isAffected", doc.getValueNumber("isAffected"))
        publishValue("isDead", doc.getValueNumber("isDead"))
        publishValue("isRescued", doc.getValueNumber("isRescued"))
        publishValue("isMissing", doc.getValueNumber("isMissing"))
        publishValue("isFoundBySearchRescue", doc.getValueNumber("isFoundBySearchRescue"))
        publishValue("isEvacuated", doc.getValueNumber("isEvacuated"))
        publishValue("isFirstAid", doc.getValueNumber("isFirstAid"))
        publishValue("isHomeless", doc.getValueNumber("isHomeless"))
    }
}
