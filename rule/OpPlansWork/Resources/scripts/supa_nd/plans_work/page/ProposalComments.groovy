package supa_nd.plans_work.page

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat


class ProposalComments extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def proposalId = formData.getValueSilently("proposal_id")
        if (!proposalId) {
            return
        }

        def viewParam = session.createViewEntryCollectionParam()
        viewParam.setQuery("form = 'comment' & viewtext3 = '$proposalId'")
                .setPageNum(0)
                .setPageSize(0)
                .setCheckResponse(false)
                .setDateFormat(new SimpleDateFormat("dd.MM.yyyy"))
        def col = session.getCurrentDatabase().getCollectionOfDocuments(viewParam)

        setContent(col)
    }
}
