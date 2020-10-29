import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devsteam_test/repo/API/auth_API.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Auth authAPI;
  AuthBloc(this.authAPI) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is StartAuth) {
      yield IsAuthenticating();

      try {
        bool authStatus = await authAPI.hasAuthenticated(event.getToken);
        if (authStatus == true)
          yield AuthDone(authStatus, event.getToken);
        else
          AuthNotDone('Authentication script fired sucessfuly but reurned ' +
              authStatus.toString());
      } catch (exception) {
        yield AuthNotDone('Thrown at event-to-state ' + exception.toString());
      }
    } else if (event is DenyAuth) {
      yield AuthInitial();
    }
  }

  void dispose() {
    this.close();
  }
}
