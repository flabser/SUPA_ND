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

        doc.addStringField("text", webFormData.getValue("text"))

        if (doc.isNewDoc) {
            doc.setForm("comment")
            doc.addStringField("proposal_id", webFormData.getValue("proposal_id"))
        }

        def author = session.getCurrentAppUser();

        // WARNING. Pomni porjadok viewtext[n] kriti4en
        doc.setViewText(doc.getValueString("text"))
        if (doc.isNewDoc) {
            doc.addViewText(doc.getValueString("text"))
            doc.addViewText(author.getFullName())
            doc.addViewText(doc.getValueString("proposal_id")) // viewtext3 = proposal_id
        } else {
            doc.setViewText(doc.getValueString("text"), 1)
            doc.setViewText(doc.getValueString("proposal_id"), 3) // viewtext3 = proposal_id
        }
        doc.setViewDate(new Date())
        //
        if (!doc.isNewDoc) {
            doc.setViewNumber(1) // changed
        } else {
            doc.addEditor(session.getUser().getUserID())
            doc.addReader(author.getUserID())
            doc.addEditor("[supervisor]")
        }
    }
}
