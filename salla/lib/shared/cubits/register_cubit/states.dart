import '../../../models/login_model.dart';

abstract class RegisterStates {}

class ShopInitState extends RegisterStates {}

class ShopRegisterSuccessState extends RegisterStates {
  final LoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}
class ShopRegisterSuccessErrorState extends RegisterStates {
}
class ShopRegisterLoadingState extends RegisterStates {}
class ShopRegisterErrorState extends RegisterStates {}

class ShopRegisterPasswordState extends RegisterStates {}