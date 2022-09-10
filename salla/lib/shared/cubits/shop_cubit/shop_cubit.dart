import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_states.dart';
import '../../../models/category_model.dart';
import '../../../models/home_model.dart';
import '../../../modules/category_screen/category_screen.dart';
import '../../../modules/favorite_screen/favorite_screen.dart';
import '../../../modules/home_screen/home_screen.dart';
import '../../../modules/settings_screen/settings_screen.dart';
import '../../components/constants.dart';
import '../../network/end_points.dart';
import '../../network/remote/dio_helper/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {

  ShopCubit() : super(ShopInitState());

  static ShopCubit getCubit(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens =[
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData(){
    emit(ShopLoadingHomeState());
    DioHelper.getData(
      url: home,
      lang: 'en',
      token: token,
    ).then((value) {
      //print(value.data.toString());
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.banners![0].image);
      emit(ShopSuccessHomeState());
    }).catchError((error){
      emit(ShopErrorHomeState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData(){
    emit(ShopLoadingCategoryState());
    DioHelper.getData(
      url: category,
      lang: 'en',
      token: token,
    ).then((value) {
      //print(value.data.toString());
      categoryModel = CategoryModel.fromJson(value.data);
      print(categoryModel!.data!.data![0].image);
      print(categoryModel!.data!.data![0].name);
      emit(ShopSuccessCategoryState());
    }).catchError((error){
      emit(ShopErrorCategoryState());
    });
  }
}