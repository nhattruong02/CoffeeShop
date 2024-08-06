import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_api_1/blocs/register/register_event.dart';
import 'package:bloc_api_1/blocs/register/register_state.dart';


import '../../models/user.dart';
import '../../repositories/api_services.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  final ApiService _apiService;
  RegisterBloc(this._apiService) : super (RegisterInitial()){
    on<Register>(_register);
  }

  Future _register(Register event, Emitter<RegisterState> emit) async {
    if (event.username.isEmpty) {
      emit(errorMessage("Username not null"));
    }else if(event.username.length > 20){
      emit(errorMessage("Username less than 20 chars"));
    }
    else if (event.password.isEmpty) {
      emit(errorMessage("Password not null"));
    }
    else if (event.password.length > 10) {
      emit(errorMessage("Password is less than 10 chars"));
    }
    else if (event.fullname.isEmpty) {
      emit(errorMessage("Password not null"));
    }
    else if (event.fullname.length > 50) {
      emit(errorMessage("Full name is less than 50 chars"));
    }
    else if (event.phone.isEmpty) {
      emit(errorMessage("Phone not null"));
    }else if (event.phone.length > 10) {
      emit(errorMessage("Phone is less than 10 chars"));
    } else {
      emit(RegisterLoading());
      User user = User(event.fullname.toString().trim(), event.username.toString().trim(),
          event.password.toString().trim(), event.phone.toString().trim());
      final result = await _apiService.postUser(user);
      if (result != null) {
        emit(RegisterSuccess());
      }
      else {
        emit(RegisterFail());
      }
    }
  }
}