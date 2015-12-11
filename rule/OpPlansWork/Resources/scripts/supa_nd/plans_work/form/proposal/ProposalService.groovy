package supa_nd.plans_work.form.proposal

import kz.flabs.users.User
import kz.nextbase.script._Document
import kz.nextbase.script._Session


class ProposalService {

    public static void addComment(_Session session, _Document doc, User author, String commentText) {
        def commentDoc = new _Document(session.getCurrentDatabase())
        commentDoc.setForm("comment")
        commentDoc.setParentDoc(doc)
        //
        commentDoc.addStringField("text", commentText)
        //
        commentDoc.setViewNumber(0)
        commentDoc.setViewDate(new Date()) // update time
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        commentDoc.setViewText(commentText)
        commentDoc.addViewText(author.getFullName())
        //
        commentDoc.addEditor(author.getUserID())
        commentDoc.addEditor("[supervisor]")
        commentDoc.save("[supervisor]")
    }

    public static void addEvent(_Session session, _Document doc, String eventType, String text) {
        def commentDoc = new _Document(session.getCurrentDatabase())
        commentDoc.setForm("event")
        commentDoc.setParentDoc(doc)
        //
        commentDoc.addStringField("eventType", eventType)
        commentDoc.addStringField("text", text)
        //
        commentDoc.setViewDate(new Date())
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        commentDoc.setViewText(eventType)
        commentDoc.addViewText(text)
        commentDoc.addViewText(session.getUser().getFullName())
        //
        commentDoc.save("[supervisor]")
    }
}
