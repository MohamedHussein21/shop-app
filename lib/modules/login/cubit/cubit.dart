import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/login/cubit/states.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginModel loginModel;


  void userLogin ({
  required String email,
  required String password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: Login,
        data: {
          'email':email,
          'password':password,
        },

        ).then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromjson(value.data);
          print(loginModel.message);
          emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  bool isShowPass =true ;

  IconData suffix =Icons.visibility_outlined ;

  void changePassVisibility (){
    isShowPass =!isShowPass;
    suffix = isShowPass? Icons.visibility_off_outlined:Icons.visibility_outlined ;
    emit(ShopChangePassIconState());
  }

}
