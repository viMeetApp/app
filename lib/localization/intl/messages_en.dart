// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(maxParticipants) =>
      "maximum ${maxParticipants} participants";

  static String m1(tag) => "${Intl.select(tag, {
            'culture': 'culture',
            'sport': 'sport',
            'sign': 'sign',
            'outdoor': 'outdoor',
            'indoor': 'indoor',
            'men': 'men',
            'women': 'women',
            'queer': 'queer',
            'food': 'food',
            'online': 'online',
            'other': 'undefined error',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "groupCreatorPageDescription":
            MessageLookupByLibrary.simpleMessage("Describe your Group"),
        "groupCreatorPageName": MessageLookupByLibrary.simpleMessage("Name"),
        "groupCreatorPageTitle":
            MessageLookupByLibrary.simpleMessage("Create new Group"),
        "groupFeedFindNewGroups":
            MessageLookupByLibrary.simpleMessage("Find new Groups"),
        "groupFeedPageTitle": MessageLookupByLibrary.simpleMessage("My Groups"),
        "postDate": MessageLookupByLibrary.simpleMessage("Date"),
        "postEditorCostsDialogTitle":
            MessageLookupByLibrary.simpleMessage("costs per person"),
        "postEditorMaxParticipants": m0,
        "postEditorMaxParticipantsDialaogTitle":
            MessageLookupByLibrary.simpleMessage("max participants"),
        "postEditorMoreInfo":
            MessageLookupByLibrary.simpleMessage("more information:"),
        "postEditorNoCosts": MessageLookupByLibrary.simpleMessage("no costs"),
        "postEditorOptionalInformation":
            MessageLookupByLibrary.simpleMessage("optional information:"),
        "postEditorPageTitle":
            MessageLookupByLibrary.simpleMessage("Create new Post"),
        "postEditorTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "postEditorUnlimitedParticipants":
            MessageLookupByLibrary.simpleMessage("unlimited participants"),
        "postLocation": MessageLookupByLibrary.simpleMessage("Location"),
        "postTag": m1,
        "postTime": MessageLookupByLibrary.simpleMessage("Start Time")
      };
}
