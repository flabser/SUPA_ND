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

        def currentUser = session.getUser()

        if (doc.isNewDoc) {
            doc.setForm("comment")
            def proposalDoc = session.getCurrentDatabase().getDocumentByID(webFormData.getValue("parent_id"))
            doc.setParentDoc(proposalDoc)
        } else {
            if (currentUser.getUserID() != doc.getAuthorID()) {
                return
            }
        }

        //---------------------------------------------
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        if (doc.isNewDoc) {
            doc.addStringField("text", webFormData.getValue("text"))
            //
            doc.setViewText(doc.getValueString("text"))
            doc.addViewText(currentUser.getFullName())
            doc.setViewNumber(0)
            doc.setViewDate(new Date()) // update time
            //
            doc.addEditor(currentUser.getUserID())
            doc.addReader(currentUser.getUserID())
            doc.addEditor("[supervisor]")
        } else {
            if (webFormData.getValue("text") != doc.getValueString("text")) {
                doc.addStringField("text", webFormData.getValue("text"))
                //
                doc.setViewText(doc.getValueString("text"), 0)
                doc.setViewNumber(doc.getViewNumber() + 1) // comment is changed
                doc.setViewDate(new Date()) // update time
            }
        }
        //---------------------------------------------
    }
}
