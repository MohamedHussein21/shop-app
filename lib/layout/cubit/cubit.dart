
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/login_model.dart';
import 'package:shopapp/modules/categours_Screen.dart';
import 'package:shopapp/modules/favorites_Screen.dart';
import 'package:shopapp/modules/products_Screen.dart';
import 'package:shopapp/modules/profile_Screen.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/shared/constant/constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangButtonNavStates());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(url: HOME, token: token).then((value) {
      print(DioHelper.dio!.options.headers);
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      // print(DioHelper.dio!.options.headers);
      // print(favorites.toString());
      emit(ShopHomeDataSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeDataErrorStates(error));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      // print(value.data);
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesDataSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesDataErrorStates(error));
    });
  }
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productId) {

    favorites[productId] =! favorites[productId]!;
    emit(ShopChangeSuccessStates());

    DioHelper.postData(
            url: FAVORITES,
            data: {
              'product_id': productId,
            },
             token: token,
         )
        .then((value) {
          changeFavoritesModel =ChangeFavoritesModel.fromJson(value.data);
          print(value.data);

          if(changeFavoritesModel!.status == false ){

            favorites[productId] =! favorites[productId]!;

          }else{
            getFavorites();
          }
          print(favorites.toString());

      emit(ShopChangeFavoritesSuccessStates(changeFavoritesModel!));
    }).catchError((error) {

       favorites[productId] =! favorites[productId]!;
      print(error);
      emit(ShopChangeFavoritesErrorStates(error));
    });
  }

FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopGetFavoritesLoadingStates());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      // print(value.data);
      favoritesModel = FavoritesModel.fromJson(value.data);
       print(value.data.toString());

      emit(ShopGetFavoritesSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesErrorStates(error));
    });
  }

  ShopLoginModel? profileModel;
  void getProfileData() {
    emit(ShopGetProfileLoadingStates());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      // print(value.data);
      profileModel = ShopLoginModel.fromjson(value.data);
      // print(profileModel!.data!.name);

      emit(ShopGetProfileSuccessStates(profileModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetProfileErrorStates(error));
    });
  }

}

