package form.essubtype

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
		glos.setForm("estype")
		glos.setName(webFormData.getValue("name"))
		glos.setCountry(webFormData.getValue("country"))
		glos.setCode(webFormData.getValue("code"))
		glos.setRank(webFormData.getValue("rank"))

		glos.setViewText(glos.getName())
		glos.addViewText(glos.getCode())
		glos.addViewText(glos.getValueString("country"))
		def returnURL = session.getURLOfLastPage()
		if (doc.isNewDoc) {
			returnURL.changeParameter("page", "0");
		}
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("name") == ""){
			localizedMsgBox("Поле \"Регион/Город\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('name').length() > 2046){
			localizedMsgBox('Поле \'Регион/Город\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("code") == ""){
			localizedMsgBox("Поле \"Код\" не заполнено")
			return false
		}else if (webFormData.getValueSilently("rank") == ""){
			localizedMsgBox("Поле \"Ранг\" не заполнено")
			return false
		}else if (webFormData.getValueSilently("country") == ""){
			localizedMsgBox("Поле \"Страна\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('country').length() > 2046){
			localizedMsgBox('Поле \'Страна\' содержит значение превышающее 2046 символов');
			return false;
		}


		return true;
	}
}
