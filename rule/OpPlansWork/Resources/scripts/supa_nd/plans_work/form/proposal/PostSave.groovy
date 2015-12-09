package supa_nd.plans_work.form.proposal

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.coordination._Block
import kz.nextbase.script.events._FormPostSave


class PostSave extends _FormPostSave {

    @Override
    public void doPostSave(_Session session, _Document doc) {

        createCoordinationBlockIfNotExists(session, doc)
    }

    private void createCoordinationBlockIfNotExists(_Session session, _Document doc) {
        if (!doc.isNewDoc) {
            return
        }

        def block = new _Block(session)
        block.setBlockID(doc.getDocID())
    }
}
