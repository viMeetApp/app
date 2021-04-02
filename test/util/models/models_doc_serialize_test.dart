import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/util/models/data_models.dart';

void main() {
  test("serial DatabaseDocument", () {
    DatabaseDocument instance = DatabaseDocument(id: "123456789");

    // expected result
    Map serialized = {};

    expect(instance.toDoc(), equals(serialized));
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

    expect(instance.toDoc(), equals(serialized));
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

    expect(instance.toDoc(), equals(serialized));
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

    expect(instance.toDoc(), equals(serialized));
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

    expect(instance.toDoc(), equals(serialized));
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

    expect(instance.toDoc(), equals(serialized));
  });
}
