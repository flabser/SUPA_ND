package reporting.form.c2.model;


public class DomesticAnimal {
    // связь с событием через eventGUID

    String guid;
    String eventGUID;

    String animalType;
    /*
    - крупного рогатого скота
    - мелкого рогатого скота
    - лошадей
    - птицы
    - водных организмов (гидробионтов)
    - прочие
     */

    int deadCount;
    int evacueesCount;
}
