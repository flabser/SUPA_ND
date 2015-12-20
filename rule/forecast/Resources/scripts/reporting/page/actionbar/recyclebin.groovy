package reporting.page.actionbar

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.events._DoScript

class recyclebin extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		if (user.hasRole(["supervisor","administrator","chancellery"])){
			actionBar.addAction(new _Action(getLocalizedWord("Удалить из корзины", lang),getLocalizedWord("Удалить из корзины", lang),"CLEAR_RECYCLEBIN"));
			actionBar.addAction(new _Action(getLocalizedWord("Восстановить документ", lang),getLocalizedWord("Восстановить документ", lang),"RECOVER_RECYCLEBIN"));
		}
		setContent(actionBar);
	}
}

