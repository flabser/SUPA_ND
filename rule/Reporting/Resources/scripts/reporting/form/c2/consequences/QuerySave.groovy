package form.c2.consequences

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("consequences")

        doc.addStringField("fio", webFormData.getValue("fio"))
        doc.addNumberField("age", webFormData.getNumberValueSilently("age", 0))
        doc.addStringField("sex", webFormData.getValue("sex"))

        doc.addNumberField("human_in_zone_emergency_count", webFormData.getNumberValueSilently("human_in_zone_emergency_count", 0))
        doc.addNumberField("affected_count", webFormData.getNumberValueSilently("affected_count", 0))
        doc.addNumberField("affected_children_count", webFormData.getNumberValueSilently("affected_children_count", 0))
        doc.addNumberField("affected_personnel_k4s_mvd_rk_count", webFormData.getNumberValueSilently("affected_personnel_k4s_mvd_rk_count", 0))

        doc.addNumberField("dead_count", webFormData.getNumberValueSilently("dead_count", 0))
        doc.addNumberField("dead_children_count", webFormData.getNumberValueSilently("dead_children_count", 0))
        doc.addNumberField("dead_personnel_k4s_mvd_rk_count", webFormData.getNumberValueSilently("dead_personnel_k4s_mvd_rk_count", 0))

        doc.addNumberField("rescued_count", webFormData.getNumberValueSilently("rescued_count", 0))
        doc.addNumberField("rescued_children_count", webFormData.getNumberValueSilently("rescued_children_count", 0))

        doc.addNumberField("missing_count", webFormData.getNumberValueSilently("missing_count", 0))
        doc.addNumberField("missing_children_count", webFormData.getNumberValueSilently("missing_children_count", 0))
        doc.addNumberField("missing_personnel_k4s_mvd_rk_count", webFormData.getNumberValueSilently("missing_personnel_k4s_mvd_rk_count", 0))

        doc.addNumberField("search_rescue_found_count", webFormData.getNumberValueSilently("search_rescue_found_count", 0))
        doc.addNumberField("search_rescue_taken_medical_count", webFormData.getNumberValueSilently("search_rescue_taken_medical_count", 0))
        doc.addNumberField("search_rescue_taken_medical_k4s_mvd_rk_count", webFormData.getNumberValueSilently("search_rescue_taken_medical_k4s_mvd_rk_count", 0))

        doc.addNumberField("requiring_evacuation_people_count", webFormData.getNumberValueSilently("requiring_evacuation_people_count", 0))
        doc.addNumberField("evacuees_count", webFormData.getNumberValueSilently("evacuees_count", 0))
        doc.addNumberField("evacuees_children_count", webFormData.getNumberValueSilently("evacuees_children_count", 0))

        doc.addNumberField("first_aid_count", webFormData.getNumberValueSilently("first_aid_count", 0))
        doc.addNumberField("first_aid_children_count", webFormData.getNumberValueSilently("first_aid_children_count", 0))

        doc.addNumberField("hospitalized_count", webFormData.getNumberValueSilently("hospitalized_count", 0))
        doc.addNumberField("hospitalized_children_count", webFormData.getNumberValueSilently("hospitalized_children_count", 0))

        doc.addNumberField("homeless_count", webFormData.getNumberValueSilently("homeless_count", 0))
        doc.addNumberField("homeless_children_count", webFormData.getNumberValueSilently("homeless_children_count", 0))

        doc.addNumberField("dead_domestic_animal_count", webFormData.getNumberValueSilently("dead_domestic_animal_count", 0))
        doc.addNumberField("evacuees_domestic_animal_count", webFormData.getNumberValueSilently("evacuees_domestic_animal_count", 0))

        doc.setViewText(doc.getValueString("fio"))
        doc.addViewText(doc.getValueString("fio"))
        doc.addViewText(doc.getValueString("sex"))
        doc.setViewNumber(doc.getValueNumber("age"))
        //
        doc.addEditor(session.getUser().getUserID())
        doc.addEditor("[supervisor]")
    }
}
