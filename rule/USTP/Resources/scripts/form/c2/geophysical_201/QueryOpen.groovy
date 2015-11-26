package form.c2.geophysical_201

import kz.nextbase.script.*
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.constants._DocumentModeType
import kz.nextbase.script.events._FormQueryOpen
import kz.nextbase.script.task._Control
import kz.pchelka.env.Environment


class QueryOpen extends _FormQueryOpen {

    @Override
    public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        publishValue("title", getLocalizedWord("Опасные геофизические явления", lang))
        def user = session.getCurrentAppUser()

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def actionBar = session.createActionBar();
        actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть без сохранения", lang), _ActionType.CLOSE))

        publishElement(actionBar)

        publishValue("status", "new")
        publishEmployer("author", session.getCurrentAppUser().getUserID())
        publishEmployer("taskauthor", session.getCurrentAppUser().getUserID())
        publishValue("taskdate", session.getCurrentDateAsString())
        publishValue('rtflimit', Environment.getRtfLimitSize())
    }

    def getRespProgress(_Document gdoc, _Session session) {
        String progress = "";
        gdoc.getResponses().each {
            progress += "<entry url='" + it.getFullURL().replace("&", "&amp;") + "'>" + "<viewtext>" + it.getViewText().replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;") + "</viewtext>" + "<responses>" + getRespProgress(it, session) + "</responses>" + "</entry>"
        };
        return progress;
    }

    @Override
    public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        publishValue('rtflimit', Environment.getRtfLimitSize())
        publishValue("title", getLocalizedWord("Задание", lang) + ": " + doc.getValueString("briefcontent"))
        def user = session.getCurrentAppUser()

        def nav = session.getPage("outline", webFormData)
        publishElement(nav)

        def control = (_Control) doc.getValueObject("control")
        def actionBar = session.createActionBar();

        if (doc.getEditMode() == _DocumentModeType.EDIT && control.getAllControl() != 0) {
            actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang), getLocalizedWord("Сохранить и закрыть", lang), _ActionType.SAVE_AND_CLOSE))
        }

        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang), getLocalizedWord("Закрыть без сохранения", lang), _ActionType.CLOSE))
        if (user.hasRole("supervisor")) {
            actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
        }

        publishElement(actionBar)

        publishEmployer("taskauthor", doc.getAuthorID())
        publishEmployer("author", doc.getValueString("taskauthor"))
        publishValue("taskvn", doc.getValueString("taskvn"))
        publishValue("taskdate", doc.getValueDate("taskdate"))
        publishValue("tasktype", doc.getValueString("tasktype"))
        publishValue("control", control)
        publishGlossaryValue("project", doc.getValueNumber("project"))
        publishGlossaryValue("category", doc.getValueNumber("category"))
        publishGlossaryValue("controltype", doc.getValueNumber("controltype"))
        publishValue("briefcontent", _Helper.getNormalizedRichText(doc.getValueString("briefcontent")))
        publishValue("comment", doc.getValueString("comment"))
        publishValue("content", _Helper.getNormalizedRichText(doc.getValueString("content")))

        publishValue("signedfields", doc.getSign());

        def taskauthor = session.getStructure().getEmployer(doc.getAuthorID());
        publishValue("taskauthorpk", taskauthor.getPublicKey());

        try {
            publishAttachment("rtfcontent", "rtfcontent")
        } catch (_Exception e) {
        }
    }
}
