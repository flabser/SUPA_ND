package ustp.modules.operational_plans_work2.page

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

class Assignees extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def empList = session.getStructure().getAllEmployers()

        setContent(empList)
    }
}
