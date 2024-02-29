// 'cancelled' The operation was cancelled (typically by the caller).
class OperationTerminateException implements Exception {
  final String message = 'Operation terminated by user';
}

// 'unauthenticated' The request does not have valid authentication credentials for the operation.
class UnauthenticatedException implements Exception {
  final String message = 'User Not Logged In';
}

// 'permission-denied' The caller does not have sufficient permission to perform the operation.
class UnauthorizedException implements Exception {
  final String message = 'User Not Authorized';
}

// 'not-found' The requested document or collection does not exist
class NoDataFoundException implements Exception {
  final String message = 'No Data Found';
}

// 'aborted' The operation was aborted, typically due to a concurrency issue like transaction aborts.
class OperationFailedException implements Exception {
  final String message = 'Operation Failed';
}

// Generic Exception
class GenericLeaveException implements Exception {
  final String message;

  GenericLeaveException(this.message);
}
