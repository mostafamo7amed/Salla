
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/cubits/register_cubit/states.dart';
import '../../../models/login_model.dart';
import '../../components/component.dart';
import '../../network/remote/dio_helper/dio_helper.dart';


class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit() : super(ShopInitState());

  static RegisterCubit getCubit(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: 'register',
        data: {
          'email':email,
          'password':password,
          'phone':phone,
          'name':name,
        }).then((value) {
      print(value.data);
      if(value.data['status']==true){
        loginModel = LoginModel.fromJson(value.data);
        emit(ShopRegisterSuccessState(loginModel!));
      }else{
        toast(message: value.data['message'], data: ToastStates.error);
        emit(ShopRegisterSuccessErrorState());
      }

    }).catchError((error){
      emit(ShopRegisterErrorState());
      print("error.............    ${error.toString()}");
    });
  }
  bool isPassword = false;

  changePasswordVisibility(){
    isPassword = !isPassword;
    emit(ShopRegisterPasswordState());
  }
}