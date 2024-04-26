import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/state.dart';
import '../../../models/shopapp/categories_model.dart';
import '../../../models/shopapp/changeFavoritesmodelPOST.dart';
import '../../../models/shopapp/favorites_modelGET.dart';
import '../../../models/shopapp/home_model.dart';
import '../../../models/shopapp/profile_model.dart';
import '../../../modules/shop_app/catoegries/catoegries_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/setting/setting_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int curent_index=0;
  List<Widget> bottomScreens=[
    ProductScreen(),
    CatoegriesScreen(),
    FavoriteScreen(),
    SettingScreen()
  ];
  void changeBottom(int index)
  {
    curent_index=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? hommodel;
 late Map<int,bool>favorites={};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    Diohelper.get(url: HOME,leng: "en",
    ).then((value){
      hommodel=HomeModel.forjson(value.data);
     // printfulltext(hommodel!.data!.banner[0]!.image.toString());
      hommodel?.data.product.forEach((element) {
        favorites.addAll({
          element.id :element.in_favorites,
        });
      });
     print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorHomeDataState());
    }

    );
  }

 late CategoriesModel categoriesmodel;
  void getCategoriesData()
  {
    Diohelper.get(url: GET_CATORGRIES,leng: "en").then((value){
      categoriesmodel=CategoriesModel.forjson(value.data);
      printfulltext(categoriesmodel!.status.toString() );
      emit(ShopSuccessCategoriesDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorCategoriesDataState());
    }
    );
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites( int? id)
  {
    favorites[id as int]= !favorites[id]!;
    emit(ShopChangFavoritesDataState());
    Diohelper.postData(
        url: FAVORITES,
        data:{
          "product_id":id,
        },
      token: token,
      leng: "en"
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.forjson(value!.data);
      print(value.data);
      if(!changeFavoritesModel!.status) //vidoe 111 23m
        {
          favorites[id as int]= !favorites[id]!;
        }
      else{
        getFavorites();
      }
        emit(ShopSuccessFavoritesDataState(changeFavoritesModel!));
    }).catchError((onError)
    {
      favorites[id as int]= !favorites[id]!;
      emit(ShopErrorFavoritesDataState());
    }
    );
  }

  FavoritesModel? favoritesmodel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesDataState());
    Diohelper.get(
        url: FAVORITES,
        token: token,
      leng: "en"
    ).then((value){
      favoritesmodel=FavoritesModel.fromJson(value.data) ;
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopErrorGetFavoritesDataState());
    });
  }

  ShopProfileModel? usermodel;

  void getUserModel(){
    emit(ShopLoadingGetUserProfileDataState());
    Diohelper.get(
        url: PROFILE,
      token: token,
      leng: "en",
    ).then((value) {
      usermodel=ShopProfileModel.fromJson(value.data);
      print(usermodel?.data?.name);
      emit(ShopSuccessGetUserProfileDataState());
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorGetUserProfileDataState());
    }
    );
  }

  ShopProfileModel? updatemodel;

  void getUpdateModel(
  {
    @required String? name,
    @required String? email,
    @required String? phone,

}
      ){
    emit(ShopLoadingUpdateProfileDataState());
    Diohelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        "name":name,
        "email":email,
        "phone":phone
      },
   //   leng: "ar",
    ).then((value) {
      updatemodel=ShopProfileModel.fromJson(value?.data);
     // print(updatemodel?.data?.name);
      if(updatemodel!.status!)
        {
          showToast(text:updatemodel!.message! ,
              state: ToastState.SUCCESS
          );
          emit(ShopSuccessUpdateUserProfileDataState(updatemodel!));
        }
      else{
        showToast(text:updatemodel!.message! ,
            state: ToastState.ERROR
        );
        emit(ShopErrorUpdateProfileDataState());
      }
      print(updatemodel?.message);
      //emit(ShopSuccessUpdateUserProfileDataState(updatemodel!));
    }).catchError((onError)
    {
      print(onError.toString());
      emit(ShopErrorUpdateProfileDataState());
    }
    );
  }
}