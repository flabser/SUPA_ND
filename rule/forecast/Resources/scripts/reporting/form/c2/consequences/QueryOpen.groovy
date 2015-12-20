package reporting.form.c2.consequences

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        publishValue("title", "consequences")

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        publishValue("title", "consequences")

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        publishElement(actionBar)

        publishValue("fio", doc.getValueString("fio"))
        publishValue("sex", doc.getValueString("sex"))
        publishValue("age", doc.getValueNumber("age"))

        publishValue("human_in_zone_emergency_count", doc.getValueNumber("human_in_zone_emergency_count"))

        publishValue("affected_count", doc.getValueNumber("affected_count"))
        publishValue("affected_children_count", doc.getValueNumber("affected_children_count"))
        publishValue("affected_personnel_k4s_mvd_rk_count", doc.getValueNumber("affected_personnel_k4s_mvd_rk_count"))

        publishValue("dead_count", doc.getValueNumber("dead_count"))
        publishValue("dead_children_count", doc.getValueNumber("dead_children_count"))
        publishValue("dead_personnel_k4s_mvd_rk_count", doc.getValueNumber("dead_personnel_k4s_mvd_rk_count"))

        publishValue("rescued_count", doc.getValueNumber("rescued_count"))
        publishValue("rescued_children_count", doc.getValueNumber("rescued_children_count"))

        publishValue("missing_count", doc.getValueNumber("missing_count"))
        publishValue("missing_children_count", doc.getValueNumber("missing_children_count"))
        publishValue("missing_personnel_k4s_mvd_rk_count", doc.getValueNumber("missing_personnel_k4s_mvd_rk_count"))

        publishValue("search_rescue_found_count", doc.getValueNumber("search_rescue_found_count"))
        publishValue("search_rescue_taken_medical_count", doc.getValueNumber("search_rescue_taken_medical_count"))
        publishValue("search_rescue_taken_medical_k4s_mvd_rk_count", doc.getValueNumber("search_rescue_taken_medical_k4s_mvd_rk_count"))

        publishValue("requiring_evacuation_people_count", doc.getValueNumber("requiring_evacuation_people_count"))
        publishValue("evacuees_count", doc.getValueNumber("evacuees_count"))
        publishValue("evacuees_children_count", doc.getValueNumber("evacuees_children_count"))

        publishValue("first_aid_count", doc.getValueNumber("first_aid_count"))
        publishValue("first_aid_children_count", doc.getValueNumber("first_aid_children_count"))

        publishValue("hospitalized_count", doc.getValueNumber("hospitalized_count"))
        publishValue("hospitalized_children_count", doc.getValueNumber("hospitalized_children_count"))

        publishValue("homeless_count", doc.getValueNumber("homeless_count"))
        publishValue("homeless_children_count", doc.getValueNumber("homeless_children_count"))

        publishValue("dead_domestic_animal_count", doc.getValueNumber("dead_domestic_animal_count"))
        publishValue("evacuees_domestic_animal_count", doc.getValueNumber("evacuees_domestic_animal_count"))
    }
}
