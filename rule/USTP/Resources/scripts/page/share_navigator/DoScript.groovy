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
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Пожары со взрывом, взрывы приведшие к пожару",lang), getLocalizedWord("Пожары со взрывом, взрывы приведшие к пожару",lang), "firewithexplosion", "Provider?type=page&id=firewithexplosion"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии с выбросом (угрозой выброса) ХОВ",lang), getLocalizedWord("Аварии с выбросом (угрозой выброса) ХОВ",lang), "emissionhov", "Provider?type=page&id=emissionhov"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Превышение ПДК вредных веществ в окружающей среде",lang), getLocalizedWord("Превышение ПДК вредных веществ в окружающей среде",lang), "pdk", "Provider?type=page&id=pdk"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии с выбросом (угрозой выброса) РВ",lang), getLocalizedWord("Аварии с выбросом (угрозой выброса) РВ",lang), "emissionrv", "Provider?type=page&id=emissionrv"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии с выбросом (угрозой выброса) БОВ",lang), getLocalizedWord("Аварии с выбросом (угрозой выброса) БОВ",lang), "emissionbov", "Provider?type=page&id=emissionbov"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Внезапное обрушение зданий, сооружений, пород",lang), getLocalizedWord("Внезапное обрушение зданий, сооружений, пород",lang), "buildingcollapse", "Provider?type=page&id=buildingcollapse"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии на электроэнергетических системах",lang), getLocalizedWord("Аварии на электроэнергетических системах",lang), "electricalaccidents", "Provider?type=page&id=electricalaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии на коммунальных системах жизнеобеспечения",lang), getLocalizedWord("Аварии на коммунальных системах жизнеобеспечения",lang), "communalaccidents", "Provider?type=page&id=communalaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии систем связи и телекоммуникаций",lang), getLocalizedWord("Аварии систем связи и телекоммуникаций",lang), "telecomaccidents", "Provider?type=page&id=telecomaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии на промышленных очистных сооружениях",lang), getLocalizedWord("Аварии на промышленных очистных сооружениях",lang), "industrialaccidents", "Provider?type=page&id=industrialaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Гидродинамические аварии",lang), getLocalizedWord("Гидродинамические аварии",lang), "hydrodynamicaccidents", "Provider?type=page&id=hydrodynamicaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Аварии в системах нефтегазового промышленного комплекса",lang), getLocalizedWord("Аварии в системах нефтегазового промышленного комплекса",lang), "gasaccidents", "Provider?type=page&id=gasaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("ЧС космического характера",lang), getLocalizedWord("ЧС космического характера",lang), "spaceaccidents", "Provider?type=page&id=spaceaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Загорания не подлежащие учету как пожар",lang), getLocalizedWord("Загорания не подлежащие учету как пожар",lang), "ignition", "Provider?type=page&id=ignition"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Пожары",lang), getLocalizedWord("Пожары",lang), "controltype", "Provider?type=page&id=fire"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Производственные аварии и ЧС",lang), getLocalizedWord("Производственные аварии и ЧС",lang), "workaccident", "Provider?type=page&id=workaccident"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("Несчастные случаи в быту",lang), getLocalizedWord("Несчастные случаи в быту",lang), "lifeaccidents", "Provider?type=page&id=lifeaccidents"))
		tech_outline.addEntry(new _OutlineEntry(getLocalizedWord("ЧС за пределами государства",lang), getLocalizedWord("ЧС за пределами государства",lang), "outsideaccidents", "Provider?type=page&id=outsideaccidents"))
		outline.addOutline(tech_outline)
		list.add(tech_outline)

		def nature_outline = new _Outline(getLocalizedWord("Природные ЧС",lang), getLocalizedWord("Природные ЧС",lang), "nature")
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Опасные геофизические явления",lang), getLocalizedWord("Опасные геофизические явления",lang), "geophysical-201", "Provider?type=page&id=geophysical-201"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Геологические опасные явления",lang), getLocalizedWord("Геологические опасные явления",lang), "geological", "Provider?type=page&id=geological"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Метеорологические и агрометеорологические опасные явления",lang), getLocalizedWord("Метеорологические и агрометеорологические опасные явления",lang), "meteo", "Provider?type=page&id=meteo"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Морские опасные гидрологические явления",lang), getLocalizedWord("Морские опасные гидрологические явления",lang), "seagidrogeo", "Provider?type=page&id=seagidrogeo"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Гидрологические опасные явления",lang), getLocalizedWord("Гидрологические опасные явления",lang), "gidro", "Provider?type=page&id=gidro"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Гидрогеологические опасные явления",lang), getLocalizedWord("Гидрогеологические опасные явления",lang), "gidrogeo", "Provider?type=page&id=gidrogeo"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Природные пожары",lang), getLocalizedWord("Природные пожары",lang), "naturefire", "Provider?type=page&id=naturefire"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Инфекционные заболевания людей",lang), getLocalizedWord("Инфекционные заболевания людей",lang), "infectionpeople", "Provider?type=page&id=infectionpeople"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Отравления людей",lang), getLocalizedWord("Отравления людей",lang), "poisonpeople", "Provider?type=page&id=poisonpeople"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Инфекционные заболевания сельскохозяйственных животных",lang), getLocalizedWord("Инфекционные заболевания сельскохозяйственных животных",lang), "infectionanimal", "Provider?type=page&id=infectionanimal"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Массовое отравление сельскохозяйственных животных",lang), getLocalizedWord("Массовое отравление сельскохозяйственных животных",lang), "poisonanimal", "Provider?type=page&id=poisonanimal"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Массовое заболевание и гибель диких животных",lang), getLocalizedWord("Массовое заболевание и гибель диких животных",lang), "mdwildanimal", "Provider?type=page&id=mdwildanimal"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Поражение сельскохозяйственных растений болезнями и вредителями",lang), getLocalizedWord("Поражение сельскохозяйственных растений болезнями и вредителями",lang), "dwagricultur", "Provider?type=page&id=dwagricultur"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния суши",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния суши",lang), "eschangeland", "Provider?type=page&id=eschangeland"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состава и свойств атмосферы",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состава и свойств атмосферы",lang), "eschangeatmo", "Provider?type=page&id=eschangeatmo"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния гидросферы",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния гидросферы",lang), "eschangegidro", "Provider?type=page&id=eschangegidro"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния биосферы",lang), getLocalizedWord("Чрезвычайные ситуации, связанные с изменением состояния биосферы",lang), "eschangebio", "Provider?type=page&id=eschangebio"))
		nature_outline.addEntry(new _OutlineEntry(getLocalizedWord("Пострадавшие на водах",lang), getLocalizedWord("Пострадавшие на водах",lang), "victimsonwaters", "Provider?type=page&id=victimsonwaters"))
		list.add(nature_outline)
		outline.addOutline(nature_outline)

		def social_outline = new _Outline(getLocalizedWord("Социально-политические ЧС",lang), getLocalizedWord("Социально-политические ЧС",lang), "social")
		social_outline.addEntry(new _OutlineEntry(getLocalizedWord("Нарушения общественного порядка",lang), getLocalizedWord("Нарушения общественного порядка",lang), "disorderlyconduct", "Provider?type=page&id=disorderlyconduct"))
		list.add(social_outline)
		outline.addOutline(social_outline)

		if (user.hasRole("administrator")){
			def glossary_outline = new _Outline(getLocalizedWord("Справочники",lang), getLocalizedWord("Справочники",lang), "glossary")
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип ЧС",lang), getLocalizedWord("Тип ЧС",lang), "estype", "Provider?type=page&id=estype"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Вид ЧС",lang), getLocalizedWord("Вид ЧС",lang), "estype", "Provider?type=page&id=essubtype"))
			outline.addOutline(glossary_outline)
			list.add(glossary_outline)
		}
		

		setContent(list)
	}

}
