package form.c2.model;


// Возможные зоны поражения
public class PotentialZoneDestruction {
    // связь с событием через eventGUID

    String guid;
    String eventGUID;

    /*
    затопления
    пожаров
    химического заражения
    радиационного заражения
     */
    String riskType;

    // show on maps
    String coordinates;
    String distance;
}
