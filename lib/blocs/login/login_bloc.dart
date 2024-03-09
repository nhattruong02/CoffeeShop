import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_1/models/user.dart';

import '../../repositories/api_services.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService _apiService;
  User user = User();

  LoginBloc(this._apiService) : super(LoginInitial()) {
    on<Submit>(_submit);
  }

  _submit(Submit event, Emitter<LoginState> emit) async {
    if (event.username.isEmpty) {
      emit(errorMessage("Username not null"));
    } else if (event.password.isEmpty) {
      emit(errorMessage("Password not null"));
    } else if (event.username.length > 20) {
      emit(errorMessage("Username less than 20 chars"));
    } else if (event.password.length > 10) {
      emit(errorMessage("Password is less than 10 chars"));
    } else {
      emit(LoginLoading());
      try {
        user = await _apiService.getUser(event.username, event.password);
        if (user.username.toString().trim() == event.username &&
            user.password.toString().trim() ==
                event.password.toString().trim()) {
          String role = user.role.toString().trim();
          emit(LoginSuccess("Success!", role));
        }
      } on Exception catch (e) {
        emit(LoginFailue("Fail!"));
      }
    }
  }
}
