

import '../../../models/shopapp/changeFavoritesmodelPOST.dart';
import '../../../models/shopapp/profile_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}

class ShopErrorCategoriesDataState extends ShopStates{}

class ShopSuccessFavoritesDataState extends ShopStates{
  late final ChangeFavoritesModel model;
  ShopSuccessFavoritesDataState(this.model);

}

class ShopChangFavoritesDataState extends ShopStates{}

class ShopErrorFavoritesDataState extends ShopStates{}

class ShopSuccessGetFavoritesDataState extends ShopStates{}

class ShopErrorGetFavoritesDataState extends ShopStates{}

class ShopLoadingGetFavoritesDataState extends ShopStates{}

class ShopSuccessGetUserProfileDataState extends ShopStates{}

class ShopErrorGetUserProfileDataState extends ShopStates{}

class ShopLoadingGetUserProfileDataState extends ShopStates{}

class ShopSuccessUpdateUserProfileDataState extends ShopStates{

  late final  ShopProfileModel updatemodel;
  ShopSuccessUpdateUserProfileDataState(this.updatemodel);
}

class ShopErrorUpdateProfileDataState extends ShopStates{}

class ShopLoadingUpdateProfileDataState extends ShopStates{}



