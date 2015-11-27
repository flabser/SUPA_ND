package form.c2.model;


public class Human {
    // через таблицу связи прикреплять к событию
    // db table
    // fio | age | sex | isChildren by age? | isAffected | isDead | isRescued | isMissing | isFoundBySearchRescue | personnel_type:enum[k4s_mvd_rk,?]

    String fio;
    int age;
    String sex;

    boolean isChildren; // computed by age

    // почему по отдельности
    // может сперва пострадал, его спасли но все равно потом умер?
    // а может пострадал и спасен
    // ну и не хранить же в отдельных таблицах с повторами людей участников событий по признакам
    boolean isAffected;
    boolean isDead;
    boolean isRescued;

    boolean isMissing;
    boolean isFoundBySearchRescue;

}
