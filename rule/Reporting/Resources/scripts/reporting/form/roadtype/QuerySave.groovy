package reporting.form.roadtype

import kz.nextbase.script._Document
import kz.nextbase.script._Glossary
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

		println(webFormData)

		boolean v = validate(webFormData);
		if(v == false){
			stopSave()
			return;
		}

		def glos = (_Glossary)doc;
		glos.setForm("roadtype")
		glos.setName(webFormData.getValue("name"))
		glos.setCode(webFormData.getValue("code"))

		glos.setViewText(glos.getName())
		glos.addViewText(glos.getCode())
		def returnURL = session.getURLOfLastPage()
		if (doc.isNewDoc) {
			returnURL.changeParameter("page", "0");
		}
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("name") == ""){
			localizedMsgBox("Поле \"Тип дороги\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('name').length() > 2046){
			localizedMsgBox('Поле \'Тип дороги\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("code") == ""){
			localizedMsgBox("Поле \"Код\" не заполнено")
			return false
		}

		return true;
	}
}
