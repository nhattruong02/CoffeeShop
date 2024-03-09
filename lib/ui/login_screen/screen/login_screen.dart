import 'package:bloc_api_1/blocs/login/login_bloc.dart';
import 'package:bloc_api_1/repositories/api_services.dart';
import 'package:bloc_api_1/ui/login_screen/widget/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginScreen extends StatelessWidget {
  final ApiService apiService;
  LoginScreen({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(apiService),
        child: LoginForm(),
    ),
    );
  }
}
