import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/util/models/data_models.dart';

void main() {
  test("DatabaseDocument serialization", () {
    Map<String, dynamic> serialized = {"id": "ABCD1234"};

    expect(DatabaseDocument.fromMap(serialized).toMap(includeID: true),
        equals(serialized));
  });

  test("UserGeneratedDocument serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "author": {
        "id": "ABCDE123",
        "name": "test user",
      }
    };

    expect(UserGeneratedDocument.fromMap(serialized).toMap(includeID: true),
        equals(serialized));
  });

  test("UserReference serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "name": "super user",
      "picture": "example.jpg"
    };

    expect(UserReference.fromMap(serialized).toMap(includeID: true),
        equals(serialized));
  });
  test("GroupUserReference serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "name": "super user",
      "picture": "example.jpg",
      "isAdmin": true
    };

    expect(GroupUserReference.fromMap(serialized).toMap(includeID: true),
        equals(serialized));
  });
  test("User serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "name": "super user",
      "picture": "example.jpg",
      "savedPosts": ["987654321"]
    };

    expect(User.fromMap(serialized).toMap(includeID: true), equals(serialized));
  });

  test("Post serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "author": {"id": "", "name": ""},
      "title": "example post",
      "createdAt": 42,
      "expiresAt": 62,
      "type": "event",
      "geohash": "ABCDE",
      "tags": {"food": true, "online": true}
    };

    expect(Post.fromMap(serialized).toMap(includeID: true), equals(serialized));
  });

  test("Event serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "author": {"id": "", "name": ""},
      "title": "example post",
      "createdAt": 42,
      "expiresAt": 62,
      "type": "event",
      "geohash": "ABCDE",
      "tags": {"food": true, "online": true},
      "about": "this is the about text",
      "maxParticipants": 12,
      "costs": "14€",
      "eventLocation": "Bahnhof"
    };

    expect(
        Event.fromMap(serialized).toMap(includeID: true), equals(serialized));
  });

  test("Buddy serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "author": {"id": "", "name": ""},
      "title": "example post",
      "createdAt": 42,
      "expiresAt": 62,
      "type": "event",
      "geohash": "ABCDE",
      "tags": {"food": true, "online": true},
      "buddy": {"id": "32168", "name": "buddy user"},
    };

    expect(
        Buddy.fromMap(serialized).toMap(includeID: true), equals(serialized));
  });

  test("Message serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "author": {"id": "", "name": ""},
      "createdAt": 12345,
      "type": "text",
      "content": "Hi! dies ist eine Nachricht."
    };

    expect(
        Message.fromMap(serialized).toMap(includeID: true), equals(serialized));
  });

  test("GroupReference serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "name": "super group",
      "picture": "example.jpg"
    };

    expect(GroupReference.fromMap(serialized).toMap(includeID: true),
        equals(serialized));
  });

  test("Group serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "name": 'test group',
      "about": 'this is a group',
      "isPrivate": false,
      "members": [
        {"id": "abcd", "name": "Max", "isAdmin": false}
      ],
      "requestedToJoin": [
        {"id": "xyz", "name": "Justus"}
      ],
    };

    expect(
        Group.fromMap(serialized).toMap(includeID: true), equals(serialized));
  });

  test("Report serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "author": {"id": "", "name": ""},
      "reasons": ["copyright", "hate"],
      "objectReference": "C137",
      "reportedAt": 1234,
      "type": "user",
      "state": "open"
    };

    expect(
        Report.fromMap(serialized).toMap(includeID: true), equals(serialized));
  });

  test("BugReport serialization", () {
    Map<String, dynamic> serialized = {
      "id": "123456789",
      "author": {"id": "", "name": ""},
      "title": "test report",
      "message": "this is the discription",
      "type": "logic",
      "reportedAt": 12345,
      "version": "0.0.1-TEST",
      "state": "open",
      "comment": "this is a comment"
    };
    expect(BugReport.fromMap(serialized).toMap(includeID: true),
        equals(serialized));
  });
}
