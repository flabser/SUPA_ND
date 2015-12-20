package reporting.page.share_navigator

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.outline._Outline
import kz.nextbase.script.outline._OutlineEntry

class DoScript extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {
        def list = []
        def user = session.getCurrentAppUser()
        def outline = new _Outline("", "", "outline")

        def firerisk_outline = new _Outline(getLocalizedWord("Пожарная опасность", lang), getLocalizedWord("Пожарная опасность", lang), "tech")
        firerisk_outline.addEntry(new _OutlineEntry(getLocalizedWord("Метеостанции", lang), getLocalizedWord("Метеостанции", lang), "meteostations", "Provider?type=page&id=meteostations"))
        firerisk_outline.addEntry(new _OutlineEntry(getLocalizedWord("Показания", lang), getLocalizedWord("Показания", lang), "indications", "Provider?type=page&id=indications"))
        firerisk_outline.addEntry(new _OutlineEntry(getLocalizedWord("Прогноз", lang), getLocalizedWord("Прогноз", lang), "forecast", "Provider?type=page&id=forecast"))
        outline.addOutline(firerisk_outline)
        list.add(firerisk_outline)


        /*if (true || user.hasRole("administrator")) {
            def glossary_outline = new _Outline(getLocalizedWord("Справочники", lang), getLocalizedWord("Справочники", lang), "glossary")
            outline.addOutline(glossary_outline)
            list.add(glossary_outline)
        }*/

        setContent(list)
    }
}
