import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/category_model.dart';
import '../../shared/cubits/shop_cubit/shop_cubit.dart';
import '../../shared/cubits/shop_cubit/shop_states.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.getCubit(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => categoryBuilder(cubit.categoryModel!.data!.data![index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: cubit.categoryModel!.data!.data!.length,
        );
      },
    );
  }


  Widget categoryBuilder(CatDataOfDataModel model) => InkWell(
    onTap: () {
      //item click
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      child: Row(
        children: [
          Image.network(
            '${model.image}',
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
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              }
            },
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 5,),
          Text('${model.name}',
            maxLines: 1,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'Janna',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        ],
      ),
    ),
  );
}
