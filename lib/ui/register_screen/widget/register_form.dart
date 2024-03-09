import 'package:bloc_api_1/ui/login_screen/screen/login_screen.dart';
import 'package:bloc_api_1/ui/main_screen/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/register/register_bloc.dart';
import '../../../blocs/register/register_event.dart';
import '../../../blocs/register/register_state.dart';
import '../../../repositories/api_services.dart';
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  Widget textFiel(String text, IconData icon, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(10),
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
  @override
  Widget build(BuildContext context) {
    final RegisterBloc _registerBloc = BlocProvider.of<RegisterBloc>(context);
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
                      height: 30,
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
                      child: const Text('REGISTER',
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
                              height: 30,
                            ),
                            textFiel('Full Name', Icons.person, fullname),
                            textFiel(
                                'Username/Email', Icons.mail_outline, username),
                            textFiel(
                                'Phone Number', Icons.phone_android, phone),
                            textFiel(
                                'Password', Icons.vpn_key_outlined, password),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 50,
                              width: 170,
                              child: BlocConsumer<RegisterBloc,RegisterState>(
                                listener: (context, state) {
                                  if(state is errorMessage){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Center(
                                            child: Text(state.messageError,style:
                                            TextStyle(color: Colors.black),)),
                                          backgroundColor: Colors.white,duration:
                                          Duration(seconds: 1),));
                                  }
                                  if(state is RegisterLoading){
                                    showDialog(context: context, builder: (context) => Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.blue),)));
                                  }
                                  if(state is RegisterSuccess){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Center(child: Text("Success!",style: TextStyle(color: Colors.black),)),
                                          backgroundColor: Colors.white,duration: Duration(seconds: 1),));
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                  if(state is RegisterFail){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Center(child: Text("Fail!",style: TextStyle(color: Colors.black),)),
                                          backgroundColor: Colors.white,duration: Duration(seconds: 1),));
                                  }
                                  }, builder: (context, state) => ElevatedButton(
                                      onPressed: () {
                                        _registerBloc.add(Register(
                                            fullname: fullname.text,
                                            username: username.text,
                                            phone: phone.text, password:
                                        password.text));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.deepOrange,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)))),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ))
                              ),

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already A Member?'),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Text('Sign in', style: TextStyle(
                                    color: Colors.deepOrange,),),
                                ),
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
            floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton.small(
              onPressed: () => Navigator.pop(context),
              backgroundColor: Colors.white,
              child:
              const Icon(Icons.arrow_back_ios_new, color: Colors.orange),)
        ),

      );
  }
}
