import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/util/models/data_models.dart';

void main() {
  test("serial DatabaseDocument", () {
    DatabaseDocument instance = DatabaseDocument(id: "123456789");

    // expected result
    Map serialized = {};

    expect(instance.toMap(), equals(serialized));
  });

  test("serial UserGeneratedDocument", () {
    UserGeneratedDocument instance = UserGeneratedDocument(
        id: "123456789",
        author: UserReference(id: "ABCDE123", name: "test user"));

    // expected result
    Map serialized = {
      "author": {
        "id": "ABCDE123",
        "name": "test user",
      }
    };

    expect(instance.toMap(), equals(serialized));
  });

  test("serial User", () {
    User instance = User(
        id: "123456789",
        name: "super user",
        picture: "example.jpg",
        savedPosts: ["987654321"]);

    // expected result
    Map serialized = {
      "name": "super user",
      "picture": "example.jpg",
      "savedPosts": ["987654321"]
    };

    expect(instance.toMap(), equals(serialized));
  });

  test("serial Post", () {
    Post instance = Post(
        id: "123456789",
        author: UserReference.empty(),
        title: "example post",
        createdAt: 42,
        expiresAt: 62,
        type: PostType.event,
        geohash: "ABCDE",
        tags: [PostTag.food, PostTag.online]);

    // expected result
    Map serialized = {
      "author": {"id": "", "name": ""},
      "title": "example post",
      "createdAt": 42,
      "expiresAt": 62,
      "type": "event",
      "geohash": "ABCDE",
      "tags": {"food": true, "online": true}
    };

    expect(instance.toMap(), equals(serialized));
  });

  test("serial Event", () {
    Event instance = Event(
        id: "123456789",
        author: UserReference.empty(),
        title: "example post",
        createdAt: 42,
        expiresAt: 62,
        type: PostType.event,
        geohash: "ABCDE",
        tags: [PostTag.food, PostTag.online],
        about: "this is the about text",
        maxParticipants: 12,
        costs: "14€",
        eventLocation: "Bahnhof");

    // expected result
    Map serialized = {
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

    expect(instance.toMap(), equals(serialized));
  });

  test("serial Buddy", () {
    Buddy instance = Buddy(
        id: "123456789",
        author: UserReference.empty(),
        title: "example post",
        createdAt: 42,
        expiresAt: 62,
        type: PostType.event,
        geohash: "ABCDE",
        tags: [PostTag.food, PostTag.online],
        buddy: UserReference(id: "32168", name: "buddy user"));

    // expected result
    Map serialized = {
      "author": {"id": "", "name": ""},
      "title": "example post",
      "createdAt": 42,
      "expiresAt": 62,
      "type": "event",
      "geohash": "ABCDE",
      "tags": {"food": true, "online": true},
      "buddy": {"id": "32168", "name": "buddy user"},
    };

    expect(instance.toMap(), equals(serialized));
  });

  test("serial Group", () {
    Group instance = Group(
      id: "123456789",
      name: 'test group',
      about: 'this is a group',
      isPrivate: false,
      members: [GroupUserReference(id: "abcd", name: "Max", isAdmin: false)],
      requestedToJoin: [UserReference(id: "xyz", name: "Justus")],
    );

    // expected result
    Map serialized = {
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

    expect(instance.toMap(), equals(serialized));
  });

  test("serial Report", () {
    Report instance = Report(
        id: "123456789",
        author: UserReference.empty(),
        reasons: [ReportReason.copyright, ReportReason.hate],
        objectReference: "C137",
        reportedAt: 1234,
        type: ReportType.user,
        state: ReportState.open);

    // expected result
    Map serialized = {
      "author": {"id": "", "name": ""},
      "reasons": ["copyright", "hate"],
      "objectReference": "C137",
      "reportedAt": 1234,
      "type": "user",
      "state": "open"
    };

    expect(instance.toMap(), equals(serialized));
  });

  test("serial BugReport", () {
    BugReport instance = BugReport(
        id: "123456789",
        author: UserReference.empty(),
        title: "test report",
        message: "this is the discription",
        type: BugReportType.logic,
        reportedAt: 12345,
        version: "0.0.1-TEST",
        state: BugReportState.open,
        comment: "this is a comment");

    // expected result
    Map serialized = {
      "author": {"id": "", "name": ""},
      "title": "test report",
      "message": "this is the discription",
      "type": "logic",
      "reportedAt": 12345,
      "version": "0.0.1-TEST",
      "state": "open",
      "comment": "this is a comment"
    };

    expect(instance.toMap(), equals(serialized));
  });
}
