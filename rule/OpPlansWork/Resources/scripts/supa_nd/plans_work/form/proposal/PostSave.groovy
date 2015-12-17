package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.coordination._Coordinator
import kz.nextbase.script.events._FormPostSave


class PostSave extends _FormPostSave {

    @Override
    public void doPostSave(_Session session, _Document doc) {

        def action = doc.getValueString("_action")
        switch (action) {
            case "coord_start":
                doCoordinationStart(session, doc)
                doc.save()
                break
            case "coord_agree":
                doCoordinationAgree(session, doc)
                doc.save()
                break
            case "coord_revision":
                doCoordinationRevision(session, doc)
                doc.save()
                break
            case "coord_reject":
                doCoordinationReject(session, doc)
                doc.save()
                break
        }
    }

    private void doCoordinationStart(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        def block = blockCollection.blocks[0]
        //
        // sostavit' posledovatel'nyi spisok soglasovanija
        // block soglasovanija dolzhen byt' 1
        // spisok sobrat' soglasno ierarhii posledovatel'nosti
        //
        def isCurrent = true
        // TODO collect coordinator
        session.structure.allEmployers.each {
            def coordinator = new _Coordinator(session.currentDatabase.baseObject)
            coordinator.setUserID(it.userID)
            coordinator.setCurrent(isCurrent)
            block.addCoordinator(coordinator)
            isCurrent = false
            //
            doc.addEditor(it.userID)
        }
        //
        ProposalService.addCoordEvent(session, doc, "start", "")
        //
        // TODO send notify to current coordinator
    }

    private void doCoordinationAgree(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        //
        ProposalService.addCoordEvent(session, doc, "agree", "")
        //
        // TODO notify current
        def block = blockCollection.getCurrentBlock()
        def coordinator = block.getCurrentCoordinators().get(0)
    }

    private void doCoordinationRevision(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        def block = blockCollection.getCurrentBlock()
        def coordinator = block.getCurrentCoordinators()
        //
        // TODO set prev coordinator & notify
    }

    private void doCoordinationReject(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        //
        ProposalService.addCoordEvent(session, doc, "reject", "")
        //
        // TODO set prev coordinator & notify
    }
}
