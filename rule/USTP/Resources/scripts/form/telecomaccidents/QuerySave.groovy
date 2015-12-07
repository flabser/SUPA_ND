package form.telecomaccidents

import kz.nextbase.script._Document
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

		doc.setForm("telecomaccidents")
		doc.addStringField("author", webFormData.getValueSilently("author"))
		doc.addStringField("esgroup", webFormData.getValueSilently("esgroup"))
		doc.addStringField("carddate", webFormData.getValueSilently("carddate"))
		doc.addStringField("cardnumber", webFormData.getValueSilently("cardnumber"))
		doc.addStringField("escode", webFormData.getValueSilently("escode"))
		doc.addNumberField("essubtype", webFormData.getNumberValueSilently("essubtype",-1))
		doc.addNumberField("region", webFormData.getNumberValueSilently("region",-1))
		doc.addNumberField("respcity", webFormData.getNumberValueSilently("respcity",-1))
		doc.addNumberField("city", webFormData.getNumberValueSilently("city",-1))
		doc.addStringField("esbriefcontent", webFormData.getValueSilently("esbriefcontent"))
		doc.addStringField("esdate", webFormData.getValueSilently("esdate"))
		doc.addStringField("district", webFormData.getValueSilently("district"))
		doc.addStringField("villagedistrict", webFormData.getValueSilently("villagedistrict"))
		doc.addStringField("settlement", webFormData.getValueSilently("settlement"))
		doc.addStringField("village", webFormData.getValueSilently("village"))
		doc.addStringField("aul", webFormData.getValueSilently("aul"))
		doc.addStringField("avenue", webFormData.getValueSilently("avenue"))
		doc.addStringField("street", webFormData.getValueSilently("street"))
		doc.addStringField("microdistrict", webFormData.getValueSilently("microdistrict"))
		doc.addStringField("lane", webFormData.getValueSilently("lane"))
		doc.addStringField("house", webFormData.getValueSilently("house"))
		doc.addStringField("housing", webFormData.getValueSilently("housing"))
		doc.addStringField("roadstretch", webFormData.getValueSilently("roadstretch"))
		doc.addStringField("railwaystretch", webFormData.getValueSilently("railwaystretch"))
		doc.addStringField("airport", webFormData.getValueSilently("airport"))
		doc.addStringField("airdrome", webFormData.getValueSilently("airdrome"))
		doc.addStringField("infosource", webFormData.getValueSilently("infosource"))
		doc.addStringField("infosourcedetail", webFormData.getValueSilently("infosourcedetail"))
		doc.addStringField("f1n37_2", webFormData.getValueSilently("f1n37_2"))
		doc.addStringField("f1n37_3", webFormData.getValueSilently("f1n37_3"))
		doc.addStringField("f1n37_4", webFormData.getValueSilently("f1n37_4"))
		doc.addStringField("f1n37_5", webFormData.getValueSilently("f1n37_5"))
		doc.addStringField("f1n37_6", webFormData.getValueSilently("f1n37_6"))
		doc.addStringField("f1n38", webFormData.getValueSilently("f1n38"))
		doc.addStringField("f1n39", webFormData.getValueSilently("f1n39"))
		doc.addStringField("f1n40", webFormData.getValueSilently("f1n40"))
		doc.addStringField("f2n20", webFormData.getValueSilently("f2n20"))
		doc.addStringField("f2n21", webFormData.getValueSilently("f2n21"))
		doc.addStringField("f2n22", webFormData.getValueSilently("f2n22"))
		doc.addStringField("f2n23", webFormData.getValueSilently("f2n23"))
		doc.addStringField("f2n24", webFormData.getValueSilently("f2n24"))
		doc.addStringField("f2n25", webFormData.getValueSilently("f2n25"))
		doc.addStringField("f2n26", webFormData.getValueSilently("f2n26"))
		doc.addStringField("f2n27", webFormData.getValueSilently("f2n27"))
		doc.addStringField("f2n28", webFormData.getValueSilently("f2n28"))
		doc.addStringField("f2n29", webFormData.getValueSilently("f2n29"))
		doc.addStringField("f2n30", webFormData.getValueSilently("f2n30"))
		doc.addStringField("f2n31", webFormData.getValueSilently("f2n31"))
		doc.addStringField("f2n32", webFormData.getValueSilently("f2n32"))
		doc.addStringField("f2n32_2", webFormData.getValueSilently("f2n32_2"))
		doc.addStringField("f2n32_3", webFormData.getValueSilently("f2n32_3"))
		doc.addStringField("f2n32_4", webFormData.getValueSilently("f2n32_4"))
		doc.addStringField("f2n32_5", webFormData.getValueSilently("f2n32_5"))
		doc.addStringField("f2n32_6", webFormData.getValueSilently("f2n32_6"))
		doc.addStringField("f2n32_7", webFormData.getValueSilently("f2n32_7"))
		doc.addStringField("f2n32_8", webFormData.getValueSilently("f2n32_8"))
		doc.addStringField("f2n32_9", webFormData.getValueSilently("f2n32_9"))
		doc.addStringField("f2n32_10", webFormData.getValueSilently("f2n32_10"))
		doc.addStringField("f2n33", webFormData.getValueSilently("f2n33"))
		doc.addStringField("f2n34", webFormData.getValueSilently("f2n34"))
		doc.addStringField("f1n65", webFormData.getValueSilently("f1n65"))
		doc.addStringField("f2n36", webFormData.getValueSilently("f2n36"))
		doc.addStringField("f2n37", webFormData.getValueSilently("f2n37"))
		doc.addStringField("f2n37_2", webFormData.getValueSilently("f2n37_2"))
		doc.addStringField("f2n38_2", webFormData.getValueSilently("f2n38_2"))
		doc.addStringField("f2n38_3", webFormData.getValueSilently("f2n38_3"))
		doc.addStringField("f2n38_4", webFormData.getValueSilently("f2n38_4"))
		doc.addStringField("f2n38_5", webFormData.getValueSilently("f2n38_5"))
		doc.addStringField("f2n39", webFormData.getValueSilently("f2n39"))
		doc.addStringField("f2n40", webFormData.getValueSilently("f2n40"))
		doc.addStringField("f2n41", webFormData.getValueSilently("f2n41"))
		doc.addStringField("f1n42_2", webFormData.getValueSilently("f1n42_2"))
		doc.addStringField("f1n43_2", webFormData.getValueSilently("f1n43_2"))
		doc.addStringField("f1n43", webFormData.getValueSilently("f1n43"))
		doc.addStringField("f1n44", webFormData.getValueSilently("f1n44"))
		doc.addStringField("f1n45", webFormData.getValueSilently("f1n45"))
		doc.addStringField("f1n46", webFormData.getValueSilently("f1n46"))
		doc.addStringField("f1n47", webFormData.getValueSilently("f1n47"))
		doc.addStringField("f1n48", webFormData.getValueSilently("f1n48"))
		doc.addStringField("f1n48_2", webFormData.getValueSilently("f1n48_2"))
		doc.addStringField("f1n48_3", webFormData.getValueSilently("f1n48_3"))
		doc.addStringField("f1n49", webFormData.getValueSilently("f1n49"))
		doc.addStringField("f1n73", webFormData.getValueSilently("f1n73"))
		doc.addStringField("f1n74", webFormData.getValueSilently("f1n74"))
		doc.addStringField("f1n75", webFormData.getValueSilently("f1n75"))
		doc.addStringField("f1n75_2", webFormData.getValueSilently("f1n75_2"))
		doc.addStringField("f1n76", webFormData.getValueSilently("f1n76"))
		doc.addStringField("f1n77", webFormData.getValueSilently("f1n77"))
		doc.addStringField("f1n78", webFormData.getValueSilently("f1n78"))
		doc.addStringField("f1n79", webFormData.getValueSilently("f1n79"))
		doc.addStringField("f1n80", webFormData.getValueSilently("f1n80"))
		doc.addStringField("f1n81", webFormData.getValueSilently("f1n81"))
		doc.addStringField("f1n82", webFormData.getValueSilently("f1n82"))
		doc.addStringField("f1n83", webFormData.getValueSilently("f1n83"))
		doc.addStringField("f1n84", webFormData.getValueSilently("f1n84"))

		def returnURL = session.getURLOfLastPage()
		if (doc.isNewDoc){
			returnURL.changeParameter("page", "0")
			def db = session.getCurrentDatabase()
			int num = db.getRegNumber('telecomaccidents')
			String vnAsText = Integer.toString(num)
			doc.replaceStringField("cardnumber", vnAsText)
			localizedMsgBox(getLocalizedWord("Документ зарегистрирован под № ",lang) + vnAsText)
		}

		
		def struct = session.getStructure();
		def author_fullname = struct.getEmployer(webFormData.getValue("author")).getFullName();
		doc.addEditor(webFormData.getValue("author"))
		def essubtype = session.getCurrentDatabase().getGlossaryDocument(webFormData.getValueSilently("essubtype").toInteger());
		def essubtype_viewtext = essubtype.getName();
		doc.setViewText(webFormData.getValueSilently("carddate") + " " +  author_fullname + " : " + webFormData.getValueSilently("esdate") +" "+ essubtype_viewtext ) //0
		doc.setViewDate(new Date());
		setRedirectURL(returnURL)
	}



	def validate(_WebFormData webFormData){

		/*if (webFormData.getSizeOfField("executor") == 0){
			localizedMsgBox("Не выбраны исполнители задания")
			return false
		}else if (webFormData.getValueSilently("project") == ""){
			localizedMsgBox("Поле \"Связан с проектом\" не указано")
			return false
		}else if (webFormData.getValueSilently("category") == ""){
			localizedMsgBox("Поле \"Категория\" не указано")
			return false
		}else if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Краткое содержание\" не заполнено")
			return false
		}else if (webFormData.getValueSilently("primaryctrldate") == ""){
			localizedMsgBox("Поле \"Срок исполнения\" не заполнено")
			return false
		}else if (!_Validator.checkDate(webFormData.getValueSilently("primaryctrldate"))){
			localizedMsgBox("Поле \"Срок исполнения\" заполнено неверно")
			return false
		}else if (webFormData.getValueSilently("controltype") == ""){
			localizedMsgBox("Поле \"Тип контроля\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('briefcontent').length() > 2046){
			localizedMsgBox('Поле \'Краткое содержание\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently('comment').length() > 2046){
			localizedMsgBox('Поле \'Примечание\' содержит значение превышающее 2046 символов');
			return false;
		}
        if (webFormData.getValueSilently("project") == "" || !webFormData.containsField("project")){
            localizedMsgBox("Поле \"Связан с проектом\" не выбрано.")
            return false
        }*/
		return true;
	}

}
