package page.share_navigator

import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.outline.*;

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		//println(lang)
		def list = []
		def user = session. getCurrentAppUser()
		def outline = new _Outline("", "", "outline")

		def tech_outline = new _Outline(getLocalizedWord("Техногенные ЧС",lang), getLocalizedWord("Техногенные ЧС",lang), "tech")
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Транспортные аварии (катастрофы)",lang), getLocalizedWord("Транспортные аварии (катастрофы)",lang), "transportaccident", "Provider?type=page&id=transportaccident"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Пожары со взрывом, взрывы приведшие к пожару",lang), getLocalizedWord("Пожары со взрывом, взрывы приведшие к пожару",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии с выбросом (угрозой выброса) ХОВ",lang), getLocalizedWord("Аварии с выбросом (угрозой выброса) ХОВ",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Превышение ПДК вредных веществ в окружающей среде",lang), getLocalizedWord("Превышение ПДК вредных веществ в окружающей среде",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии с выбросом (угрозой выброса) РВ",lang), getLocalizedWord("Аварии с выбросом (угрозой выброса) РВ",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии с выбросом (угрозой выброса) БОВ",lang), getLocalizedWord("Аварии с выбросом (угрозой выброса) БОВ",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Внезапное обрушение зданий, сооружений, пород",lang), getLocalizedWord("Внезапное обрушение зданий, сооружений, пород",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии на электроэнергетических системах",lang), getLocalizedWord("Аварии на электроэнергетических системах",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии на коммунальных системах жизнеобеспечения",lang), getLocalizedWord("Аварии на коммунальных системах жизнеобеспечения",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии систем связи и телекоммуникаций",lang), getLocalizedWord("Аварии систем связи и телекоммуникаций",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии на промышленных очистных сооружениях",lang), getLocalizedWord("Аварии на промышленных очистных сооружениях",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Гидродинамические аварии",lang), getLocalizedWord("Гидродинамические аварии",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии в системах нефтегазового промышленного комплекса",lang), getLocalizedWord("Аварии в системах нефтегазового промышленного комплекса",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("ЧС космического характера",lang), getLocalizedWord("ЧС космического характера",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Загорания не подлежащие учету как пожар",lang), getLocalizedWord("Загорания не подлежащие учету как пожар",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Пожары",lang), getLocalizedWord("Пожары",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Производственные аварии и ЧС",lang), getLocalizedWord("Производственные аварии и ЧС",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Несчастные случаи в быту",lang), getLocalizedWord("Несчастные случаи в быту",lang), "controltype", "Provider?type=page&id=controltype"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("ЧС за пределами государства",lang), getLocalizedWord("ЧС за пределами государства",lang), "controltype", "Provider?type=page&id=controltype"))
		outline.addOutline(tech_outline)
		list.add(tech_outline)

		def nature_outline = new _Outline(getLocalizedWord("Природные ЧС",lang), getLocalizedWord("Природные ЧС",lang), "nature")
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Опасные геофизические явления",lang), getLocalizedWord("Опасные геофизические явления",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Геологические опасные явления",lang), getLocalizedWord("Геологические опасные явления",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Метеорологические и агрометеорологические опасные явления",lang), getLocalizedWord("Метеорологические и агрометеорологические опасные явления",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Морские опасные гидрологические явления",lang), getLocalizedWord("Морские опасные гидрологические явления",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Гидрологические опасные явления",lang), getLocalizedWord("Гидрологические опасные явления",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Гидрогеологические опасные явления",lang), getLocalizedWord("Гидрогеологические опасные явления",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Природные пожары",lang), getLocalizedWord("Природные пожары",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Инфекционные заболевания людей",lang), getLocalizedWord("Инфекционные заболевания людей",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Отравления людей",lang), getLocalizedWord("Отравления людей",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Инфекционные заболевания сельскохозяйст-венных животных",lang), getLocalizedWord("Инфекционные заболевания сельскохозяйст-венных животных",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Массовое отравление сельскохозяйственных животных",lang), getLocalizedWord("Массовое отравление сельскохозяйственных животных",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Массовое заболевание и гибель диких животных",lang), getLocalizedWord("Массовое заболевание и гибель диких животных",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Поражение сельскохозяйственных растений болезнями и вредителями",lang), getLocalizedWord("Поражение сельскохозяйственных растений болезнями и вредителями",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния суши",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния суши",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состава и свойств атмосферы",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состава и свойств атмосферы",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния гидросферы",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния гидросферы",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния биосферы",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния биосферы",lang), "controltype", "Provider?type=page&id=controltype"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Пострадавшие на водах",lang), getLocalizedWord("Пострадавшие на водах",lang), "controltype", "Provider?type=page&id=controltype"))
		list.add(nature_outline)
		outline.addOutline(nature_outline)

		def social_outline = new _Outline(getLocalizedWord("Социально-политические ЧС",lang), getLocalizedWord("Социально-политические ЧС",lang), "social")
		social_outline.addEntry(new _OutlineEntry(getLocalizedWord("Нарушения общественного порядка",lang), getLocalizedWord("Нарушения общественного порядка",lang), "controltype", "Provider?type=page&id=controltype"))
		list.add(social_outline)
		outline.addOutline(social_outline)

		if (user.hasRole("chancellery")){
			def docstoreg_outline = new _Outline(getLocalizedWord("На регистрацию",lang), getLocalizedWord("На регистрацию",lang), "docstoreg")
			docstoreg_outline.addEntry(new _OutlineEntry(getLocalizedWord("Исходящие",lang), getLocalizedWord("Исходящие",lang), "outdocreg", "Provider?type=page&id=outdocreg&page=0"))
			docstoreg_outline.addEntry(new _OutlineEntry(getLocalizedWord("Входящие",lang), getLocalizedWord("Входящие",lang), "indocreg", "Provider?type=page&id=indocreg&page=0"))
			outline.addOutline(docstoreg_outline)
			list.add(docstoreg_outline)
		}

		if (user.hasRole("administrator")){
			def glossary_outline = new _Outline(getLocalizedWord("Справочники",lang), getLocalizedWord("Справочники",lang), "glossary")
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип контроля",lang), getLocalizedWord("Тип контроля",lang), "controltype", "Provider?type=page&id=controltype"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категория",lang), getLocalizedWord("Категория",lang), "docscat", "Provider?type=page&id=docscat&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Характер вопроса",lang), getLocalizedWord("Характер вопроса",lang), "har", "Provider?type=page&id=har"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип документа",lang), getLocalizedWord("Тип документа",lang), "typedoc", "Provider?type=page&id=typedoc&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Вид доставки",lang), getLocalizedWord("Вид доставки",lang), "deliverytype", "Provider?type=page&id=deliverytype&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категория граждан",lang), getLocalizedWord("Категория граждан",lang), "cat", "Provider?type=page&id=cat"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Номенклатура дел",lang), getLocalizedWord("Номенклатура дел",lang), "nomentypelist", "Provider?type=page&id=nomentypelist&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категория корреспондентов",lang), getLocalizedWord("Категория корреспондентов",lang), "corrcatlist", "Provider?type=page&id=corrcatlist&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Корреспонденты",lang), getLocalizedWord("Корреспонденты",lang), "corrlist", "Provider?type=page&id=corrlist&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Адресат",lang), getLocalizedWord("Адресат",lang), "addressee", "Provider?type=page&id=addressee&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Регион/Город",lang), getLocalizedWord("Регион/Город",lang), "city", "Provider?type=page&id=city"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Проекты",lang), getLocalizedWord("Проекты",lang), "projectsprav", "Provider?type=page&id=projectsprav"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип договора",lang), getLocalizedWord("Тип договора",lang), "contracttype", "Provider?type=page&id=contracttype"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип конечного документа",lang), getLocalizedWord("Тип конечного документа",lang), "finaldoctype", "Provider?type=page&id=finaldoctype"))
			outline.addOutline(glossary_outline)
			list.add(glossary_outline)
		}
		

		setContent(list)
	}

    def addEntryByProjects(_Session session, def entry, formid, fieldtype){

        def projects = session.getCurrentDatabase().getGroupedEntries("project#${fieldtype == ""? "number" : fieldtype}", 1, 20);
        def cdb = session.getCurrentDatabase();
        def pageid = "docsbyproject";

        if(formid == 'officememoprj' || formid == 'outgoingprj')
            pageid = "prjbyproject";

        projects.each{
            def name = cdb.getGlossaryDocument(new BigDecimal(it.getViewText()).intValue())?.getName();
            if(name != null && name != ""){
               entry.addEntry(new _OutlineEntry(name, name, formid + it.getViewText(), "Provider?type=page&id=$pageid&projectid=${it.getViewText()}&formid=$formid&page=0"));
            }
        }
        return entry;
    }

    def addEntryByFinalDocType(_Session session, def entry, formid){

        def projects = session.getCurrentDatabase().getGroupedEntries("finaldoctype#number", 1, 20);
        def cdb = session.getCurrentDatabase();
        def pageid = "prjbyfinaldoctype";
        if(formid == "workdoc")
            pageid = "docsbyfinaldoctype";
        for(it in projects){
            try{
                int docid = it.getViewText().toDouble().toInteger()
                def name = cdb.getGlossaryDocument(docid)?.getName();
                if(name != null && name != ""){
                    entry.addEntry(new _OutlineEntry(name, name, formid + it.getViewText(), "Provider?type=page&id=$pageid&finaldoctype=$docid&formid=$formid&page=0"));
                }
            }catch(Exception e){}
        }

        return entry;
    }

	def addEntryByGlossary(_Session session, def entry, formid, glossaryform, isproject){

		def projects = session.getCurrentDatabase().getGroupedEntries("$glossaryform#number", 1, 20);
		def cdb = session.getCurrentDatabase();
		def pageid ="docsbyglossary";
		if(isproject){
			pageid = "docsbyglossaryprj"
		}
		projects.each{
			try{
				int docid = it.getViewText().toDouble().toInteger()
				def name = cdb.getGlossaryDocument(docid)?.getName();
				if(name != null && name != ""){
					entry.addEntry(new _OutlineEntry(name, name, formid + it.getViewText(), "Provider?type=page&id=$pageid&glossaryform=$glossaryform&glossaryid=$docid&formid=$formid&page=0"));
				}
			}catch(Exception e){
				println(e)
			}
		}

		return entry;
	}
}
