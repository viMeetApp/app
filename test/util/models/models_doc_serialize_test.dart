import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/util/models/data_models.dart';

UserReference createUserReference(
    {String id = "", String name = "", String? picture}) {
  return UserReference(id: id, name: name, picture: picture);
}

void main() {
  test("serial DatabaseDocument", () {
    DatabaseDocument instance = DatabaseDocument(id: "123456789");

    // expected result
    Map serialized = {};

    expect(instance.toDoc(), equals(serialized));
  });

  test("serial UserGeneratedDocument", () {
    UserGeneratedDocument instance = UserGeneratedDocument(
        id: "123456789", author: createUserReference(id: "ABCDE123,"));

    // expected result
    Map serialized = {
      "author": {
        "id": "ABCDE123",
        "name": "test user",
        "picture": "example.jpg"
      }
    };

    expect(instance.toDoc(), equals(serialized));
  });
}
