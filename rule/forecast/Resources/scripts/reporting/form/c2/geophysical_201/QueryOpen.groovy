package reporting.form.c2.geophysical_201

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        publishValue("title", getLocalizedWord("Опасные геофизические явления", lang))

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть", lang), _ActionType.CLOSE))
        publishElement(actionBar)
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        publishValue("title", getLocalizedWord("Опасные геофизические явления", lang))

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть", lang), _ActionType.CLOSE))
        publishElement(actionBar)

        publishValue("card_number", doc.getValueString("card_number"))
        publishValue("card_date", doc.getValueString("card_date"))
        publishValue("emergency_code", doc.getValueString("emergency_code"))
        publishValue("emergency_type", doc.getValueString("emergency_type"))
        publishValue("emergency_date", doc.getValueString("emergency_date"))
        publishValue("short_description", doc.getValueString("short_description"))
        //
        def consequencesDoc = null;
        def responses = doc.getResponses()
        for (def rDoc : responses) {
            if (rDoc.getDocumentForm() == 'consequences') {
                consequencesDoc = rDoc;
                break;
            }
        }

        if (consequencesDoc) {
            publishValue("human_in_zone_emergency_count", consequencesDoc.getValueNumber("human_in_zone_emergency_count"))

            publishValue("affected_count", consequencesDoc.getValueNumber("affected_count"))
            publishValue("affected_children_count", consequencesDoc.getValueNumber("affected_children_count"))
            publishValue("affected_personnel_k4s_count", consequencesDoc.getValueNumber("affected_personnel_k4s_count"))

            publishValue("dead_count", consequencesDoc.getValueNumber("dead_count"))
            publishValue("dead_children_count", consequencesDoc.getValueNumber("dead_children_count"))
            publishValue("dead_personnel_k4s_count", consequencesDoc.getValueNumber("dead_personnel_k4s_count"))

            publishValue("rescued_count", consequencesDoc.getValueNumber("rescued_count"))
            publishValue("rescued_children_count", consequencesDoc.getValueNumber("rescued_children_count"))

            publishValue("missing_count", consequencesDoc.getValueNumber("missing_count"))
            publishValue("missing_children_count", consequencesDoc.getValueNumber("missing_children_count"))
            publishValue("missing_personnel_k4s_count", consequencesDoc.getValueNumber("missing_personnel_k4s_count"))

            publishValue("searchrescue_found_count", consequencesDoc.getValueNumber("searchrescue_found_count"))
            publishValue("searchrescue_taken_med_count", consequencesDoc.getValueNumber("searchrescue_taken_med_count"))
            publishValue("searchrescue_taken_med_k4s_count", consequencesDoc.getValueNumber("searchrescue_taken_med_k4s_count"))

            publishValue("requiring_evacuation_count", consequencesDoc.getValueNumber("requiring_evacuation_count"))
            publishValue("evacuees_count", consequencesDoc.getValueNumber("evacuees_count"))
            publishValue("evacuees_children_count", consequencesDoc.getValueNumber("evacuees_children_count"))

            publishValue("first_aid_count", consequencesDoc.getValueNumber("first_aid_count"))
            publishValue("first_aid_children_count", consequencesDoc.getValueNumber("first_aid_children_count"))

            publishValue("hospitalized_count", consequencesDoc.getValueNumber("hospitalized_count"))
            publishValue("hospitalized_children_count", consequencesDoc.getValueNumber("hospitalized_children_count"))

            publishValue("homeless_count", consequencesDoc.getValueNumber("homeless_count"))
            publishValue("homeless_children_count", consequencesDoc.getValueNumber("homeless_children_count"))

            publishValue("dead_domestic_animal_count", consequencesDoc.getValueNumber("dead_domestic_animal_count"))
            publishValue("evacuees_domestic_animal_count", consequencesDoc.getValueNumber("evacuees_domestic_animal_count"))

            publishValue("monitoring_warning_post_count", consequencesDoc.getValueNumber("monitoring_warning_post_count"))
        }
    }
}
