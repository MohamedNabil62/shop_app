// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observre.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/theme-data.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/cubit/state.dart';
import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/login_sc/login_screen.dart';
import 'modules/shop_app/on-borading/on-boarding.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  Diohelper.init();
 await CacheHelper.init();
 bool? isDark=CacheHelper.getData(kay: 'mode');
  bool? OnBorading=CacheHelper.getData(kay: 'onborading');
  token=CacheHelper.getData(kay: 'token');
  uId=CacheHelper.getData(kay: "uId");
  print(token);
  Widget? widget;

  if(OnBorading != null) //shop_app
    {
      if(token != null){
        widget=ShopLayout();
      }
      else{
        widget=ShopLoginScreen();
      }
    }
  else{
    widget=onBorading();
  }


  runApp(MyApp(isDark,widget));
}
class MyApp extends StatelessWidget
{
  final bool? isDark;
  final Widget Start_Widget;
  const MyApp(this.isDark, this.Start_Widget,{super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserModel(),
    ),
        ],
        child:BlocConsumer<ShopCubit,ShopStates>(
        listener:(context, state) => {
        },
    builder:(context, state) {
          return  MaterialApp(debugShowCheckedModeBanner: false,
          
              theme: lightmode,
              darkTheme: darkmode,
              themeMode:ThemeMode.light,
           // themeMode:ThemeMode.dark,
             home: Directionality(textDirection: TextDirection.ltr,
                  child:Start_Widget,
               /*
                  LayoutBuilder(//responsive and adaptive
                    builder: (BuildContext context, BoxConstraints constraints) {
                    
                      if(constraints.maxWidth.toInt()<560)
                        return MobileScreen();
                      return DesktopScreen();
                    },
                  ),

                   */
             )
          );
    })



    );

  }
}