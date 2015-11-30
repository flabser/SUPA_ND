package form.c2.model;

import java.util.List;


public class Destruction {
    // связь с событием через eventGUID

    String guid;
    String eventGUID;

    int post_of_monitoring_warning_count;

    List<PostOfMonitoringWarning> postsOfMonitoringWarning;
    List<PotentialRiskZone> potentialRiskZones;
}
