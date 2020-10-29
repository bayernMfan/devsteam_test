part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class IsAuthenticating extends AuthState {}

class AuthDone extends AuthState {
  final _status;
  final _token;

  AuthDone(this._status, this._token);

  //String get getAuthToken => _data;
  bool get getAuthStatus => _status;
  String get getAuthToken => _token;
  @override
  List<Object> get props => [_status, _token];
}

class AuthNotDone extends AuthState {
  final String _message;
  AuthNotDone(this._message);
  get getMessage => _message;
  @override
  List<Object> get props => [_message];
}
