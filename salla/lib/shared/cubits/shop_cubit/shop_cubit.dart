import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/change_favorites_model.dart';
import 'package:salla/models/favorites_model.dart';
import 'package:salla/models/login_model.dart';
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

  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int?, bool?> favorites = {};

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
      url: home,
      lang: 'en',
      token: token,
    ).then((value) {
      //print(value.data.toString());
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel!.data!.banners![0].image);
      //print(homeModel!.data!.products![0].inFavourite);
      for (var element in homeModel!.data!.products!) {
        favorites.addAll({element.id: element.inFavourite});
      }
      print(favorites.toString());
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
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
    }).catchError((error) {
      emit(ShopErrorCategoryState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int? productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel?.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState(changeFavoritesModel!));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      lang: 'en',
      token: token,
    ).then((value) {
      //print(value.data.toString());
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel!.data.data[1].product.image);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel? userDataModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      lang: 'en',
      token: token,
    ).then((value) {
      //print(value.data.toString());
      userDataModel = LoginModel.fromJson(value.data);
      print(userDataModel!.data!.name);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState());
    });
  }

  LoginModel? updateUserModel;
  void updateUserData({
    required name,
    required email,
    required phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: 'update-profile',
      lang: 'en',
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {
      //print(value.data.toString());
      updateUserModel = LoginModel.fromJson(value.data);
      print(updateUserModel!.data!.toString());
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error) {
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
