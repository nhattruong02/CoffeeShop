import 'package:bloc_api_1/blocs/login/login_bloc.dart';
import 'package:bloc_api_1/ui/main_screen/screen/main_screen.dart';
import 'package:bloc_api_1/ui/register_screen/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/login/login_event.dart';
import '../../../blocs/login/login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  static String role = "";

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();
    Widget textFiel(
        String text, IconData icon, TextEditingController controller) {
      return Container(
        padding: EdgeInsets.all(15),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: text,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
          ),
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background_login.jpg'),
                    fit: BoxFit.cover)),
          ),
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  child: const Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topCenter,
                width: double.infinity,
                child: const Text('WELCOME!!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white)),
              ),
              Container(
                margin: const EdgeInsets.all(30),
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      textFiel('Username/Email', Icons.mail_outline, _username),
                      textFiel('Password', Icons.vpn_key_outlined, _password),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      SizedBox(
                        height: 50,
                        width: 170,
                        child: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is errorMessage) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(
                                  state.messageError,
                                  style: TextStyle(color: Colors.black),
                                )),
                                backgroundColor: Colors.white,
                                duration: Duration(seconds: 1),
                              ));
                            }
                            if (state is LoginLoading) {
                              showDialog(
                                  context: context,
                                  builder: (context) => Center(
                                          child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation(Colors.blue),
                                      )));
                            }
                            if (state is LoginSuccess) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(
                                  state.messageSuccess,
                                  style: TextStyle(color: Colors.black),
                                )),
                                backgroundColor: Colors.white,
                                duration: Duration(seconds: 1),
                              ));
                              Navigator.pop(context, true);
                              LoginForm.role = state.role;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MainScreen(state.role),
                                  ));
                            }
                            if (state is LoginFailue) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Center(
                                    child: Text(
                                  state.messageFail,
                                  style: TextStyle(color: Colors.black),
                                )),
                                backgroundColor: Colors.white,
                                duration: Duration(seconds: 1),
                              ));
                              Navigator.pop(context, true);
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                                onPressed: () {
                                  print(state);
                                  _loginBloc.add(Submit(
                                      username: _username.text.trim(),
                                      password: _password.text.trim()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)))),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have a Account?'),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen())),
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.orange),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()))
        },
        child:
            const Icon(Icons.arrow_forward_ios_outlined, color: Colors.orange),
        backgroundColor: Colors.white,
      ),
    ));
  }
}
