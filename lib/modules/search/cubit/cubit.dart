import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/network/end_point.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/shared/constant/constant.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void getSearch(String? text) {
    emit(SearchLoadingStates());
    DioHelper.postData(
        url: SEARCH,
        token: token
        ,data: {
      'text': text,

    }).then((value) {
      model = SearchModel.fromJson(value.data);
      print(value);
      emit(SearchSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}
