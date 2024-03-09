
abstract class LoginEvent{
}
class Submit extends LoginEvent{
  String username ='';
  String password = '';
  Submit({required this.username, required this.password});

}