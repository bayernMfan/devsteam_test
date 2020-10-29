part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class StartAuth extends AuthEvent {
  final String _token;
  StartAuth([this._token]);
  get getToken => _token;
  @override
  List<Object> get props => [_token];
}

class DenyAuth extends AuthEvent {}
