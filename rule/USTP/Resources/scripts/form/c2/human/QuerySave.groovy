package form.c2.human

import kz.nextbase.script.*
import kz.nextbase.script.constants._AllControlType
import kz.nextbase.script.events._FormQuerySave
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._ExecsBlocks


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("human")
        doc.addStringField("fio", webFormData.getValue("fio"))
        doc.addNumberField("age", webFormData.getNumberValueSilently("age", 0))
        doc.addStringField("sex", webFormData.getValue("sex"))

        int isAffected = webFormData.getNumberValueSilently("isAffected", 0)
        int isDead = webFormData.getNumberValueSilently("isDead", 0)
        int isRescued = webFormData.getNumberValueSilently("isRescued", 0)
        int isMissing = webFormData.getNumberValueSilently("isMissing", 0)
        int isFoundBySearchRescue = webFormData.getNumberValueSilently("isFoundBySearchRescue", 0)
        int isEvacuated = webFormData.getNumberValueSilently("isEvacuated", 0)
        int isFirstAid = webFormData.getNumberValueSilently("isFirstAid", 0)
        int isHomeless = webFormData.getNumberValueSilently("isHomeless", 0)

        doc.addNumberField("isAffected", isAffected)
        doc.addNumberField("isDead", isDead)
        doc.addNumberField("isRescued", isRescued)
        doc.addNumberField("isMissing", isMissing)
        doc.addNumberField("isFoundBySearchRescue", isFoundBySearchRescue)
        doc.addNumberField("isEvacuated", isEvacuated)
        doc.addNumberField("isFirstAid", isFirstAid)
        doc.addNumberField("isHomeless", isHomeless)

        def pdoc = doc.getParentDocument()

        doc.setViewText(doc.getValueString("fio"))
        //
        doc.addViewText(doc.getValueString("fio"))
        doc.addViewText(doc.getValueString("sex"))
        doc.setViewNumber(doc.getValueNumber("age"))

        def returnURL = session.getURLOfLastPage()
        setRedirectURL(returnURL)
    }
}
