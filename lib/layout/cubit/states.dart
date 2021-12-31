import 'package:shopapp/models/change_favorites_model.dart';
import 'package:shopapp/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates{}

class ShopChangButtonNavStates extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopHomeDataSuccessStates extends ShopStates{}

class ShopHomeDataErrorStates extends ShopStates{

  final error;
  ShopHomeDataErrorStates(this.error);
}

class ShopCategoriesDataSuccessStates extends ShopStates{}

class ShopCategoriesDataErrorStates extends ShopStates{

  final error;
  ShopCategoriesDataErrorStates(this.error);
}

class ShopChangeSuccessStates extends ShopStates{}

class ShopChangeFavoritesSuccessStates extends ShopStates{

  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessStates(this.model);
}

class ShopChangeFavoritesErrorStates extends ShopStates{

  final error;
  ShopChangeFavoritesErrorStates(this.error);
}

class ShopGetFavoritesLoadingStates extends ShopStates{}

class ShopGetFavoritesSuccessStates extends ShopStates{}

class ShopGetFavoritesErrorStates extends ShopStates{

  final error;
  ShopGetFavoritesErrorStates(this.error);
}

class ShopGetProfileLoadingStates extends ShopStates{}

class ShopGetProfileSuccessStates extends ShopStates{
  final ShopLoginModel profileModel;

  ShopGetProfileSuccessStates(this.profileModel);
}

class ShopGetProfileErrorStates extends ShopStates{

  final error;
  ShopGetProfileErrorStates(this.error);
}


