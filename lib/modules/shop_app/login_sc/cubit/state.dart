

import '../../../../models/shopapp/login_model.dart';

abstract class ShopLoginStates{}

class  ShopLoginInitialState extends ShopLoginStates{}

class  ShopLoginLoadingState extends ShopLoginStates{}

class  ShopLoginSuccessState extends ShopLoginStates{
   final ShopLoginModel LoginModel;

  ShopLoginSuccessState(this.LoginModel);
}

class  ShopLoginErrorState extends ShopLoginStates{

  final String error;
  ShopLoginErrorState(this.error);
}

class  ShopchangePasswordVisibilityState extends ShopLoginStates{}