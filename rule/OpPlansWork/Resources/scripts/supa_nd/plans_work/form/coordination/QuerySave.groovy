package supa_nd.plans_work.form.coordination

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave


/**
 * coordinator - author
 * decision
 */
class QuerySave extends _FormQuerySave {

    @Override
    public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

        def currentUser = session.getUser()

        if (doc.isNewDoc) {
            doc.setForm("coordination")
            def proposalDoc = session.getCurrentDatabase().getDocumentByID(webFormData.getValue("parent_id"))
            doc.setParentDoc(proposalDoc)
            //

        } else {
            if (currentUser.getUserID() != doc.getAuthorID()) {
                return
            }
        }
    }
}
