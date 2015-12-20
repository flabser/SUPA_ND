package reporting.form.city

import kz.nextbase.script._Document
import kz.nextbase.script._Glossary
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen

class QueryOpen extends _FormQueryOpen{

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Город", lang))
		publishGlossaryValue("region",webFormData.getNumberValueSilently("parentdocid",0))
		def nav = session.getPage("outline", webFormData)
		publishElement(nav)
		publishElement(getActionBar(session))
	}


	@Override
	public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		def glos = (_Glossary)doc
		publishValue("title",getLocalizedWord("Город", lang) + ":" + glos.getViewText())
		publishEmployer("author",glos.getAuthorID())
		publishValue("name",glos.getName())
		publishGlossaryValue("region", doc.getValueInt("region"))
		publishValue("code", glos.getCode())

		
		def nav = session.getPage("outline", webFormData)
		publishElement(nav)
		publishElement(getActionBar(session))
	}

	private getActionBar(_Session session){
		def actionBar = new _ActionBar(session)

		def user = session.getCurrentAppUser()
		if (user.hasRole("administrator")){
			actionBar.addAction(new _Action("Сохранить и закрыть","Сохранить и закрыть",_ActionType.SAVE_AND_CLOSE))
		}
		actionBar.addAction(new _Action("Закрыть","Закрыть без сохранения",_ActionType.CLOSE))
		return actionBar

	}

}