import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/modules/register/cubit/states.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;


  void userRegister ({
  required String name,
  required String email,
  required String phone,
  required String password,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
          'password':password,
        },

        ).then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromjson(value.data);
          print(loginModel.message);
          emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
  bool isShowPass =true ;

  IconData suffix =Icons.visibility_outlined ;

  void changePassVisibility (){
    isShowPass =!isShowPass;
    suffix = isShowPass? Icons.visibility_off_outlined:Icons.visibility_outlined ;
    emit(ShopRegisterChangePassIconState());
  }

}
