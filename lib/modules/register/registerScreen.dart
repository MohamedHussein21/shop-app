import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/home_Layout.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/register/cubit/cubit.dart';
import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/shared/constant/constant.dart';


class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,stata){
          if (stata is ShopRegisterSuccessState) {
            if (stata.loginModel.status!) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              CachHelper.saveData(
                  key: 'token', value: stata.loginModel.data!.token)
                  .then((value) {

                token =stata.loginModel.data!.token;

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                        (route) => false);
              });
            } else {
              // print(state.loginModel.message);
              showToast(
                text: '${stata.loginModel.message}',
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context,stata){
          return Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 13,
                              ),
                              Text('Register',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        buildTextFormField(
                          obscure: false,
                          icon: Icon(Icons.person),
                          lableTex: 'Name',
                          type: TextInputType.text,
                          ontap: () {},
                          controller: nameController,
                          validat: (value) {
                            if (value.isEmpty) {
                              return 'Name Is Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        buildTextFormField(
                          obscure: false,
                          icon: Icon(Icons.email_outlined),
                          lableTex: 'Email',
                          type: TextInputType.emailAddress,
                          ontap: () {},
                          controller: emailController,
                          validat: (value) {
                            if (value.isEmpty) {
                              return 'Email Is Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ), buildTextFormField(
                          obscure: false,
                          icon: Icon(Icons.phone),
                          lableTex: 'Phone',
                          type: TextInputType.phone,
                          ontap: () {},
                          controller: phoneController,
                          validat: (value) {
                            if (value.isEmpty) {
                              return 'Phone Is Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        buildTextFormField(
                          obscure: ShopRegisterCubit.get(context).isShowPass,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                            }
                          },
                          suffix: IconButton(
                            onPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePassVisibility();
                            },
                            icon: Icon(ShopRegisterCubit.get(context).suffix),
                          ),
                          icon: Icon(Icons.lock),
                          lableTex: 'Password',
                          type: TextInputType.visiblePassword,
                          ontap: () {},
                          controller: passwordController,
                          validat: (value) {
                            if (value.isEmpty) {
                              return 'Password Is Too Small';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        BuildCondition(
                          condition:  stata is !ShopRegisterLoadingState,
                          builder: (context)=> buildButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                            title: 'Create',
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Don't have an account ?"),
                        //     TextButton(
                        //       onPressed: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     RegisterScreen()));
                        //       },
                        //       child: Text('Sign Up'),
                        //     ),
                        //   ],
                        // ),
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
