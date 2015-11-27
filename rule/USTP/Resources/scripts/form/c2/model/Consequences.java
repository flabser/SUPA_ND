package form.c2.model;


import java.util.List;

public class Consequences {
    // через таблицу связи прикреплять к событию

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

    // List <Human>; через таблицу связи
    List<Human> humans;

}
