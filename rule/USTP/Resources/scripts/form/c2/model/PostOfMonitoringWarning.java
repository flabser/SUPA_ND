package form.c2.model;


public class PostOfMonitoringWarning {
    // связь с событием через eventGUID

    String guid;
    String eventGUID;

    /*
    - центрально-диспетчерские пункт
    - Диспетчерские пункты
    - Станции наблюдения
    - посты наблюдения
       - круглогодичные
       - сезонные
    - линейные маршруты
       - водные
       - снегомерные
    - сейсмополигоны
    - сейсмостанции
     */
    String type;

    String name;
    String location;
    String appointment;
    String zoneResponsibility;
}
