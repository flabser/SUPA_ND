package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session


class ProposalService {

    public static void addChangeEvent(_Session session, _Document parentDoc, String text) {
        def doc = new _Document(session.currentDatabase)
        doc.setForm("event")
        doc.setParentDoc(parentDoc)
        //
        doc.addStringField("event", "change")
        doc.addStringField("text", text)
        //
        doc.setViewDate(new Date())
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        doc.setViewText(doc.getValueString("event"))
        doc.addViewText(session.user.fullName)
        doc.addViewText(text)
        //
        parentDoc.readers.each { doc.addReader(it.userID) }
        doc.addEditor(session.user.userID)
        doc.addEditor("[supervisor]")
        doc.save(session.user.userID)
    }

    public static void addCoordEvent(_Session session, _Document parentDoc, String decision, String text) {
        def doc = new _Document(session.currentDatabase)
        doc.setForm("event")
        doc.setParentDoc(parentDoc)
        //
        doc.addStringField("event", "coordination")
        doc.addStringField("text", text)
        doc.addStringField("decision", decision)
        //
        doc.setViewDate(new Date())
        // WARNING. Pomni porjadok viewtext[n] kriti4en
        doc.setViewText(doc.getValueString("event"))
        doc.addViewText(session.user.fullName)
        doc.addViewText(text)
        doc.addViewText(decision)
        //
        parentDoc.readers.each { doc.addReader(it.userID) }
        doc.addEditor(session.user.userID)
        doc.addEditor("[supervisor]")
        doc.save(session.user.userID)
    }
}
