import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/components/component.dart';
import 'package:salla/shared/cubits/search_cubit/cubit.dart';
import 'package:salla/shared/cubits/search_cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.getCubit(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    defaultFormField(
                        context: context,
                        controller: searchController,
                        label: 'Search',
                        prefix: const Icon(Icons.search),
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'enter product name to search of';
                          }
                        },
                        type: TextInputType.text,
                        onSubmit: (String text) {
                          cubit.search(text);
                        }),
                    const SizedBox(
                      height: 5,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => productsBuilder(
                              cubit.searchModel!.data.data[index], context,isSearch: false),
                          separatorBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                            child: Container(
                              width: double.infinity,
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),
                          itemCount: cubit.searchModel!.data.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
