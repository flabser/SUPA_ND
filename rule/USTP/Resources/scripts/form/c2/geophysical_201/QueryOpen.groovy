package form.c2.geophysical_201

import kz.nextbase.script.*
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.constants._DocumentModeType
import kz.nextbase.script.events._FormQueryOpen
import kz.nextbase.script.task._Control
import kz.pchelka.env.Environment


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        publishValue("title", getLocalizedWord("Опасные геофизические явления", lang))

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть", lang), _ActionType.CLOSE))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        publishValue("title", getLocalizedWord("Опасные геофизические явления", lang))

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть", lang), _ActionType.CLOSE))
        publishElement(actionBar)

        publishValue("card_number", doc.getValueString("card_number"))
        publishValue("card_date", doc.getValueString("card_date"))
    }
}
