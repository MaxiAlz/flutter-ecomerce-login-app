class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

class ConnectionTomeOut implements Exception {}

class CustomError implements Exception {
  final String message;

  // final String errorCode;
  CustomError({required this.message, });
}
