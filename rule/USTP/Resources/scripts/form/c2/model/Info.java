package form.c2.model;


import java.util.Date;

public class Info {

    public String cardNumber;
    public Date cardDate;

    public String emergencyCode;
    public String emergencyType;

    public String shortDescription;

    // Place ? obj | KATO code
    public String incidentPlace;

    // Coordinates ? coordinates_az, coordinates_kv
    // show on maps: mobile device
    public String coordinates;

    // [List] Landmark near Coordinates
    // visible_landmarks
    // distance_from_visible_landmarks
    // show on maps: mobile device
    public String visibleLandmarks;

    // остальные данные через таблицы связи прикреплять к событию
    // типа
    // Приостановлено движение транспорта по направлениям
    // Железнодорожные пути
    // Аэровокзальный комплекс
    // Мосты
    //
    // приостановка движения может быть в любых ЧС не смотря пожар или землетрясение
    // и не может относиться только к одному типу ЧС
    //
    // смысл в гибкости
}
