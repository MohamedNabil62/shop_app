import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/shopregister_sc/cubit/state.dart';


import '../../../../models/shopapp/register_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit():super(ShopRegisterInitialState());

static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopRegistrMode? RegistrModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }
      ){
    emit(ShopRegisterLoadingState());
    Diohelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        },
    ).then((value){
     print(value?.data);
     RegistrModel=ShopRegistrMode.fromJson(value?.data);
   print(RegistrModel?.status);
     print(RegistrModel?.data?.email);
      emit(ShopRegisterSuccessState(RegistrModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopRegisterchangePasswordVisibilityState());
  }
}