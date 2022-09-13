import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/favorites_model.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_cubit.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_states.dart';

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
            itemBuilder: (context, index) => favoritesBuilder(cubit.favoritesModel!.data.data[index],context),
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

  Widget favoritesBuilder(Datum model,context) => Row(
    children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.network(
                model.product.image,
                width: 120,
                height: 120,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress == null){
                    return child;
                  }else{
                    return Center(
                      child: Image.asset(
                        'assets/images/image0.jpg',
                        width: 120,
                        height: 120,
                      ),
                    );
                  }
                },
              ),
              if (model.product.discount != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Image.asset(
                    'assets/images/disc.gif',
                    width: 35,
                    height: 35,
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${model.product.price.round()}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (model.product.discount != 0)
                        Text(
                          '${model.product.oldPrice.round()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        alignment: Alignment.bottomCenter,
                        onPressed: () {
                          ShopCubit.getCubit(context).changeFavorites(model.product.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.getCubit(context).favorites[model.product.id]??false ? Colors.blue:Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    ],
  );

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
