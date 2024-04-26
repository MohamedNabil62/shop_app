import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/shop_app/search/search_screen.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
        appBar: AppBar(
          title: const Text("Salla"),
          actions: [
            IconButton(onPressed: (){
              nevgitto(context,
              SearchScreen(),
              );
            },
                icon:Icon(Icons.search)
            )
          ],
        ),
        body:cubit.bottomScreens[cubit.curent_index] ,
          bottomNavigationBar:BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            currentIndex: cubit.curent_index,
            onTap: (index){
              cubit.changeBottom(index);
            },
            items: [
              BottomNavigationBarItem(
                     icon: Icon(Icons.home),
                     label: "Home"
                   ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: "Catoegries"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: "Favorites"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings"
              )
            ],
          //  backgroundColor: Colors.cyan,
          ),
      );
      }
    );
  }
}
