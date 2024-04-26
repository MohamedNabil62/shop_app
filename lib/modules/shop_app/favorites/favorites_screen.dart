import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/state.dart';
import '../../../models/shopapp/favorites_modelGET.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder:(context, state) => ConditionalBuilder(
        condition:state is! ShopLoadingGetFavoritesDataState,
        builder: (context) =>ListView.separated(
          itemBuilder:(context, index) => bluidFavoritesItem(ShopCubit.get(context).favoritesmodel!.data!.data![index],context),
          separatorBuilder: (context, index) =>meSlider()  ,
          itemCount:ShopCubit.get(context).favoritesmodel!.data!.data!.length,
        ) ,
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
      listener:(context, state){} ,
    );
  }
}

Widget bluidFavoritesItem(Data mode,context) =>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Container(
    height: 120,
    // width: 120,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage("${mode.product?.image}"),
              height: 150,
              width: 150,
            ),
            if(mode.product?.discount != 0)
              Container(
                color: Colors.red,
                child: Text("DISCOUNT",
                  style: TextStyle(
                      fontSize: 8,
                      color: Colors.white
                  ),

                ),
              )
          ],),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${mode.product?.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text("${mode.product?.price}",
                    style: TextStyle(
                        fontSize: 12,
                        color: myColor
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(mode.product?.discount != 0)
                    Text("${mode.product?.oldPrice}",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  Spacer(),

                  IconButton(onPressed: (){
                     ShopCubit.get(context).changeFavorites(mode.product?.id);

                  },
                      icon:  CircleAvatar(
                        radius: 15,
                        backgroundColor:ShopCubit.get(context)?.favorites?.containsKey(mode.product?.id) == true && ShopCubit.get(context)?.favorites?[mode.product?.id] == true ? Colors.blue : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size:14 ,
                          color: Colors.white,
                        ),
                      )
                  )
                ],
              )
            ],),
        )
      ],
    ),
  ),
);