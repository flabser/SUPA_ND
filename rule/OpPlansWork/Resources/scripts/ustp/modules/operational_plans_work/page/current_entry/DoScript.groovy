package ustp.modules.operational_plans_work.page.share_navigator.current_entry

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript


class DoScript extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {
        def rootTag = new _Tag()
        def entryTag = new _Tag("entry", formData.getEncodedValueSilently("title"))
        entryTag.setAttr("entryid", formData.getValueSilently("entryid"))
        entryTag.setAttr("id", formData.getValueSilently("id"))
        if (formData.getEncodedValueSilently("id") == "search") {
            def searchTag = new _Tag("search", formData.getEncodedValueSilently("keyword"));
            searchTag.setAttr("search", formData.getEncodedValueSilently("keyword"))
            rootTag.addTag(searchTag)
            def customParam = new _Tag("customparam", "&keyword=" + formData.getEncodedValueSilently("keyword"))
            rootTag.addTag(customParam)
        }
        entryTag.setAttr("formid", formData.getValueSilently("formid"))

        rootTag.addTag(entryTag)
        def xml = new _XMLDocument(rootTag)
        setContent(xml);
    }
}
