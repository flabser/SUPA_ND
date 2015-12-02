package form.transportaccident
import kz.nextbase.script.*
import kz.nextbase.script.constants._AllControlType
import kz.nextbase.script.events._FormQuerySave
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._ExecsBlocks

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
		doc.addStringField("carddate", webFormData.getValue("carddate"))
		doc.addStringField("cardnumber", webFormData.getValue("cardnumber"))
		doc.addStringField("escode", webFormData.getValue("escode"))
       // doc.setRichText("content", webFormData.getValue("content"));
		doc.addNumberField("essubtype", webFormData.getNumberValueSilently("essubtype",-1))
		doc.addNumberField("region", webFormData.getNumberValueSilently("region",-1))
		doc.addNumberField("respcity", webFormData.getNumberValueSilently("respcity",-1))
		doc.addNumberField("city", webFormData.getNumberValueSilently("city",-1))
		//doc.addFile("rtfcontent", webFormData)
		doc.addStringField("esbriefcontent", webFormData.getValue("esbriefcontent"))
		doc.addStringField("esdate", webFormData.getValue("esdate"))
		doc.addStringField("district", webFormData.getValue("district"))
		doc.addStringField("villagedistrict", webFormData.getValue("villagedistrict"))
		doc.addStringField("settlement", webFormData.getValue("settlement"))
		doc.addStringField("village", webFormData.getValue("village"))
		doc.addStringField("aul", webFormData.getValue("aul"))
		doc.addStringField("avenue", webFormData.getValue("avenue"))
		doc.addStringField("street", webFormData.getValue("street"))
		doc.addStringField("microdistrict", webFormData.getValue("microdistrict"))
		doc.addStringField("lane", webFormData.getValue("lane"))
		doc.addStringField("house", webFormData.getValue("house"))
		doc.addStringField("housing", webFormData.getValue("housing"))
		doc.addStringField("referencepoint", webFormData.getValue("referencepoint"))
		doc.addStringField("distance", webFormData.getValue("distance"))
		doc.addStringField("coordinats", webFormData.getValue("coordinats"))
		doc.addStringField("roadtype", webFormData.getValue("roadtype"))
		doc.addStringField("busstation", webFormData.getValue("busstation"))
		doc.addStringField("railways", webFormData.getValue("railways"))
		doc.addStringField("airterminal", webFormData.getValue("airterminal"))
		doc.addStringField("seaport", webFormData.getValue("seaport"))
		doc.addStringField("route", webFormData.getValue("route"))
		doc.addStringField("f1n15", webFormData.getValue("f1n15"))
		doc.addStringField("f1n15_2", webFormData.getValue("f1n15_2"))
		doc.addStringField("departdate", webFormData.getValue("departdate"))
		doc.addStringField("departtime", webFormData.getValue("departtime"))
		doc.addStringField("arrivaldate", webFormData.getValue("arrivaldate"))
		doc.addStringField("arrivaltime", webFormData.getValue("arrivaltime"))
		doc.addStringField("f1n20", webFormData.getValue("f1n20"))
		doc.addStringField("f1n21", webFormData.getValue("f1n21"))
		doc.addStringField("f1n21_2", webFormData.getValue("f1n21_2"))
		doc.addStringField("f1n22", webFormData.getValue("f1n22"))
		doc.addStringField("f1n23", webFormData.getValue("f1n23"))
		doc.addStringField("f1n23_5", webFormData.getValue("f1n23_5"))
		doc.addStringField("f1n23_2", webFormData.getValue("f1n23_2"))
		doc.addStringField("f1n23_3", webFormData.getValue("f1n23_3"))
		doc.addStringField("f1n23_4", webFormData.getValue("f1n23_4"))
		doc.addStringField("f1n24", webFormData.getValue("f1n24"))
		doc.addStringField("f1n24_5", webFormData.getValue("f1n24_5"))
		doc.addStringField("f1n24_2", webFormData.getValue("f1n24_2"))
		doc.addStringField("f1n24_3", webFormData.getValue("f1n24_3"))
		doc.addStringField("f1n24_4", webFormData.getValue("f1n24_4"))
		doc.addStringField("f1n25", webFormData.getValue("f1n25"))
		doc.addStringField("f1n25_5", webFormData.getValue("f1n25_5"))
		doc.addStringField("f1n25_2", webFormData.getValue("f1n25_2"))
		doc.addStringField("f1n25_3", webFormData.getValue("f1n25_3"))
		doc.addStringField("f1n25_4", webFormData.getValue("f1n25_4"))
		doc.addStringField("f1n26", webFormData.getValue("f1n26"))
		doc.addStringField("f1n26_5", webFormData.getValue("f1n26_5"))
		doc.addStringField("f1n26_2", webFormData.getValue("f1n26_2"))
		doc.addStringField("f1n26_3", webFormData.getValue("f1n26_3"))
		doc.addStringField("f1n26_4", webFormData.getValue("f1n26_4"))
		doc.addStringField("f1n27", webFormData.getValue("f1n27"))
		doc.addStringField("f1n27_2", webFormData.getValue("f1n27_2"))
		doc.addStringField("f1n27_3", webFormData.getValue("f1n27_3"))
		doc.addStringField("f1n27_4", webFormData.getValue("f1n27_4"))
		doc.addStringField("f1n27_5", webFormData.getValue("f1n27_5"))
		doc.addStringField("f1n28", webFormData.getValue("f1n28"))
		doc.addStringField("f1n29", webFormData.getValue("f1n29"))
		doc.addStringField("f1n29_5", webFormData.getValue("f1n29_5"))
		doc.addStringField("f1n29_2", webFormData.getValue("f1n29_2"))
		doc.addStringField("f1n29_3", webFormData.getValue("f1n29_3"))
		doc.addStringField("f1n29_4", webFormData.getValue("f1n29_4"))
		doc.addStringField("f1n30", webFormData.getValue("f1n30"))
		doc.addStringField("f1n30_5", webFormData.getValue("f1n30_5"))
		doc.addStringField("f1n30_2", webFormData.getValue("f1n30_2"))
		doc.addStringField("f1n30_3", webFormData.getValue("f1n30_3"))
		doc.addStringField("f1n30_4", webFormData.getValue("f1n30_4"))
		doc.addStringField("f1n31", webFormData.getValue("f1n31"))
		doc.addStringField("f1n32", webFormData.getValue("f1n32"))
		doc.addStringField("f1n32_5", webFormData.getValue("f1n32_5"))
		doc.addStringField("f1n32_2", webFormData.getValue("f1n32_2"))
		doc.addStringField("f1n32_3", webFormData.getValue("f1n32_3"))
		doc.addStringField("f1n32_4", webFormData.getValue("f1n32_4"))
		doc.addStringField("f1n33", webFormData.getValue("f1n33"))
		doc.addStringField("f1n33_2", webFormData.getValue("f1n33_2"))
		doc.addStringField("f1n33_3", webFormData.getValue("f1n33_3"))
		doc.addStringField("f1n34", webFormData.getValue("f1n34"))
		doc.addStringField("f1n34_2", webFormData.getValue("f1n34_2"))
		doc.addStringField("f1n34_3", webFormData.getValue("f1n34_3"))
		doc.addStringField("f1n35", webFormData.getValue("f1n35"))
		doc.addStringField("f1n35_2", webFormData.getValue("f1n35_2"))
		doc.addStringField("f1n35_3", webFormData.getValue("f1n35_3"))
		doc.addStringField("f1n36", webFormData.getValue("f1n36"))
		doc.addStringField("f1n37_2", webFormData.getValue("f1n37_2"))
		doc.addStringField("f1n37_3", webFormData.getValue("f1n37_3"))
		doc.addStringField("f1n37_4", webFormData.getValue("f1n37_4"))
		doc.addStringField("f1n37_5", webFormData.getValue("f1n37_5"))
		doc.addStringField("f1n37_6", webFormData.getValue("f1n37_6"))
		doc.addStringField("f1n38", webFormData.getValue("f1n38"))
		doc.addStringField("f1n39", webFormData.getValue("f1n39"))
		doc.addStringField("f1n40", webFormData.getValue("f1n40"))
		doc.addStringField("f1n41", webFormData.getValue("f1n41"))
		doc.addStringField("f1n42", webFormData.getValue("f1n42"))
		doc.addStringField("f1n43", webFormData.getValue("f1n43"))
		doc.addStringField("f1n44", webFormData.getValue("f1n44"))
		doc.addStringField("f1n45", webFormData.getValue("f1n45"))
		doc.addStringField("f1n46", webFormData.getValue("f1n46"))
		doc.addStringField("f1n47", webFormData.getValue("f1n47"))
		doc.addStringField("f1n48", webFormData.getValue("f1n48"))
		doc.addStringField("f1n48_2", webFormData.getValue("f1n48_2"))
		doc.addStringField("f1n48_3", webFormData.getValue("f1n48_3"))
		doc.addStringField("f1n49", webFormData.getValue("f1n49"))
		doc.addStringField("f1n50", webFormData.getValue("f1n50"))
		doc.addStringField("f1n51", webFormData.getValue("f1n51"))
		doc.addStringField("f1n52", webFormData.getValue("f1n52"))
		doc.addStringField("f1n52_2", webFormData.getValue("f1n52_2"))
		doc.addStringField("f1n52_3", webFormData.getValue("f1n52_3"))
		doc.addStringField("f1n53", webFormData.getValue("f1n53"))
		doc.addStringField("f1n53_2", webFormData.getValue("f1n53_2"))
		doc.addStringField("f1n53_3", webFormData.getValue("f1n53_3"))
		doc.addStringField("f1n54", webFormData.getValue("f1n54"))
		doc.addStringField("f1n54_2", webFormData.getValue("f1n54_2"))
		doc.addStringField("f1n54_3", webFormData.getValue("f1n54_3"))
		doc.addStringField("f1n55", webFormData.getValue("f1n55"))
		doc.addStringField("f1n55_2", webFormData.getValue("f1n55_2"))
		doc.addStringField("f1n55_3", webFormData.getValue("f1n55_3"))
		doc.addStringField("f1n55_4", webFormData.getValue("f1n55_4"))
		doc.addStringField("f1n56_2", webFormData.getValue("f1n56_2"))
		doc.addStringField("f1n56_3", webFormData.getValue("f1n56_3"))
		doc.addStringField("f1n56_4", webFormData.getValue("f1n56_4"))
		doc.addStringField("f1n56_5", webFormData.getValue("f1n56_5"))
		doc.addStringField("f1n56_6", webFormData.getValue("f1n56_6"))
		doc.addStringField("f1n56_7", webFormData.getValue("f1n56_7"))
		doc.addStringField("f1n56_8", webFormData.getValue("f1n56_8"))
		doc.addStringField("f1n56_9", webFormData.getValue("f1n56_9"))
		doc.addStringField("f1n57", webFormData.getValue("f1n57"))
		doc.addStringField("f1n58", webFormData.getValue("f1n58"))
		doc.addStringField("f1n59", webFormData.getValue("f1n59"))
		doc.addStringField("f1n60", webFormData.getValue("f1n60"))
		doc.addStringField("f1n61", webFormData.getValue("f1n61"))
		doc.addStringField("f1n62", webFormData.getValue("f1n62"))
		doc.addStringField("f1n63", webFormData.getValue("f1n63"))
		doc.addStringField("f1n64", webFormData.getValue("f1n64"))
		doc.addStringField("f1n65", webFormData.getValue("f1n65"))
		doc.addStringField("f1n66", webFormData.getValue("f1n66"))
		doc.addStringField("f1n67", webFormData.getValue("f1n67"))
		doc.addStringField("f1n68", webFormData.getValue("f1n68"))
		doc.addStringField("f1n69", webFormData.getValue("f1n69"))
		doc.addStringField("f1n69_2", webFormData.getValue("f1n69_2"))
		doc.addStringField("f1n69_3", webFormData.getValue("f1n69_3"))
		doc.addStringField("f1n69_4", webFormData.getValue("f1n69_4"))
		doc.addStringField("f1n69_5", webFormData.getValue("f1n69_5"))
		doc.addStringField("f1n70", webFormData.getValue("f1n70"))
		doc.addStringField("f1n70_2", webFormData.getValue("f1n70_2"))
		doc.addStringField("f1n70_3", webFormData.getValue("f1n70_3"))
		doc.addStringField("f1n70_4", webFormData.getValue("f1n70_4"))
		doc.addStringField("f1n70_5", webFormData.getValue("f1n70_5"))
		doc.addStringField("f1n70_6", webFormData.getValue("f1n70_6"))
		doc.addStringField("f1n70_7", webFormData.getValue("f1n70_7"))
		doc.addStringField("f1n71", webFormData.getValue("f1n71"))
		doc.addStringField("f1n72", webFormData.getValue("f1n72"))
		doc.addStringField("f1n73", webFormData.getValue("f1n73"))
		doc.addStringField("f1n74", webFormData.getValue("f1n74"))
		doc.addStringField("f1n75", webFormData.getValue("f1n75"))
		doc.addStringField("f1n76", webFormData.getValue("f1n76"))
		doc.addStringField("f1n77", webFormData.getValue("f1n77"))
		doc.addStringField("f1n78", webFormData.getValue("f1n78"))
		doc.addStringField("f1n79", webFormData.getValue("f1n79"))
		doc.addStringField("f1n80", webFormData.getValue("f1n80"))
		doc.addStringField("f1n81", webFormData.getValue("f1n81"))
		doc.addStringField("f1n82", webFormData.getValue("f1n82"))
		doc.addStringField("f1n83", webFormData.getValue("f1n83"))
		doc.addStringField("f1n84", webFormData.getValue("f1n84"))


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
		def essubtype_viewtext = essubtype.name
		doc.setViewText(doc.getValueDate("carddate") + " " +  author_fullname + " : " + webFormData.getValue("esdate") +" "+ essubtype_viewtext +" "+ doc.getValueString("briefcontent")) //0
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
