import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../login_sc/cubit/cubit.dart';
import '../login_sc/cubit/state.dart';
import 'cubit/state.dart';
import 'cubit/cubit.dart';

var namecontroller=TextEditingController();
var emailcontroller=TextEditingController();
var passwordcontroller=TextEditingController();
var phonecontroller=TextEditingController();
var formkey=GlobalKey<FormState>();
class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState)
          {
            if(state.RegisterModel.status!)
            {
              CacheHelper.saveData(
                  kay: "token",
                  value:state.RegisterModel.data?.token ).then((value) {
                token=state.RegisterModel.data?.token;
                navigtorAndFinish(context, ShopLayout());
              } );

            }
            else{
              print(state.RegisterModel.message);
              showToast(
                text:state.RegisterModel.message as String ,
                state:ToastState.ERROR,
              );
            }
          }
        },
        builder:(context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("REGISTER",
                          style:Theme.of(context).textTheme.headline5,
                        ),
                        Text("Register now to browse our hot offers",
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("name must not be empty");
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
                              labelText: "Email aderrs",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0))

                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (v){
                          },
                          obscureText: ShopRegisterCubit.get(context).isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("password must not be empty");
                            }
                            return null;
                          },
                          decoration: InputDecoration(prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(onPressed: () {

                                ShopRegisterCubit.get(context).changePasswordVisibility();
                              },

                                  icon:Icon(ShopRegisterCubit.get(context).suffix)
                              ),
                              labelText: "password",
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
                        ConditionalBuilder(
                          condition:state is! ShopRegisterLoadingState,
                          builder: (context) => defaultbutton(function: (){
                            if(formkey.currentState!.validate()){
                              ShopRegisterCubit.get(context).userRegister(
                                name: namecontroller.text,
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                                phone:phonecontroller.text,
                              );
                            }
                          },
                              text: "register".toUpperCase(),
                              colo:myColor
                          ),
                          fallback:(context) => Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
