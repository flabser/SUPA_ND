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

        def commentText = webFormData.getValue("text")
        //---------------------------------------------
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        if (doc.isNewDoc) {
            doc.addStringField("text", commentText)
            //
            doc.setViewDate(new Date()) // update time
            doc.setViewNumber(0)
            //
            doc.setViewText("comment")
            doc.addViewText(currentUser.getFullName())
            doc.addViewText(doc.getValueString("text"))
            //
            doc.addEditor(currentUser.getUserID())
            doc.addReader(currentUser.getUserID())
            doc.addEditor("[supervisor]")
        } else {
            if (commentText != doc.getValueString("text")) {
                doc.addStringField("text", commentText)
                //
                doc.setViewNumber(doc.getViewNumber() + 1) // comment is changed
                doc.setViewDate(new Date()) // update time
                //
                doc.setViewText(doc.getValueString("text"), 0)
            }
        }
        //---------------------------------------------
    }
}
