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

        def list = []
        def rootTag = new _Tag("current")
        def entryTag = new _Tag("entry", formData.getEncodedValueSilently("title"))
        entryTag.setAttr("entryid", formData.getValueSilently("entryid"))
        entryTag.setAttr("id", formData.getValueSilently("id"))
        rootTag.addTag(entryTag)

        def outline = new _Outline("", "", "outline")
        outline.addEntry(new _OutlineEntry(getLocalizedWord("Журнал для сбора предложений", lang), "", "suggestions", "Provider?type=page&id=suggestions"))
        list.add(outline)

        setContent(new _XMLDocument(rootTag))
        setContent(list)
    }
}
