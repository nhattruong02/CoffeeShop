abstract class RegisterEvent{

}
class Register extends RegisterEvent{
  final String fullname;
  final String username;
  final String phone;
  final String password;


  Register({required this.fullname,required this.username,required this.phone,required this.password});

}