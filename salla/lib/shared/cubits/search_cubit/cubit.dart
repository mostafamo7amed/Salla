import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/search_model.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/cubits/search_cubit/states.dart';
import 'package:salla/shared/network/end_points.dart';
import 'package:salla/shared/network/remote/dio_helper/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() :super(SearchInitState());

  static SearchCubit getCubit(context) => BlocProvider.of(context);



  SearchModel? searchModel;

  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH, data: {
      'text':text
    },
    token: token
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}