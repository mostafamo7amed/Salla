import '../../../models/login_model.dart';

abstract class LoginStates {}

class ShopInitState extends LoginStates {}

class ShopLoginSuccessState extends LoginStates {
  final LoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginSuccessErrorState extends LoginStates {
}
class ShopLoginLoadingState extends LoginStates {}
class ShopLoginErrorState extends LoginStates {}

class ShopLoginPasswordState extends LoginStates {}