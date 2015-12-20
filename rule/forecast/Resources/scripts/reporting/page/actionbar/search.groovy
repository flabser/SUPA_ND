package reporting.page.actionbar

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.events._DoScript

class search extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		//println(formData)

		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		def newDocAction = new _Action(getLocalizedWord("Вернуться к списку документов", lang),getLocalizedWord("Вернуться к списку документов", lang),"custom")
		newDocAction.setURL(session.getURLOfLastPage().urlAsString)
		actionBar.addAction(newDocAction);			
		setContent(actionBar);
	}
}




