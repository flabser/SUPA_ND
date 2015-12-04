package form.telecomaccidents

import kz.nextbase.script._Document
import kz.nextbase.script._Exception
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.constants._DocumentModeType
import kz.nextbase.script.events._FormQueryOpen

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Аварии систем связи и телекоммуникаций", lang))
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
		publishValue("title",getLocalizedWord("Аварии систем связи и телекоммуникаций", lang) + ": " + doc.getValueString("briefcontent"))
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

		publishValue("esbriefcontent", doc.getValueString("esbriefcontent"))
		publishValue("roadstretch", doc.getValueString("roadstretch"))
		publishValue("railwaystretch", doc.getValueString("railwaystretch"))
		publishValue("airport", doc.getValueString("airport"))
		publishValue("airdrome", doc.getValueString("airdrome"))
		publishValue("infosource", doc.getValueString("infosource"))
		publishValue("infosourcedetail", doc.getValueString("infosourcedetail"))
		publishValue("f1n37_2", doc.getValueString("f1n37_2"))
		publishValue("f1n37_3", doc.getValueString("f1n37_3"))
		publishValue("f1n37_4", doc.getValueString("f1n37_4"))
		publishValue("f1n37_5", doc.getValueString("f1n37_5"))
		publishValue("f1n37_6", doc.getValueString("f1n37_6"))
		publishValue("f1n38", doc.getValueString("f1n38"))
		publishValue("f1n39", doc.getValueString("f1n39"))
		publishValue("f1n40", doc.getValueString("f1n40"))
		publishValue("f2n20", doc.getValueString("f2n20"))
		publishValue("f2n21", doc.getValueString("f2n21"))
		publishValue("f2n22", doc.getValueString("f2n22"))
		publishValue("f2n23", doc.getValueString("f2n23"))
		publishValue("f2n24", doc.getValueString("f2n24"))
		publishValue("f2n25", doc.getValueString("f2n25"))
		publishValue("f2n26", doc.getValueString("f2n26"))
		publishValue("f2n27", doc.getValueString("f2n27"))
		publishValue("f2n28", doc.getValueString("f2n28"))
		publishValue("f2n29", doc.getValueString("f2n29"))
		publishValue("f2n30", doc.getValueString("f2n30"))
		publishValue("f2n31", doc.getValueString("f2n31"))
		publishValue("f2n32", doc.getValueString("f2n32"))
		publishValue("f2n32_2", doc.getValueString("f2n32_2"))
		publishValue("f2n32_3", doc.getValueString("f2n32_3"))
		publishValue("f2n32_4", doc.getValueString("f2n32_4"))
		publishValue("f2n32_5", doc.getValueString("f2n32_5"))
		publishValue("f2n32_6", doc.getValueString("f2n32_6"))
		publishValue("f2n32_7", doc.getValueString("f2n32_7"))
		publishValue("f2n32_8", doc.getValueString("f2n32_8"))
		publishValue("f2n32_9", doc.getValueString("f2n32_9"))
		publishValue("f2n32_10", doc.getValueString("f2n32_10"))
		publishValue("f2n33", doc.getValueString("f2n33"))
		publishValue("f2n34", doc.getValueString("f2n34"))
		publishValue("f1n65", doc.getValueString("f1n65"))
		publishValue("f2n36", doc.getValueString("f2n36"))
		publishValue("f2n37", doc.getValueString("f2n37"))
		publishValue("f2n38_2", doc.getValueString("f2n38_2"))
		publishValue("f2n38_3", doc.getValueString("f2n38_3"))
		publishValue("f2n38_4", doc.getValueString("f2n38_4"))
		publishValue("f2n38_5", doc.getValueString("f2n38_5"))
		publishValue("f2n39", doc.getValueString("f2n39"))
		publishValue("f2n40", doc.getValueString("f2n40"))
		publishValue("f2n41", doc.getValueString("f2n41"))
		publishValue("f1n43", doc.getValueString("f1n43"))
		publishValue("f1n44", doc.getValueString("f1n44"))
		publishValue("f1n45", doc.getValueString("f1n45"))
		publishValue("f1n46", doc.getValueString("f1n46"))
		publishValue("f1n47", doc.getValueString("f1n47"))
		publishValue("f1n48", doc.getValueString("f1n48"))
		publishValue("f1n48_2", doc.getValueString("f1n48_2"))
		publishValue("f1n48_3", doc.getValueString("f1n48_3"))
		publishValue("f1n49", doc.getValueString("f1n49"))
		publishValue("f1n73", doc.getValueString("f1n73"))
		publishValue("f1n74", doc.getValueString("f1n74"))
		publishValue("f1n75", doc.getValueString("f1n75"))
		publishValue("f1n75_2", doc.getValueString("f1n75_2"))
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