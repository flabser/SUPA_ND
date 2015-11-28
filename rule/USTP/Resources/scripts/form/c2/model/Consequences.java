package form.c2.model;

import java.util.List;


public class Consequences {
    // связь с событием через eventGUID

    String guid;
    String eventGUID;

    int human_in_zone_emergency_count;

    int affected_count;
    int affected_children_count;
    int affected_personnel_k4s_mvd_rk_count; // ?

    int dead_count;
    int dead_children_count;
    int dead_personnel_k4s_mvd_rk_count; // ?

    int rescued_count;
    int rescued_children_count;

    int missing_count;
    int missing_children_count;
    int missing_personnel_k4s_mvd_rk_count;

    int search_rescue_found_count;
    int search_rescue_taken_medical_count;
    int search_rescue_taken_medical_k4s_mvd_rk_count;

    int requiring_evacuation_people_count;
    int evacuees_count;
    int evacuees_children_count;

    int first_aid_count;
    int first_aid_children_count;

    int hospitalized_count;
    int hospitalized_children_count;

    int homeless_count;
    int homeless_children_count;

    int dead_domestic_animal_count;
    int evacuees_domestic_animal_count;

    List<Human> humans;
    List<DomesticAnimal> domesticAnimals;
}
