import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/cubit/states.dart';
import 'package:shopapp/shared/constant/constant.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,stata){},
      builder: (context,stata){
        return BuildCondition(
          condition:stata is !ShopGetFavoritesLoadingStates ,
          builder:(context)=> ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProductItems(ShopCubit.get(context).favoritesModel!.data.data[index].product,context,),
            separatorBuilder: (context, index) => Divider(),
            itemCount:ShopCubit.get(context).favoritesModel!.data.data.length,
          ) ,
          fallback:(context) => Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }


}
