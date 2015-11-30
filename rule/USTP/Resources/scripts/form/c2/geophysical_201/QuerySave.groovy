package form.c2.geophysical_201

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


public class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        doc.setForm("geophysical-201");

        doc.addStringField("card_number", webFormData.getValue("card_number"));
        doc.addStringField("card_date", webFormData.getValue("card_date"));
        doc.addStringField("emergency_code", webFormData.getValue("emergency_code"));
        doc.addStringField("emergency_type", webFormData.getValue("emergency_type"));
        doc.addStringField("emergency_date", webFormData.getValue("emergency_date"));
        doc.addStringField("short_description", webFormData.getValue("short_description"));
        // doc.addStringField("incident_place", webFormData.getValue("incident_place"))
        // doc.addStringField("coordinates", webFormData.getValue("coordinates"))

        doc.setViewText(doc.getValueString("card_number"));
        doc.addViewText(doc.getValueString("card_number"));
        doc.addViewText(doc.getValueString("card_date"));
        doc.addViewText(doc.getValueString("emergency_code"));
        doc.addViewText(doc.getValueString("emergency_type"));
        doc.addViewText(doc.getValueString("emergency_date"));
        doc.addViewText(doc.getValueString("short_description"));
        //
        doc.addEditor(session.getUser().getUserID());
        doc.addEditor("[supervisor]");
        //
        addConsequencesDoc(session, doc, webFormData);
        //
        setRedirectURL(session.getURLOfLastPage());
    }

    def addConsequencesDoc(_Session session, _Document doc, _WebFormData webFormData) {
        def consequencesDoc;
        if (doc.isNewDoc) {
            consequencesDoc = new _Document(session.getCurrentDatabase());
        } else {
            String eventId = doc.getID()
            def viewParam = session.createViewEntryCollectionParam();
            viewParam.setQuery("form = 'human' & parentdocddbid = '" + eventId + "'")
                    .setPageNum(0)
                    .setPageSize(1)
                    .setCheckResponse(false);

            def col = session.getCurrentDatabase().getCollectionOfDocuments(viewParam);
            consequencesDoc = col.getEntries().iterator().next().getDocument();
        }

        consequencesDoc.setForm("consequences");
        consequencesDoc.setParentDoc(doc);

        consequencesDoc.addNumberField("human_in_zone_emergency_count", webFormData.getNumberValueSilently("human_in_zone_emergency_count", 0));

        consequencesDoc.addNumberField("affected_count", webFormData.getNumberValueSilently("affected_count", 0));
        consequencesDoc.addNumberField("affected_children_count", webFormData.getNumberValueSilently("affected_children_count", 0));
        consequencesDoc.addNumberField("affected_personnel_k4s_mvd_rk_count", webFormData.getNumberValueSilently("affected_personnel_k4s_mvd_rk_count", 0));

        consequencesDoc.addNumberField("dead_count", webFormData.getNumberValueSilently("dead_count", 0));
        consequencesDoc.addNumberField("dead_children_count", webFormData.getNumberValueSilently("dead_children_count", 0));
        consequencesDoc.addNumberField("dead_personnel_k4s_mvd_rk_count", webFormData.getNumberValueSilently("dead_personnel_k4s_mvd_rk_count", 0));

        consequencesDoc.addNumberField("rescued_count", webFormData.getNumberValueSilently("rescued_count", 0));
        consequencesDoc.addNumberField("rescued_children_count", webFormData.getNumberValueSilently("rescued_children_count", 0));

        consequencesDoc.addNumberField("missing_count", webFormData.getNumberValueSilently("missing_count", 0));
        consequencesDoc.addNumberField("missing_children_count", webFormData.getNumberValueSilently("missing_children_count", 0));
        consequencesDoc.addNumberField("missing_personnel_k4s_mvd_rk_count", webFormData.getNumberValueSilently("missing_personnel_k4s_mvd_rk_count", 0));

        consequencesDoc.addNumberField("search_rescue_found_count", webFormData.getNumberValueSilently("search_rescue_found_count", 0));
        consequencesDoc.addNumberField("search_rescue_taken_medical_count", webFormData.getNumberValueSilently("search_rescue_taken_medical_count", 0));
        consequencesDoc.addNumberField("search_rescue_taken_medical_k4s_mvd_rk_count", webFormData.getNumberValueSilently("search_rescue_taken_medical_k4s_mvd_rk_count", 0));

        consequencesDoc.addNumberField("requiring_evacuation_people_count", webFormData.getNumberValueSilently("requiring_evacuation_people_count", 0));
        consequencesDoc.addNumberField("evacuees_count", webFormData.getNumberValueSilently("evacuees_count", 0));
        consequencesDoc.addNumberField("evacuees_children_count", webFormData.getNumberValueSilently("evacuees_children_count", 0));

        consequencesDoc.addNumberField("first_aid_count", webFormData.getNumberValueSilently("first_aid_count", 0));
        consequencesDoc.addNumberField("first_aid_children_count", webFormData.getNumberValueSilently("first_aid_children_count", 0));

        consequencesDoc.addNumberField("hospitalized_count", webFormData.getNumberValueSilently("hospitalized_count", 0));
        consequencesDoc.addNumberField("hospitalized_children_count", webFormData.getNumberValueSilently("hospitalized_children_count", 0));

        consequencesDoc.addNumberField("homeless_count", webFormData.getNumberValueSilently("homeless_count", 0));
        consequencesDoc.addNumberField("homeless_children_count", webFormData.getNumberValueSilently("homeless_children_count", 0));

        consequencesDoc.addNumberField("dead_domestic_animal_count", webFormData.getNumberValueSilently("dead_domestic_animal_count", 0));
        consequencesDoc.addNumberField("evacuees_domestic_animal_count", webFormData.getNumberValueSilently("evacuees_domestic_animal_count", 0));

        consequencesDoc.addEditor(session.getUser().getUserID());
        consequencesDoc.addEditor("[supervisor]");
        consequencesDoc.save("[supervisor]");
    }
}
