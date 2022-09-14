import 'package:salla/models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeState extends ShopStates {}
class ShopSuccessHomeState extends ShopStates {}
class ShopErrorHomeState extends ShopStates {}


class ShopLoadingCategoryState extends ShopStates {}
class ShopSuccessCategoryState extends ShopStates {}
class ShopErrorCategoryState extends ShopStates {}


class ShopChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
  ChangeFavoritesModel changeFavoritesModel;
  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}
class ShopErrorChangeFavoritesState extends ShopStates {
  ChangeFavoritesModel changeFavoritesModel;
  ShopErrorChangeFavoritesState(this.changeFavoritesModel);
}

class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}
class ShopSuccessGetUserDataState extends ShopStates {}
class ShopErrorGetUserDataState extends ShopStates {}