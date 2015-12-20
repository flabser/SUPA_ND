package reporting.form.transportaccident
import kz.flabs.webrule.constants.RunMode
import kz.nextbase.script.*
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.constants._DocumentModeType
import kz.nextbase.script.events._FormQueryOpen
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._ExecsBlocks
import kz.pchelka.env.Environment

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Транспортные аварии (катастрофы)", lang))
		def user = session.getCurrentAppUser()

		def nav = session.getPage("outline", webFormData)
		publishElement(nav)

		def actionBar = session.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)

		publishValue("status", "new")
		publishEmployer("author",session.getCurrentAppUser().getUserID())
		publishValue("carddate", session.getCurrentDateAsString())
	}

	def getRespProgress(_Document gdoc, _Session session) {
		String progress = "";
		gdoc.getResponses().each {
			progress += "<entry url='" + it.getFullURL().replace("&", "&amp;") + "'>" +"<viewtext>" +it.getViewText().replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;") +"</viewtext>" +"<responses>" + getRespProgress(it, session) + "</responses>" + "</entry>"
		};
		return progress;
	}
	
	def publishParentDocs(_Document mdoc, _Session session, String status) {
		String progress = getRespProgress(mdoc, session);
		progress = "<entry url='" + mdoc.getFullURL().replace("&", "&amp;") + "'>" +"<viewtext>" +mdoc.getViewText().replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;") +"</viewtext>"+ "<responses>" + progress + "</responses></entry>";
		publishValue(true, "progress", progress);
	}
	 
	@Override
	public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Транспортные аварии (катастрофы)", lang) + ": " + doc.getValueString("briefcontent"))
		def user = session.getCurrentAppUser()

		def nav = session.getPage("outline", webFormData)
		publishElement(nav)

		def actionBar =  session.createActionBar();

		if(doc.getEditMode() == _DocumentModeType.EDIT){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		if(user.hasRole("supervisor")){
			actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
		}




		publishElement(actionBar)


		publishEmployer("author",doc.getAuthorID())

		//publishValue("author", doc.getValueString("author"))
		publishValue("carddate", doc.getValueString("carddate"))
		publishValue("cardnumber", doc.getValueString("cardnumber"))
		publishValue("escode", doc.getValueString("escode"))

		publishGlossaryValue("essubtype", doc.getValueNumber("essubtype"))
		publishGlossaryValue("region", doc.getValueNumber("region"))
		publishGlossaryValue("respcity", doc.getValueNumber("respcity"))
		publishGlossaryValue("city",doc.getValueNumber("city"))

		publishValue("esgroup", doc.getValueString("esgroup"))
		publishValue("esbriefcontent", doc.getValueString("esbriefcontent"))
		publishValue("esdate", doc.getValueString("esdate"))
		publishValue("district", doc.getValueString("district"))
		publishValue("villagedistrict", doc.getValueString("villagedistrict"))
		publishValue("settlement", doc.getValueString("settlement"))
		publishValue("village", doc.getValueString("village"))
		publishValue("aul", doc.getValueString("aul"))
		publishValue("avenue", doc.getValueString("avenue"))
		publishValue("street", doc.getValueString("street"))
		publishValue("microdistrict", doc.getValueString("microdistrict"))
		publishValue("lane", doc.getValueString("lane"))
		publishValue("house", doc.getValueString("house"))
		publishValue("housing", doc.getValueString("housing"))
		publishValue("referencepoint", doc.getValueString("referencepoint"))
		publishValue("distance", doc.getValueString("distance"))
		publishValue("coordinats", doc.getValueString("coordinats"))
		publishValue("roadtype", doc.getValueString("roadtype"))
		publishValue("busstation", doc.getValueString("busstation"))
		publishValue("railways", doc.getValueString("railways"))
		publishValue("airterminal", doc.getValueString("airterminal"))
		publishValue("seaport", doc.getValueString("seaport"))
		publishValue("route", doc.getValueString("route"))
		publishValue("f1n15", doc.getValueString("f1n15"))
		publishValue("f1n15_2", doc.getValueString("f1n15_2"))
		publishValue("departdate", doc.getValueString("departdate"))
		publishValue("departtime", doc.getValueString("departtime"))
		publishValue("arrivaldate", doc.getValueString("arrivaldate"))
		publishValue("arrivaltime", doc.getValueString("arrivaltime"))
		publishValue("f1n20", doc.getValueString("f1n20"))
		publishValue("f1n21", doc.getValueString("f1n21"))
		publishValue("f1n21_2", doc.getValueString("f1n21_2"))
		publishValue("f1n22", doc.getValueString("f1n22"))
		publishValue("f1n23", doc.getValueString("f1n23"))
		publishValue("f1n23_5", doc.getValueString("f1n23_5"))
		publishValue("f1n23_2", doc.getValueString("f1n23_2"))
		publishValue("f1n23_3", doc.getValueString("f1n23_3"))
		publishValue("f1n23_4", doc.getValueString("f1n23_4"))
		publishValue("f1n24", doc.getValueString("f1n24"))
		publishValue("f1n24_5", doc.getValueString("f1n24_5"))
		publishValue("f1n24_2", doc.getValueString("f1n24_2"))
		publishValue("f1n24_3", doc.getValueString("f1n24_3"))
		publishValue("f1n24_4", doc.getValueString("f1n24_4"))
		publishValue("f1n25", doc.getValueString("f1n25"))
		publishValue("f1n25_5", doc.getValueString("f1n25_5"))
		publishValue("f1n25_2", doc.getValueString("f1n25_2"))
		publishValue("f1n25_3", doc.getValueString("f1n25_3"))
		publishValue("f1n25_4", doc.getValueString("f1n25_4"))
		publishValue("f1n26", doc.getValueString("f1n26"))
		publishValue("f1n26_5", doc.getValueString("f1n26_5"))
		publishValue("f1n26_2", doc.getValueString("f1n26_2"))
		publishValue("f1n26_3", doc.getValueString("f1n26_3"))
		publishValue("f1n26_4", doc.getValueString("f1n26_4"))
		publishValue("f1n27", doc.getValueString("f1n27"))
		publishValue("f1n27_2", doc.getValueString("f1n27_2"))
		publishValue("f1n27_3", doc.getValueString("f1n27_3"))
		publishValue("f1n27_4", doc.getValueString("f1n27_4"))
		publishValue("f1n27_5", doc.getValueString("f1n27_5"))
		publishValue("f1n28", doc.getValueString("f1n28"))
		publishValue("f1n29", doc.getValueString("f1n29"))
		publishValue("f1n29_5", doc.getValueString("f1n29_5"))
		publishValue("f1n29_2", doc.getValueString("f1n29_2"))
		publishValue("f1n29_3", doc.getValueString("f1n29_3"))
		publishValue("f1n29_4", doc.getValueString("f1n29_4"))
		publishValue("f1n30", doc.getValueString("f1n30"))
		publishValue("f1n30_5", doc.getValueString("f1n30_5"))
		publishValue("f1n30_2", doc.getValueString("f1n30_2"))
		publishValue("f1n30_3", doc.getValueString("f1n30_3"))
		publishValue("f1n30_4", doc.getValueString("f1n30_4"))
		publishValue("f1n31", doc.getValueString("f1n31"))
		publishValue("f1n32", doc.getValueString("f1n32"))
		publishValue("f1n32_5", doc.getValueString("f1n32_5"))
		publishValue("f1n32_2", doc.getValueString("f1n32_2"))
		publishValue("f1n32_3", doc.getValueString("f1n32_3"))
		publishValue("f1n32_4", doc.getValueString("f1n32_4"))
		publishValue("f1n33", doc.getValueString("f1n33"))
		publishValue("f1n33_2", doc.getValueString("f1n33_2"))
		publishValue("f1n33_3", doc.getValueString("f1n33_3"))
		publishValue("f1n34", doc.getValueString("f1n34"))
		publishValue("f1n34_2", doc.getValueString("f1n34_2"))
		publishValue("f1n34_3", doc.getValueString("f1n34_3"))
		publishValue("f1n35", doc.getValueString("f1n35"))
		publishValue("f1n35_2", doc.getValueString("f1n35_2"))
		publishValue("f1n35_3", doc.getValueString("f1n35_3"))
		publishValue("f1n36", doc.getValueString("f1n36"))
		publishValue("f1n37_2", doc.getValueString("f1n37_2"))
		publishValue("f1n37_3", doc.getValueString("f1n37_3"))
		publishValue("f1n37_4", doc.getValueString("f1n37_4"))
		publishValue("f1n37_5", doc.getValueString("f1n37_5"))
		publishValue("f1n37_6", doc.getValueString("f1n37_6"))
		publishValue("f1n38", doc.getValueString("f1n38"))
		publishValue("f1n39", doc.getValueString("f1n39"))
		publishValue("f1n40", doc.getValueString("f1n40"))
		publishValue("f1n41", doc.getValueString("f1n41"))
		publishValue("f1n42", doc.getValueString("f1n42"))
		publishValue("f1n43", doc.getValueString("f1n43"))
		publishValue("f1n44", doc.getValueString("f1n44"))
		publishValue("f1n45", doc.getValueString("f1n45"))
		publishValue("f1n46", doc.getValueString("f1n46"))
		publishValue("f1n47", doc.getValueString("f1n47"))
		publishValue("f1n48", doc.getValueString("f1n48"))
		publishValue("f1n48_2", doc.getValueString("f1n48_2"))
		publishValue("f1n48_3", doc.getValueString("f1n48_3"))
		publishValue("f1n49", doc.getValueString("f1n49"))
		publishValue("f1n50", doc.getValueString("f1n50"))
		publishValue("f1n51", doc.getValueString("f1n51"))
		publishValue("f1n52", doc.getValueString("f1n52"))
		publishValue("f1n52_2", doc.getValueString("f1n52_2"))
		publishValue("f1n52_3", doc.getValueString("f1n52_3"))
		publishValue("f1n53", doc.getValueString("f1n53"))
		publishValue("f1n53_2", doc.getValueString("f1n53_2"))
		publishValue("f1n53_3", doc.getValueString("f1n53_3"))
		publishValue("f1n54", doc.getValueString("f1n54"))
		publishValue("f1n54_2", doc.getValueString("f1n54_2"))
		publishValue("f1n54_3", doc.getValueString("f1n54_3"))
		publishValue("f1n55", doc.getValueString("f1n55"))
		publishValue("f1n55_2", doc.getValueString("f1n55_2"))
		publishValue("f1n55_3", doc.getValueString("f1n55_3"))
		publishValue("f1n55_4", doc.getValueString("f1n55_4"))
		publishValue("f1n56_2", doc.getValueString("f1n56_2"))
		publishValue("f1n56_3", doc.getValueString("f1n56_3"))
		publishValue("f1n56_4", doc.getValueString("f1n56_4"))
		publishValue("f1n56_5", doc.getValueString("f1n56_5"))
		publishValue("f1n56_6", doc.getValueString("f1n56_6"))
		publishValue("f1n56_7", doc.getValueString("f1n56_7"))
		publishValue("f1n56_8", doc.getValueString("f1n56_8"))
		publishValue("f1n56_9", doc.getValueString("f1n56_9"))
		publishValue("f1n57", doc.getValueString("f1n57"))
		publishValue("f1n58", doc.getValueString("f1n58"))
		publishValue("f1n59", doc.getValueString("f1n59"))
		publishValue("f1n60", doc.getValueString("f1n60"))
		publishValue("f1n61", doc.getValueString("f1n61"))
		publishValue("f1n62", doc.getValueString("f1n62"))
		publishValue("f1n63", doc.getValueString("f1n63"))
		publishValue("f1n64", doc.getValueString("f1n64"))
		publishValue("f1n65", doc.getValueString("f1n65"))
		publishValue("f1n66", doc.getValueString("f1n66"))
		publishValue("f1n67", doc.getValueString("f1n67"))
		publishValue("f1n68", doc.getValueString("f1n68"))
		publishValue("f1n69", doc.getValueString("f1n69"))
		publishValue("f1n69_2", doc.getValueString("f1n69_2"))
		publishValue("f1n69_3", doc.getValueString("f1n69_3"))
		publishValue("f1n69_4", doc.getValueString("f1n69_4"))
		publishValue("f1n69_5", doc.getValueString("f1n69_5"))
		publishValue("f1n70", doc.getValueString("f1n70"))
		publishValue("f1n70_2", doc.getValueString("f1n70_2"))
		publishValue("f1n70_3", doc.getValueString("f1n70_3"))
		publishValue("f1n70_4", doc.getValueString("f1n70_4"))
		publishValue("f1n70_5", doc.getValueString("f1n70_5"))
		publishValue("f1n70_6", doc.getValueString("f1n70_6"))
		publishValue("f1n70_7", doc.getValueString("f1n70_7"))
		publishValue("f1n71", doc.getValueString("f1n71"))
		publishValue("f1n72", doc.getValueString("f1n72"))
		publishValue("f1n73", doc.getValueString("f1n73"))
		publishValue("f1n74", doc.getValueString("f1n74"))
		publishValue("f1n75", doc.getValueString("f1n75"))
		publishValue("f1n76", doc.getValueString("f1n76"))
		publishValue("f1n77", doc.getValueString("f1n77"))
		publishValue("f1n78", doc.getValueString("f1n78"))
		publishValue("f1n79", doc.getValueString("f1n79"))
		publishValue("f1n80", doc.getValueString("f1n80"))
		publishValue("f1n81", doc.getValueString("f1n81"))
		publishValue("f1n82", doc.getValueString("f1n82"))
		publishValue("f1n83", doc.getValueString("f1n83"))
		publishValue("f1n84", doc.getValueString("f1n84"))



		try{
			publishAttachment("rtfcontent","rtfcontent")
		}catch(_Exception e){

		}
		/*
		 def parentDoc = db.getDocumentByComplexID(webFormData.getParentDocID())
		 if (parentDoc){
		 def link = new _CrossLink(session, parentDoc.getURL(), parentDoc.getViewText())	
		 publishValue(link)
		 }
		 */		
	}

}