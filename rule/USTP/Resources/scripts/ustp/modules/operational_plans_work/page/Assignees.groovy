package ustp.modules.operational_plans_work.page

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat


class Assignees extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def empList = session.getStructure().getAllEmployers()

        setContent(empList)
    }
}
