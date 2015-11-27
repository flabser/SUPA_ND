package form.c2.model;

public class Consequences {

    int human_in_zone_emergency_count;

    int affected_count;
    int affected_children_count;
    int affected_personnel_k4s_mvd_rk_count; // ?

    int dead_count;
    int dead_children_count;
    int dead_personnel_k4s_mvd_rk_count; // ?

    // List <Human>; через таблицу связи
    // db table
    // fio | age | sex | isChildren by age? | isAffected | isDead | isRescued | personnel_type:enum[k4s_mvd_rk,?]
    String humans;

}
