import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/state.dart';
import '../../../models/shopapp/categories_model.dart';
import '../../../shared/components/components.dart';

class CatoegriesScreen extends StatelessWidget {
  const CatoegriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder:(context, state) => ListView.separated(
            itemBuilder:(context, index) => bulidcatgories(ShopCubit.get(context).categoriesmodel.data!.data[index]),
            separatorBuilder: (context, index) =>meSlider()  ,
            itemCount:ShopCubit.get(context).categoriesmodel.data!.data.length ,
        ),
        listener:(context, state){} ,
      );
  }
}
 Widget bulidcatgories(DataModel model) => Padding(
   padding: const EdgeInsets.all(8.0),
   child: Row(
     children: [
       Image(
         image: NetworkImage("${model.image}"),
         height: 80,
         width: 80,
         fit: BoxFit.cover,
       ),
       SizedBox(width: 20,),
       Text(
         "${model.name}",
         style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold
         ),
       ),
       Spacer(),
       Icon(Icons.arrow_forward_ios),
     ],
   ),
 );