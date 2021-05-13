class DebugTools {
  static const int typeNameLength = 25;

  static log(Object object, Object? message) {
    print((object.runtimeType.toString() + ":").padRight(typeNameLength) +
        message.toString());
  }
}

// shortcut für die Log Funktion
viLog(Object object, Object? message) {
  DebugTools.log(object, message);
}
