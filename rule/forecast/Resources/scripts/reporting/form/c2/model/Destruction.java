package reporting.form.c2.model;

import java.util.List;


public class Destruction {
    // связь с событием через eventGUID

    String guid;
    String eventGUID;

    List<reporting.page.form.c2.model.PostOfMonitoringWarning> postsOfMonitoringWarning;
    List<RiskZone> riskZones;
}
