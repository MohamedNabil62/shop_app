import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../models/shopapp/search_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
var searchcontroller=TextEditingController();
var formkey=GlobalKey<FormState>();
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  TextFormField(
                    controller: searchcontroller,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("name must not be empty");
                      }
                      return null;
                    },
                    decoration: InputDecoration(prefixIcon: const Icon(Icons.search),
                        labelText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)
                        )
                    ),
                    onFieldSubmitted: (String text){
                      SearchCubit.get(context).search(text: text);
                    },
                  ),
                  SizedBox(height:20),
                  if(state is ShopSearchLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  if(state is ShopSearchSuccessState)
                   Expanded(
                     child: ListView.separated(
                        itemBuilder:(context, index) => bluidSearchItem(SearchCubit.get(context).searchModel!.data!.data![index],context),
                        separatorBuilder: (context, index) =>meSlider()  ,
                        itemCount: SearchCubit.get(context).searchModel?.data?.data?.length ?? 0,
                      ),
                   )
                ],),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget bluidSearchItem(DataSearch mode,context) =>Padding(
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
              image: NetworkImage("${mode.image}"),
              height: 150,
              width: 150,
            ),
          ],),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${mode.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text("${mode.price}",
                    style: TextStyle(
                        fontSize: 12,
                        color: myColor
                    ),
                  ),
                  Spacer(),

                  IconButton(onPressed: (){
                    ShopCubit.get(context).changeFavorites(mode.id);

                  },
                      icon:  CircleAvatar(
                        radius: 15,
                        backgroundColor:ShopCubit.get(context).favorites.containsKey(mode.id) == true && ShopCubit.get(context).favorites[mode.id] == true ? Colors.blue : Colors.grey,
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