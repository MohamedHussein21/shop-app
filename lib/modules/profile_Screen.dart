import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/shared/constant/constant.dart';

class ProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, stata) {},
      builder: (context, stata) {
        var model = ShopCubit
            .get(context)
            .profileModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;


        return BuildCondition(
          condition: ShopCubit
              .get(context)
              .profileModel != null,
          builder: (context) =>
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 45,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Image.network(
                            'https://www.americanaircraftsales.com/wp-content/uploads/2016/09/no-profile-img.jpg',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                             Positioned(
                               bottom: 0,
                               right: 0,
                               top: 65,
                               left: 70,
                               child: IconButton(onPressed: (){
                                 Alert(
                                   context: context,
                                   type: AlertType.none,
                                   title: " Choose",
                                   desc: "Choose Between Camera Or Gallery",
                                   buttons: [
                                     DialogButton(
                                       child: Text(
                                         "Camera",
                                         style: TextStyle(color: Colors.white, fontSize: 20),
                                       ),
                                       onPressed: () => Navigator.pop(context),
                                       width: 120,
                                     ),
                                     DialogButton(
                                       child: Text(
                                         "Gallery",
                                         style: TextStyle(color: Colors.white, fontSize: 20),
                                       ),
                                       onPressed: () => Navigator.pop(context),
                                       width: 120,
                                     ),
                                   ],
                                 ).show();
                               }, icon: Icon(Icons.camera_alt),color: Colors.deepOrange,
                                   iconSize: 25,padding: EdgeInsets.zero,),
                             ),
                            ],

                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      buildTextFormField(
                        icon: Icon(Icons.person),
                        lableTex: 'Name',
                        type: TextInputType.text,
                        ontap: () {},
                        controller: nameController,
                        validat: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                        obscure: false,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      buildTextFormField(
                        icon: Icon(Icons.email),
                        lableTex: 'Email',
                        type: TextInputType.emailAddress,
                        ontap: () {},
                        controller: emailController,
                        validat: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Email';
                          }
                          return null;
                        },
                        obscure: false,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      buildTextFormField(
                        icon: Icon(Icons.phone),
                        lableTex: 'Phone',
                        type: TextInputType.phone,
                        ontap: () {},
                        controller: phoneController,
                        validat: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Phone';
                          }
                          return null;
                        },
                        obscure: false,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      buildButton(
                          onPressed: () {
                            CachHelper.removeData(key: 'token').then((value) {
                              if (value) {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()), (
                                        route) => false);
                              }
                            });
                          },
                          title: 'LogOut')
                    ],
                  ),
                ),
              ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
