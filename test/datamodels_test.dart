// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/util/models/data_models.dart';

/// This class is necessary since DocumentSnapshot has no public constructor. Since the .fromDoc methods require a DocumentSnapshot as a parameter the only option was to create a semi-subclass of DocumentSnapshot.
class _DocSnap implements DocumentSnapshot {
  Map<String, dynamic> docdata;
  String id;
  _DocSnap(this.id, this.docdata);

  Map<String, dynamic> data() {
    return docdata;
  }

  /* these are not needed by the implementation */
  @override
  operator [](field) {
    throw UnimplementedError();
  }

  @override
  String get documentID => throw UnimplementedError();

  @override
  bool get exists => throw UnimplementedError();

  @override
  get(field) {
    throw UnimplementedError();
  }

  @override
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  DocumentReference get reference => throw UnimplementedError();
}

void main() {
  group("Map serialization", () {
    test("User", () {
      final serialized = {"id": "ABC12345", "name": "Max"};
      expect(User.fromMap(serialized).toMap(), serialized);
    });
    test("PostDetail", () {
      final serialized = {"id": "ABC12345", "value": "TestValue"};
      expect(PostDetail.fromMap(serialized).toMap(), serialized);
    });
    test("GroupInfo", () {
      final serialized = {"id": "ABC12345", "name": "TestValue"};
      expect(GroupInfo.fromMap(serialized).toMap(), serialized);
    });
  });

  group("Doc serialization", () {
    final id = "ABC12345";
    test("DatabaseDocument", () {
      final serialized = {"unused": true};
      expect(DatabaseDocument.fromDoc(_DocSnap(id, serialized)).toDoc(), null);
    });
    test("User", () {
      final serialized = {"name": "Max"};
      expect(User.fromDoc(_DocSnap(id, serialized)).toDoc(), serialized);
    });
    test("Group", () {
      final serialized = {
        "name": "Max",
        "about": "this is a group",
        "users": ["Alice", "Bob"],
        "admins": ["Tom", "John"],
        "requestedToJoin": ["Tim", "Julian"]
      };
      expect(Group.fromDoc(_DocSnap(id, serialized)).toDoc(), serialized);
    });
    test("Post", () {
      final serialized = {
        "title": "Titel des Posts",
        "geohash": "ABC12",
        "tags": {"Sport": true, "Kultur": true},
        "about": "Dies ist ein Post",
        "type": "post",
        "createdDate": 1234567,
        "expireDate": 7654321,
        "group": {"id": "GIID", "name": "Test Gruppe"},
        "author": {"id": "UerID", "name": "Max"},
        "details": [
          {"id": "treffpunkt", "value": "Bahnhof"},
          {"id": "kosten", "value": "10€"}
        ]
      };
      expect(Post.fromDoc(_DocSnap(id, serialized)).toDoc(), serialized);
    });
    //! Der Buddy Test ist momentan noch etwas unsinnig, da es der exakt gleiche wie bei 'Post' ist
    test("Buddy", () {
      final serialized = {
        "title": "Titel des Posts",
        "geohash": "ABC12",
        "tags": {"Sport": true, "Kultur": true},
        "about": "Dies ist ein Post",
        "type": "post",
        "createdDate": 1234567,
        "expireDate": 7654321,
        "group": {"id": "GIID", "name": "Test Gruppe"},
        "author": {"id": "UerID", "name": "Max"},
        "details": [
          {"id": "treffpunkt", "value": "Bahnhof"},
          {"id": "kosten", "value": "10€"}
        ]
      };
      expect(Buddy.fromDoc(_DocSnap(id, serialized)).toDoc(), serialized);
    });
    test("Event", () {
      final serialized = {
        "title": "Titel des Posts",
        "geohash": "ABC12",
        "tags": {"Sport": true, "Kultur": true},
        "about": "Dies ist ein Post",
        "type": "post",
        "createdDate": 1234567,
        "expireDate": 7654321,
        "group": {"id": "GIID", "name": "Test Gruppe"},
        "author": {"id": "UerID", "name": "Max"},
        "details": [
          {"id": "treffpunkt", "value": "Bahnhof"},
          {"id": "kosten", "value": "10€"}
        ],
        "eventDate": 2345678,
        "maxPeople": 7,
        "participants": ["Max", "Paul"]
      };
      expect(Event.fromDoc(_DocSnap(id, serialized)).toDoc(), serialized);
    });
    test("Message", () {
      final serialized = {
        "timestamp": 1234567,
        "type": "text",
        "content": "This is a message",
        "author": {"id": "UerID", "name": "Max"}
      };
      expect(Message.fromDoc(_DocSnap(id, serialized)).toDoc(), serialized);
    });
  });

  group('Constructors (using serialization)', () {
    test("User constructor", () {
      final User user = new User();
      user.name = "Max";
      user.id = "ABC12345";

      final userCon = new User(name: "Max", id: "ABC12345");
      expect(userCon.toMap(), user.toMap());
    });

    test("PostDetail constructor", () {
      final PostDetail postDetail = new PostDetail(id: "test", value: "test");
      postDetail.value = "Detail";
      postDetail.id = "ABC12345";

      final postDetailCon = new PostDetail(id: "ABC12345", value: "Detail");
      expect(postDetailCon.toMap(), postDetail.toMap());
    });

    test("GroupInfo constructor", () {
      final GroupInfo groupInfo = new GroupInfo(id: "test", name: "test");
      groupInfo.name = "Name";
      groupInfo.id = "ABC12345";

      final groupInfoCon = new GroupInfo(id: "ABC12345", name: "Name");
      expect(groupInfoCon.toMap(), groupInfo.toMap());
    });

    test("PostDetail constructor", () {
      final PostDetail postDetail = new PostDetail(id: "test", value: "test");
      postDetail.value = "Detail";
      postDetail.id = "ABC12345";

      final postDetailCon = new PostDetail(id: "ABC12345", value: "Detail");
      expect(postDetailCon.toMap(), postDetail.toMap());
    });
  });
}
