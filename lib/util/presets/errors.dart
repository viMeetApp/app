/// An exception to handle errors specific to the ViMeet app
class ViException implements Exception {
  late String _message;

  ViException([String message = ""]) {
    _message = "ViException: " + message;
  }

  @override
  String toString() {
    return _message;
  }
}

/// A generic exception to handle permission errors within the app
class ViPermissionException extends ViException {
  ViPermissionException([String message = "unknown exception"])
      : super("PermissionException: " + message);
}

/// A generic exception to handle service errors within the app
class ViServiceException extends ViException {
  ViServiceException([String message = "unknown exception"])
      : super("ServiceException: " + message);
}

/// An exception for handling the case that users denied the apps permission to the location API
class ViServiceLocationException extends ViServiceException {
  ViServiceLocationException() : super("location service");
}

/// An exception for handling the case that users denied the apps permission to the location API
class ViPermissionLocationException extends ViPermissionException {
  ViPermissionLocationException() : super("permission denied");
}

/// An exception for handling the case that users denied the apps permission to the location API
class ViImageUploadException extends ViServiceException {
  ViImageUploadException() : super("Firebase Storage Upload");
}
