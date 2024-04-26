import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/state.dart';

import '../../../../models/shopapp/search_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(ShopSearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  ShopSearchMode? searchModel;
  void search(
  {
  @required String? text,
  })
  {
    emit(ShopSearchLoadingState());
    Diohelper.postData(
      token: token,
        url:SEARCH ,
        data:
        {
          "text":text
        }
    ).then((value) {
      searchModel=ShopSearchMode.fromJson(value?.data);
      print(searchModel?.status);
      emit(ShopSearchSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ShopSearchErrorState());
    });
  }

}