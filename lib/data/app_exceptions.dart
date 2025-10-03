class AppExceptions implements Exception{
  final _messages;
  final _prefix;

  AppExceptions([this._messages,this._prefix]);
  String toString(){
    return '$_messages$_prefix';
  }
}

class FetchDataException extends AppExceptions{
  FetchDataException([String? message]) : super(message,'Error During Communication');
}
class BadRequestException extends AppExceptions{
  BadRequestException([String? message]) : super(message,'Invalid Request');
}
class UnAuthorizedException extends AppExceptions{
  UnAuthorizedException([String? message]) : super(message,'UnAuthorized Request');
}
class InvalidInputException extends AppExceptions{
  InvalidInputException([String? message]) : super(message,'Invalid Input');
}