package reporting.form.userprofile

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.constants._DocumentModeType
import kz.nextbase.script.events._FormQueryOpen

class QueryOpen extends _FormQueryOpen {

	
	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
			
	}


	@Override
	public void doQueryOpen(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
		
		def emp = ses.getCurrentAppUser()
		def nav = ses.getPage("outline", webFormData)
		publishElement(nav)
		
		def actionBar = new _ActionBar(ses)
		
		if(doc.getEditMode() == _DocumentModeType.EDIT){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)

		publishValue("title",getLocalizedWord("Сотрудник ", lang))
		publishValue("post", emp.getPostID(), emp.getPost())
		def dep = emp.getMainDepartment();
		publishValue("department", dep.getShortName())
		publishValue("userid",emp.getValueString("userid"))
		publishValue("countdocinview",emp.getValueString("countdocinview"))
		publishValue("lang",emp.getValueString("lang"))
		publishEmployer("skin",doc.getValueString("skin"))
		publishValue("email",doc.getValueString("email"))
		publishValue("shortname",emp.getValueString("shortname"))
		publishEmployer("fullname", emp.getUserID())
		publishValue("instmsgaddress",doc.getValueString("instmsgaddress"))
		publishValue("group", emp.getListOfGroups())
		publishValue("role", emp.getListOfRoles())
	}

}