import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/home_Layout.dart';
import 'package:shopapp/modules/login/cubit/cubit.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/register/registerScreen.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/shared/constant/constant.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              CachHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {

                    token =state.loginModel.data!.token;

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                    (route) => false);
              });
            } else {
              // print(state.loginModel.message);
              showToast(
                text: '${state.loginModel.message}',
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
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
                              Image.asset(
                                'assets/image/logo.png',
                                scale: 13,
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              Text('LOGIN',
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
                        ),
                        buildTextFormField(
                          obscure: ShopLoginCubit.get(context).isShowPass,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          suffix: IconButton(
                            onPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePassVisibility();
                            },
                            icon: Icon(ShopLoginCubit.get(context).suffix),
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
                        state is ShopLoginLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : buildButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                title: 'LOGIN',
                              ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account ?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text('Register'),
                            ),
                          ],
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
