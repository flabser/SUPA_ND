package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.coordination._Coordinator


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

    public static notifyCoordinator(_Session session, _Document doc, _Coordinator coordinator, String action) {
        // TODO notify coordinator
        System.out.println("--- send notify to coordinator $action ---")
        System.out.println(coordinator.userID)
        System.out.println("--- /send notify to coordinator ---")
    }

    public static notifyAuthorCoordStop(_Session session, _Document doc, _Coordinator coordinator, String action) {
        // TODO notify author
        System.out.println("--- send notify to author : $action ---")
        System.out.println(doc.getAuthorID())
        System.out.println("--- /send notify to author ---")
    }
}
