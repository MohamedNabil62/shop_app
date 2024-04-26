import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/state.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
var namecontroller=TextEditingController();
var emailcontroller=TextEditingController();
var phonecontroller=TextEditingController();
var formkey=GlobalKey<FormState>();
class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context, state) => ConditionalBuilder(
            condition:ShopCubit.get(context).usermodel?.data !=null,
            builder:(context) {
              var cubit=ShopCubit.get(context).usermodel;
              namecontroller.text=cubit!.data!.name!;
              emailcontroller.text=cubit!.data!.email!;
              phonecontroller.text=cubit!.data!.phone!;
             return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if(state is ShopLoadingUpdateProfileDataState)
                          LinearProgressIndicator(
                            color: myColor,
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("password must not be empty");
                            }
                            return null;
                          },
                          decoration: InputDecoration(prefixIcon: const Icon(Icons.person),
                              labelText: "Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0))
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (v) {
                            print(v);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("email must not be empty");
                            }
                            return null;
                          },
                          decoration: InputDecoration(prefixIcon: const Icon(Icons.email),
                              labelText: "Email Address",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0))

                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("phone number must not be empty");
                            }
                            return null;
                          },
                          decoration: InputDecoration(prefixIcon: const Icon(Icons.phone),
                            labelText: "Phone Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),

                        ),
                        const SizedBox(height: 20),
                        defaultbutton(function:(){
                          if(formkey.currentState!.validate())
                            {
                              ShopCubit.get(context).getUpdateModel
                                (
                                  name: namecontroller.text,
                                  email: emailcontroller.text,
                                  phone: phonecontroller.text
                              );

                            }
                        },
                          text:"Updata",
                          colo: myColor,
                        ),
                        const SizedBox(height: 20),
                        defaultbutton(function:(){
                         singeout(context);
                        },
                            text:"Logout",
                          colo: myColor,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            fallback:(context) =>Center(child: CircularProgressIndicator()) ,
        ),
        listener:(context, state) {
          if (state is ShopSuccessUpdateUserProfileDataState) {
            // Update the usermodel with the updated data
            ShopCubit.get(context).usermodel = state.updatemodel;
            // Rest of your UI code...
          }
        },
    );
  }
}
