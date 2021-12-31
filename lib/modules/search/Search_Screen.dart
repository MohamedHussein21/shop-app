import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/cubit/cubit.dart';
import 'package:shopapp/modules/search/cubit/states.dart';
import 'package:shopapp/shared/constant/constant.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, stata) {},
        builder: (context, stata) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      buildTextFormField(
                          icon: Icon(Icons.search),
                          lableTex: 'Search',
                          type: TextInputType.text,
                          ontap: () {},
                          controller: searchController,
                          validat: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter Any Word';
                            }
                          },
                          obscure: false,
                          onSubmit: (text) {
                            SearchCubit.get(context).getSearch(text);
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      if (stata is SearchLoadingStates)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      if (stata is SearchSuccessStates)
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildListProductItems(
                                    SearchCubit.get(context)
                                        .model!
                                        .data!
                                        .data[index],
                                    context,
                                    isOldPrice: false),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data
                                .length,
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
