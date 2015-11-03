package page.prjbyfinaldoctype

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat

/**
 * Created by Bekzat on 2/17/14.
 */
class DoScript extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {
        //	println(formData)
        def page = 1;
        if (formData.containsField("page") && formData.getValue("page")){
            page = Integer.parseInt(formData.getValue("page"))
        }
        def formid = formData.getValue("formid");
        def finaldoctype = formData.getValue("finaldoctype")
        def formula = "form='$formid' and finaldoctype#number=$finaldoctype";

        def db = session.getCurrentDatabase()
        def col = db.getCollectionOfDocuments(formula, page, true, true, new SimpleDateFormat("dd.MM.yyyy"))
        setContent(col)
    }
}