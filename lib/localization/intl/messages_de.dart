// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static String m0(maxParticipants) =>
      "maximal ${maxParticipants} Teilnehmende";

  static String m1(tag) => "${Intl.select(tag, {
            'culture': 'Kultur',
            'sport': 'Sport',
            'sign': 'Gebärden',
            'outdoor': 'Outdoor',
            'indoor': 'Indoor',
            'men': 'Männer',
            'women': 'Frauen',
            'queer': 'Queer',
            'food': 'Essen',
            'online': 'Online',
            'other': 'undefinierter Fehler',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "groupCreatorPageDescription":
            MessageLookupByLibrary.simpleMessage("Beschreibe deine Gruppe"),
        "groupCreatorPageName": MessageLookupByLibrary.simpleMessage("Name"),
        "groupCreatorPageTitle":
            MessageLookupByLibrary.simpleMessage("Neue Gruppe erstellen"),
        "groupFeedFindNewGroups":
            MessageLookupByLibrary.simpleMessage("Finde neue Gruppen"),
        "groupFeedPageTitle":
            MessageLookupByLibrary.simpleMessage("Meine Gruppen"),
        "postDate": MessageLookupByLibrary.simpleMessage("Datum"),
        "postEditorCostsDialogTitle":
            MessageLookupByLibrary.simpleMessage("Kosten pro Person"),
        "postEditorMaxParticipants": m0,
        "postEditorMaxParticipantsDialaogTitle":
            MessageLookupByLibrary.simpleMessage(
                "Maximale Teilnehmer*innenzahl"),
        "postEditorMoreInfo":
            MessageLookupByLibrary.simpleMessage("weitere Infos:"),
        "postEditorNoCosts":
            MessageLookupByLibrary.simpleMessage("keine Kosten festgelegt"),
        "postEditorOptionalInformation":
            MessageLookupByLibrary.simpleMessage("optionale Angaben:"),
        "postEditorPageTitle":
            MessageLookupByLibrary.simpleMessage("Neuen Post erstellen"),
        "postEditorTitle": MessageLookupByLibrary.simpleMessage("Titel"),
        "postEditorUnlimitedParticipants":
            MessageLookupByLibrary.simpleMessage("Teilnehmende unbegrenzt"),
        "postLocation": MessageLookupByLibrary.simpleMessage("Treffpunkt"),
        "postTag": m1,
        "postTime": MessageLookupByLibrary.simpleMessage("Startzeit")
      };
}
