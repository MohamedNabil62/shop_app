

import '../../../../models/shopapp/register_model.dart';

abstract class ShopRegisterStates{}

class  ShopRegisterInitialState extends ShopRegisterStates{}

class  ShopRegisterLoadingState extends ShopRegisterStates{}

class  ShopRegisterSuccessState extends ShopRegisterStates{
   final ShopRegistrMode RegisterModel;

  ShopRegisterSuccessState(this.RegisterModel);
}

class  ShopRegisterErrorState extends ShopRegisterStates{

  final String error;
  ShopRegisterErrorState(this.error);
}

class  ShopRegisterchangePasswordVisibilityState extends ShopRegisterStates{}