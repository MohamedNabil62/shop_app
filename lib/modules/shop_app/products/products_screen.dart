
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/state.dart';
import '../../../models/shopapp/categories_model.dart';
import '../../../models/shopapp/home_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder:(context, state) =>ConditionalBuilder(
            condition:ShopCubit.get(context).hommodel != null && ShopCubit.get(context).categoriesmodel != null ,
            builder:(context) => productsBuilder(ShopCubit.get(context).hommodel as HomeModel,ShopCubit.get(context).categoriesmodel as CategoriesModel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        ),
        listener: (context, state) {
          if(state is ShopSuccessFavoritesDataState)
            {
            if(!state.model.status)
              {
                showToast(
                    text:state.model.message,
                    state:ToastState.ERROR
                );
              }
            }
        },
    );
  }
}

Widget productsBuilder(HomeModel model, CategoriesModel categoriesmodel,context ){
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model.data.banner.map((e) => Image(
              image: NetworkImage("${e.image}"),
              width: double.infinity,
              fit: BoxFit.cover,
            )
            ).toList() ,
            options: CarouselOptions(
                viewportFraction: 1,
                height: 200,
                initialPage: 0,
                enableInfiniteScroll: true,//
                reverse: false,//
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal //
            )
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                ),
              ),
              Container(
                height: 168,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => bluidcategoriesitem(
                    categoriesmodel.data!.data[index],
                  ),
                  separatorBuilder:(context, index) => SizedBox(width: 10) ,
                  itemCount:categoriesmodel.data!.data.length,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                "New Product",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                ),
              ),

            ],),
        ),
        SizedBox(height: 10,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.6,
            children: List.generate(
                model.data.product.length,
                    (index) =>productGridviewbuider( model.data.product[index] ,  context)
            ),
          ),
        )
      ],
    ),
  );
}
 Widget bluidcategoriesitem(DataModel mode) =>Stack(
   alignment: AlignmentDirectional.bottomStart,
   children: [
     Image(
       image: NetworkImage("${mode.image}"),
height: 150,
       width: 150,
       fit: BoxFit.cover,
     ),
     Container(
       color: Colors.black.withOpacity(.8),
       width: 150,
       child: Text(
         "${mode.name}",
         textAlign: TextAlign.center,
         maxLines: 1,
         overflow: TextOverflow.ellipsis,
         style: TextStyle(
           color: Colors.white,
         ),
       ),
     )
   ],
 );

Widget productGridviewbuider( ProductsModel mod,context) => Container(
  color: Colors.white,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage("${mod.image}"),
            height: 200,
            width: double.infinity,
          ),
          if(mod.discount != 0)
            Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal:5.0),
                child: Text("DISCOUNT",
                  style: TextStyle(
                      fontSize: 8,
                      color: Colors.white
                  ),

                ),
              ),
            )
        ],),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${mod.name}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14
              ),
            ),
            Row(
              children: [
                Text("${mod.price.round()}",
                  style: TextStyle(
                      fontSize: 12,
                      color: myColor
                  ),
                ),
                SizedBox(width: 5,),
                if(mod.discount != 0)
                  Text("${mod.old_price.round()}",
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                Spacer(),
                IconButton(onPressed: (){
                  ShopCubit.get(context).changeFavorites(mod.id);
                },
                    icon:  CircleAvatar(
                      radius: 15,
                      backgroundColor:ShopCubit.get(context)?.favorites?.containsKey(mod.id) == true && ShopCubit.get(context)?.favorites?[mod.id] == true ? Colors.blue : Colors.grey,
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
);