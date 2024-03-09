import 'package:bloc_api_1/blocs/register/register_bloc.dart';
import 'package:bloc_api_1/repositories/api_services.dart';
import 'package:bloc_api_1/ui/register_screen/widget/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(apiService),
        child: RegisterForm(),
      ),
    );
  }
}
