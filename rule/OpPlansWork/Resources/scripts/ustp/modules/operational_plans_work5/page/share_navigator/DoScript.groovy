package ustp.modules.operational_plans_work5.page.share_navigator

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

        def opPlansWorkOutline = new _Outline(getLocalizedWord("Операционные планы и планы работы подразделений", lang), "", "op_plans_work")
        opPlansWorkOutline.addEntry(new _OutlineEntry(getLocalizedWord("Журнал для сбора предложений", lang), "", "suggestions", "Provider?type=page&id=suggestions"))
        list.add(opPlansWorkOutline)
        outline.addOutline(opPlansWorkOutline)

        setContent(list)
    }
}
