import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/favorites_model.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_cubit.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_states.dart';

import '../../shared/components/component.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.getCubit(context);
        return ConditionalBuilder(
          condition: state is !ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => productsBuilder(cubit.favoritesModel!.data.data[index].product,context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: cubit.favoritesModel!.data.data.length,
          ),
          fallback: (context) => skeletonBuilder(),
        );
      },
    );
  }


  Widget skeletonBuilder() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: const [
          SkeletonContainer(width: 120, height: 120),
        ],
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              const SkeletonContainer(width: 150, height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  SkeletonContainer(width: 100, height: 30),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  SkeletonContainer(width: 50, height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
