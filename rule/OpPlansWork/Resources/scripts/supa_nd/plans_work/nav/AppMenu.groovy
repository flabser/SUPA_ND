package supa_nd.plans_work.nav

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.outline._Outline
import kz.nextbase.script.outline._OutlineEntry


class AppMenu extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def currentTag = new _Tag("current")
        currentTag.setAttr("entryid", formData.getValueSilently("entryid"))
        currentTag.setAttr("id", formData.getValueSilently("id"))

        def outline = new _Outline("", "", "outline")
        outline.addEntry(new _OutlineEntry(getLocalizedWord("Перечень предложений", lang), "", "list-proposals", "Provider?type=page&id=list-proposals"))
        outline.addEntry(new _OutlineEntry(getLocalizedWord("Журнал предложений", lang), "", "journal-proposals", "Provider?type=page&id=journal-proposals"))

        setContent(new _XMLDocument(currentTag))
        setContent(outline)
    }
}