
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/cubits/login_cubit/states.dart';
import '../../../models/login_model.dart';
import '../../components/component.dart';
import '../../network/remote/dio_helper/dio_helper.dart';


class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(ShopInitState());

  static LoginCubit getCubit(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  shopLogin({
    required String email,
    required String password,
  }){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: 'login',
        data: {
          'email':email,
          'password':password,
        }).then((value) {
      print(value.data);
      if(value.data['status']==true){
        loginModel = LoginModel.fromJson(value.data);
        emit(ShopLoginSuccessState(loginModel!));
      }else{
        toast(message: value.data['message'], data: ToastStates.error);
        emit(ShopLoginSuccessErrorState());
      }

    }).catchError((error){
      emit(ShopLoginErrorState());
      print("error.............    ${error.toString()}");
    });
  }
  bool isPassword = false;

  changePasswordVisibility(){
    isPassword = !isPassword;
    emit(ShopLoginPasswordState());
  }
}