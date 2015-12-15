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
                break
            case "coord_agree":
                doCoordinationAgree(session, doc)
                break
            case "coord_revision":
                doCoordinationRevision(session, doc)
                break
            case "coord_reject":
                doCoordinationReject(session, doc)
                break
        }
    }

    private void doCoordinationStart(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        def block = blockCollection.getBlocks().get(0)
        //
        // sostavit' posledovatel'nyi spisok soglasovanija
        // block soglasovanija dolzhen byt' 1
        // spisok sobrat' soglasno ierarhii posledovatel'nosti
        //
        def isCurrent = true
        session.getStructure().getAllEmployers().each {
            def coordinator = new _Coordinator(session.getCurrentDatabase().getBaseObject())
            coordinator.setUserID(it.getUserID())
            coordinator.setCurrent(isCurrent)
            block.addCoordinator(coordinator)
            isCurrent = false
        }

        doc.save()
        //
        ProposalService.addCoordEvent(session, doc, "start", "")
    }

    private void doCoordinationAgree(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        //
        ProposalService.addCoordEvent(session, doc, "agree", "")
    }

    private void doCoordinationRevision(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        //
        ProposalService.addCoordEvent(session, doc, "revision", "")
    }

    private void doCoordinationReject(_Session session, _Document doc) {
        def blockCollection = (_BlockCollection) doc.getValueObject("coordination")
        //
        ProposalService.addCoordEvent(session, doc, "reject", "")
    }
}
