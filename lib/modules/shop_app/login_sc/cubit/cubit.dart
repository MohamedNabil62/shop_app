import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login_sc/cubit/state.dart';

import '../../../../models/shopapp/login_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit():super(ShopLoginInitialState());

static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? LoginModel;
  void userLogin({
    required String email,
    required String password,
  }
      ){
    emit(ShopLoginLoadingState());
    Diohelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password
        },
    ).then((value){
     print(value?.data);
     LoginModel=ShopLoginModel.formJson(value?.data);
   print(LoginModel?.status);
     print(LoginModel?.data.email);
      emit(ShopLoginSuccessState(LoginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopchangePasswordVisibilityState());
  }
}