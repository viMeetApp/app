// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class ViLocalizations {
  ViLocalizations();

  static ViLocalizations? _current;

  static ViLocalizations get current {
    assert(_current != null,
        'No instance of ViLocalizations was loaded. Try to initialize the ViLocalizations delegate before accessing ViLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<ViLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = ViLocalizations();
      ViLocalizations._current = instance;

      return instance;
    });
  }

  static ViLocalizations of(BuildContext context) {
    final instance = ViLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of ViLocalizations present in the widget tree. Did you add ViLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static ViLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<ViLocalizations>(context, ViLocalizations);
  }

  /// `Treffpunkt`
  String get postLocation {
    return Intl.message(
      'Treffpunkt',
      name: 'postLocation',
      desc: '',
      args: [],
    );
  }

  /// `Datum`
  String get postDate {
    return Intl.message(
      'Datum',
      name: 'postDate',
      desc: '',
      args: [],
    );
  }

  /// `Startzeit`
  String get postTime {
    return Intl.message(
      'Startzeit',
      name: 'postTime',
      desc: '',
      args: [],
    );
  }

  /// `Neuen Post erstellen`
  String get postEditorPageTitle {
    return Intl.message(
      'Neuen Post erstellen',
      name: 'postEditorPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Titel`
  String get postEditorTitle {
    return Intl.message(
      'Titel',
      name: 'postEditorTitle',
      desc: '',
      args: [],
    );
  }

  /// `weitere Infos:`
  String get postEditorMoreInfo {
    return Intl.message(
      'weitere Infos:',
      name: 'postEditorMoreInfo',
      desc: '',
      args: [],
    );
  }

  /// `optionale Angaben:`
  String get postEditorOptionalInformation {
    return Intl.message(
      'optionale Angaben:',
      name: 'postEditorOptionalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Teilnehmende unbegrenzt`
  String get postEditorUnlimitedParticipants {
    return Intl.message(
      'Teilnehmende unbegrenzt',
      name: 'postEditorUnlimitedParticipants',
      desc: '',
      args: [],
    );
  }

  /// `maximal {maxParticipants} Teilnehmende`
  String postEditorMaxParticipants(Object maxParticipants) {
    return Intl.message(
      'maximal $maxParticipants Teilnehmende',
      name: 'postEditorMaxParticipants',
      desc: '',
      args: [maxParticipants],
    );
  }

  /// `Maximale Teilnehmer*innenzahl`
  String get postEditorMaxParticipantsDialaogTitle {
    return Intl.message(
      'Maximale Teilnehmer*innenzahl',
      name: 'postEditorMaxParticipantsDialaogTitle',
      desc: '',
      args: [],
    );
  }

  /// `keine Kosten festgelegt`
  String get postEditorNoCosts {
    return Intl.message(
      'keine Kosten festgelegt',
      name: 'postEditorNoCosts',
      desc: '',
      args: [],
    );
  }

  /// `Kosten pro Person`
  String get postEditorCostsDialogTitle {
    return Intl.message(
      'Kosten pro Person',
      name: 'postEditorCostsDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Meine Gruppen`
  String get groupFeedPageTitle {
    return Intl.message(
      'Meine Gruppen',
      name: 'groupFeedPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Finde neue Gruppen`
  String get groupFeedFindNewGroups {
    return Intl.message(
      'Finde neue Gruppen',
      name: 'groupFeedFindNewGroups',
      desc: '',
      args: [],
    );
  }

  /// `Neue Gruppe erstellen`
  String get groupCreatorPageTitle {
    return Intl.message(
      'Neue Gruppe erstellen',
      name: 'groupCreatorPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get groupCreatorPageName {
    return Intl.message(
      'Name',
      name: 'groupCreatorPageName',
      desc: '',
      args: [],
    );
  }

  /// `Beschreibe deine Gruppe`
  String get groupCreatorPageDescription {
    return Intl.message(
      'Beschreibe deine Gruppe',
      name: 'groupCreatorPageDescription',
      desc: '',
      args: [],
    );
  }

  /// `{tag, select, culture {Kultur} sport {Sport} sign {Gebärden} outdoor {Outdoor} indoor {Indoor} men {Männer} women {Frauen} queer {Queer} food {Essen} online {Online} other {undefinierter Fehler}}`
  String postTag(Object tag) {
    return Intl.select(
      tag,
      {
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
      },
      name: 'postTag',
      desc: 'Tag to describe an post',
      args: [tag],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<ViLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<ViLocalizations> load(Locale locale) => ViLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
