package reporting.form.forecast

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

		doc.setForm("transportaccident")
		doc.addStringField("author", webFormData.getValueSilently("author"))
		doc.addStringField("esgroup", webFormData.getValueSilently("esgroup"))
		doc.addStringField("carddate", webFormData.getValueSilently("carddate"))
		doc.addStringField("cardnumber", webFormData.getValueSilently("cardnumber"))
		doc.addStringField("escode", webFormData.getValueSilently("escode"))
       // doc.setRichText("content", webFormData.getValue("content"));
		doc.addNumberField("essubtype", webFormData.getNumberValueSilently("essubtype",-1))
		doc.addNumberField("region", webFormData.getNumberValueSilently("region",-1))
		doc.addNumberField("respcity", webFormData.getNumberValueSilently("respcity",-1))
		doc.addNumberField("city", webFormData.getNumberValueSilently("city",-1))
		//doc.addFile("rtfcontent", webFormData)
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
		doc.addStringField("referencepoint", webFormData.getValueSilently("referencepoint"))
		doc.addStringField("distance", webFormData.getValueSilently("distance"))
		doc.addStringField("coordinats", webFormData.getValueSilently("coordinats"))
		doc.addStringField("roadtype", webFormData.getValueSilently("roadtype"))
		doc.addStringField("busstation", webFormData.getValueSilently("busstation"))
		doc.addStringField("railways", webFormData.getValueSilently("railways"))
		doc.addStringField("airterminal", webFormData.getValueSilently("airterminal"))
		doc.addStringField("seaport", webFormData.getValueSilently("seaport"))
		doc.addStringField("route", webFormData.getValueSilently("route"))
		doc.addStringField("f1n15", webFormData.getValueSilently("f1n15"))
		doc.addStringField("f1n15_2", webFormData.getValueSilently("f1n15_2"))
		doc.addStringField("departdate", webFormData.getValueSilently("departdate"))
		doc.addStringField("departtime", webFormData.getValueSilently("departtime"))
		doc.addStringField("arrivaldate", webFormData.getValueSilently("arrivaldate"))
		doc.addStringField("arrivaltime", webFormData.getValueSilently("arrivaltime"))
		doc.addStringField("f1n20", webFormData.getValueSilently("f1n20"))
		doc.addStringField("f1n21", webFormData.getValueSilently("f1n21"))
		doc.addStringField("f1n21_2", webFormData.getValueSilently("f1n21_2"))
		doc.addStringField("f1n22", webFormData.getValueSilently("f1n22"))
		doc.addStringField("f1n23", webFormData.getValueSilently("f1n23"))
		doc.addStringField("f1n23_5", webFormData.getValueSilently("f1n23_5"))
		doc.addStringField("f1n23_2", webFormData.getValueSilently("f1n23_2"))
		doc.addStringField("f1n23_3", webFormData.getValueSilently("f1n23_3"))
		doc.addStringField("f1n23_4", webFormData.getValueSilently("f1n23_4"))
		doc.addStringField("f1n24", webFormData.getValueSilently("f1n24"))
		doc.addStringField("f1n24_5", webFormData.getValueSilently("f1n24_5"))
		doc.addStringField("f1n24_2", webFormData.getValueSilently("f1n24_2"))
		doc.addStringField("f1n24_3", webFormData.getValueSilently("f1n24_3"))
		doc.addStringField("f1n24_4", webFormData.getValueSilently("f1n24_4"))
		doc.addStringField("f1n25", webFormData.getValueSilently("f1n25"))
		doc.addStringField("f1n25_5", webFormData.getValueSilently("f1n25_5"))
		doc.addStringField("f1n25_2", webFormData.getValueSilently("f1n25_2"))
		doc.addStringField("f1n25_3", webFormData.getValueSilently("f1n25_3"))
		doc.addStringField("f1n25_4", webFormData.getValueSilently("f1n25_4"))
		doc.addStringField("f1n26", webFormData.getValueSilently("f1n26"))
		doc.addStringField("f1n26_5", webFormData.getValueSilently("f1n26_5"))
		doc.addStringField("f1n26_2", webFormData.getValueSilently("f1n26_2"))
		doc.addStringField("f1n26_3", webFormData.getValueSilently("f1n26_3"))
		doc.addStringField("f1n26_4", webFormData.getValueSilently("f1n26_4"))
		doc.addStringField("f1n27", webFormData.getValueSilently("f1n27"))
		doc.addStringField("f1n27_2", webFormData.getValueSilently("f1n27_2"))
		doc.addStringField("f1n27_3", webFormData.getValueSilently("f1n27_3"))
		doc.addStringField("f1n27_4", webFormData.getValueSilently("f1n27_4"))
		doc.addStringField("f1n27_5", webFormData.getValueSilently("f1n27_5"))
		doc.addStringField("f1n28", webFormData.getValueSilently("f1n28"))
		doc.addStringField("f1n29", webFormData.getValueSilently("f1n29"))
		doc.addStringField("f1n29_5", webFormData.getValueSilently("f1n29_5"))
		doc.addStringField("f1n29_2", webFormData.getValueSilently("f1n29_2"))
		doc.addStringField("f1n29_3", webFormData.getValueSilently("f1n29_3"))
		doc.addStringField("f1n29_4", webFormData.getValueSilently("f1n29_4"))
		doc.addStringField("f1n30", webFormData.getValueSilently("f1n30"))
		doc.addStringField("f1n30_5", webFormData.getValueSilently("f1n30_5"))
		doc.addStringField("f1n30_2", webFormData.getValueSilently("f1n30_2"))
		doc.addStringField("f1n30_3", webFormData.getValueSilently("f1n30_3"))
		doc.addStringField("f1n30_4", webFormData.getValueSilently("f1n30_4"))
		doc.addStringField("f1n31", webFormData.getValueSilently("f1n31"))
		doc.addStringField("f1n32", webFormData.getValueSilently("f1n32"))
		doc.addStringField("f1n32_5", webFormData.getValueSilently("f1n32_5"))
		doc.addStringField("f1n32_2", webFormData.getValueSilently("f1n32_2"))
		doc.addStringField("f1n32_3", webFormData.getValueSilently("f1n32_3"))
		doc.addStringField("f1n32_4", webFormData.getValueSilently("f1n32_4"))
		doc.addStringField("f1n33", webFormData.getValueSilently("f1n33"))
		doc.addStringField("f1n33_2", webFormData.getValueSilently("f1n33_2"))
		doc.addStringField("f1n33_3", webFormData.getValueSilently("f1n33_3"))
		doc.addStringField("f1n34", webFormData.getValueSilently("f1n34"))
		doc.addStringField("f1n34_2", webFormData.getValueSilently("f1n34_2"))
		doc.addStringField("f1n34_3", webFormData.getValueSilently("f1n34_3"))
		doc.addStringField("f1n35", webFormData.getValueSilently("f1n35"))
		doc.addStringField("f1n35_2", webFormData.getValueSilently("f1n35_2"))
		doc.addStringField("f1n35_3", webFormData.getValueSilently("f1n35_3"))
		doc.addStringField("f1n36", webFormData.getValueSilently("f1n36"))
		doc.addStringField("f1n37_2", webFormData.getValueSilently("f1n37_2"))
		doc.addStringField("f1n37_3", webFormData.getValueSilently("f1n37_3"))
		doc.addStringField("f1n37_4", webFormData.getValueSilently("f1n37_4"))
		doc.addStringField("f1n37_5", webFormData.getValueSilently("f1n37_5"))
		doc.addStringField("f1n37_6", webFormData.getValueSilently("f1n37_6"))
		doc.addStringField("f1n38", webFormData.getValueSilently("f1n38"))
		doc.addStringField("f1n39", webFormData.getValueSilently("f1n39"))
		doc.addStringField("f1n40", webFormData.getValueSilently("f1n40"))
		doc.addStringField("f1n41", webFormData.getValueSilently("f1n41"))
		doc.addStringField("f1n42", webFormData.getValueSilently("f1n42"))
		doc.addStringField("f1n43", webFormData.getValueSilently("f1n43"))
		doc.addStringField("f1n44", webFormData.getValueSilently("f1n44"))
		doc.addStringField("f1n45", webFormData.getValueSilently("f1n45"))
		doc.addStringField("f1n46", webFormData.getValueSilently("f1n46"))
		doc.addStringField("f1n47", webFormData.getValueSilently("f1n47"))
		doc.addStringField("f1n48", webFormData.getValueSilently("f1n48"))
		doc.addStringField("f1n48_2", webFormData.getValueSilently("f1n48_2"))
		doc.addStringField("f1n48_3", webFormData.getValueSilently("f1n48_3"))
		doc.addStringField("f1n49", webFormData.getValueSilently("f1n49"))
		doc.addStringField("f1n50", webFormData.getValueSilently("f1n50"))
		doc.addStringField("f1n51", webFormData.getValueSilently("f1n51"))
		doc.addStringField("f1n52", webFormData.getValueSilently("f1n52"))
		doc.addStringField("f1n52_2", webFormData.getValueSilently("f1n52_2"))
		doc.addStringField("f1n52_3", webFormData.getValueSilently("f1n52_3"))
		doc.addStringField("f1n53", webFormData.getValueSilently("f1n53"))
		doc.addStringField("f1n53_2", webFormData.getValueSilently("f1n53_2"))
		doc.addStringField("f1n53_3", webFormData.getValueSilently("f1n53_3"))
		doc.addStringField("f1n54", webFormData.getValueSilently("f1n54"))
		doc.addStringField("f1n54_2", webFormData.getValueSilently("f1n54_2"))
		doc.addStringField("f1n54_3", webFormData.getValueSilently("f1n54_3"))
		doc.addStringField("f1n55", webFormData.getValueSilently("f1n55"))
		doc.addStringField("f1n55_2", webFormData.getValueSilently("f1n55_2"))
		doc.addStringField("f1n55_3", webFormData.getValueSilently("f1n55_3"))
		doc.addStringField("f1n55_4", webFormData.getValueSilently("f1n55_4"))
		doc.addStringField("f1n56_2", webFormData.getValueSilently("f1n56_2"))
		doc.addStringField("f1n56_3", webFormData.getValueSilently("f1n56_3"))
		doc.addStringField("f1n56_4", webFormData.getValueSilently("f1n56_4"))
		doc.addStringField("f1n56_5", webFormData.getValueSilently("f1n56_5"))
		doc.addStringField("f1n56_6", webFormData.getValueSilently("f1n56_6"))
		doc.addStringField("f1n56_7", webFormData.getValueSilently("f1n56_7"))
		doc.addStringField("f1n56_8", webFormData.getValueSilently("f1n56_8"))
		doc.addStringField("f1n56_9", webFormData.getValueSilently("f1n56_9"))
		doc.addStringField("f1n57", webFormData.getValueSilently("f1n57"))
		doc.addStringField("f1n58", webFormData.getValueSilently("f1n58"))
		doc.addStringField("f1n59", webFormData.getValueSilently("f1n59"))
		doc.addStringField("f1n60", webFormData.getValueSilently("f1n60"))
		doc.addStringField("f1n61", webFormData.getValueSilently("f1n61"))
		doc.addStringField("f1n62", webFormData.getValueSilently("f1n62"))
		doc.addStringField("f1n63", webFormData.getValueSilently("f1n63"))
		doc.addStringField("f1n64", webFormData.getValueSilently("f1n64"))
		doc.addStringField("f1n65", webFormData.getValueSilently("f1n65"))
		doc.addStringField("f1n66", webFormData.getValueSilently("f1n66"))
		doc.addStringField("f1n67", webFormData.getValueSilently("f1n67"))
		doc.addStringField("f1n68", webFormData.getValueSilently("f1n68"))
		doc.addStringField("f1n69", webFormData.getValueSilently("f1n69"))
		doc.addStringField("f1n69_2", webFormData.getValueSilently("f1n69_2"))
		doc.addStringField("f1n69_3", webFormData.getValueSilently("f1n69_3"))
		doc.addStringField("f1n69_4", webFormData.getValueSilently("f1n69_4"))
		doc.addStringField("f1n69_5", webFormData.getValueSilently("f1n69_5"))
		doc.addStringField("f1n70", webFormData.getValueSilently("f1n70"))
		doc.addStringField("f1n70_2", webFormData.getValueSilently("f1n70_2"))
		doc.addStringField("f1n70_3", webFormData.getValueSilently("f1n70_3"))
		doc.addStringField("f1n70_4", webFormData.getValueSilently("f1n70_4"))
		doc.addStringField("f1n70_5", webFormData.getValueSilently("f1n70_5"))
		doc.addStringField("f1n70_6", webFormData.getValueSilently("f1n70_6"))
		doc.addStringField("f1n70_7", webFormData.getValueSilently("f1n70_7"))
		doc.addStringField("f1n71", webFormData.getValueSilently("f1n71"))
		doc.addStringField("f1n72", webFormData.getValueSilently("f1n72"))
		doc.addStringField("f1n73", webFormData.getValueSilently("f1n73"))
		doc.addStringField("f1n74", webFormData.getValueSilently("f1n74"))
		doc.addStringField("f1n75", webFormData.getValueSilently("f1n75"))
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
			int num = db.getRegNumber('transportaccident')
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
