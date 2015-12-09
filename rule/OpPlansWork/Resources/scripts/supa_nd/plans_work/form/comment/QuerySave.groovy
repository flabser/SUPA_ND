package supa_nd.plans_work.form.comment

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        // TODO : доступ на редактирование
        // редактирует автор, посмотреть нет ли ответа, таймаут на изменение

        def currentUser = session.getUser();

        if (doc.isNewDoc) {
            doc.setForm("comment")
            doc.addStringField("proposal_id", webFormData.getValue("proposal_id"))
        } else {
            if (currentUser.getUserID() != doc.getAuthorID()) {
                return
            }
        }

        def comment = doc.getValueString("text")
        doc.addStringField("text", webFormData.getValue("text"))

        //---------------------------------------------
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        doc.setViewDate(new Date()) // update time
        doc.setViewText(doc.getValueString("text"))
        if (doc.isNewDoc) {
            doc.addViewText(doc.getValueString("text"))
            doc.addViewText(currentUser.getFullName())
            doc.addViewText(doc.getValueString("proposal_id")) // viewtext3 = proposal_id
            doc.setViewNumber(0)
            //
            doc.addEditor(currentUser.getUserID())
            doc.addReader(currentUser.getUserID())
            doc.addEditor("[supervisor]")
        } else {
            doc.setViewText(doc.getValueString("text"), 1)
            //
            if (comment != doc.getValueString("text")) {
                doc.setViewNumber(doc.getViewNumber() + 1) // comment is changed
            }
        }
        //---------------------------------------------
    }
}
