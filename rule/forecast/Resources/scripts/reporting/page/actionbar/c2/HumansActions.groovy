package reporting.page.actionbar.c2

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._DoScript


class HumansActions extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {
        def actionBar = new _ActionBar(session);
        def user = session.getCurrentAppUser();
        if (true || user.hasRole(["administrator"])) {
            def newDocAction = new _Action(getLocalizedWord("Добавить", lang), getLocalizedWord("Добавить", lang), "new_document")
            newDocAction.setURL("Provider?type=edit&element=document&id=human&docid=")
            actionBar.addAction(newDocAction);
        }
        if (true || user.hasRole(["supervisor", "administrator", "chancellery"])) {
            actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang), getLocalizedWord("Удалить документ", lang), _ActionType.DELETE_DOCUMENT));
        }
        setContent(actionBar);
    }
}
