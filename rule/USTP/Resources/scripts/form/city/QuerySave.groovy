package form.city

import java.text.SimpleDateFormat
import java.util.Map
import kz.nextbase.script.*
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
		glos.setForm("city")
		glos.setName(webFormData.getValue("name"))
		glos.setCode(webFormData.getValue("code"))
		doc.setValueNumber("region",webFormData.getNumberValueSilently("region",0));
		glos.setViewText(glos.getName())
		glos.addViewText(glos.getCode())
		glos.addViewText(webFormData.getNumberValueSilently("region",0))
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
		}else if (webFormData.getValueSilently("region") == ""){
			localizedMsgBox("Поле \"Область\" не заполнено")
			return false
		}


		return true;
	}
}
