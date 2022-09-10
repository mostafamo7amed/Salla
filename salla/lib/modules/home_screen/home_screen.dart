import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/home_model.dart';
import '../../models/category_model.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubits/shop_cubit/shop_cubit.dart';
import '../../shared/cubits/shop_cubit/shop_states.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.getCubit(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) => homeBuilder(cubit.homeModel ,cubit.categoryModel),
          fallback: (context) => skeletonBuilder(),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel? model,CategoryModel? categoryModel) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model!.data!.banners!
              .map(
                (e) => Image.network(
              '${e.image}',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          )
              .toList(),
          options: CarouselOptions(
            height: 210.0,
            initialPage: 0,
            viewportFraction: 0.9,
            autoPlay: true,
            reverse: false,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayInterval: const Duration(seconds: 4),
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => categoryBuilder(categoryModel.data!.data![index],context),
                    separatorBuilder: (context, index) => const SizedBox(width: 10,),
                    itemCount: categoryModel!.data!.data!.length),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white,
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 1 / 1.85,
            children: List.generate(
              model.data!.products!.length,
                  (index) => productBuilder(model.data!.products![index]),
            ),
          ),
        ),
      ],
    ),
  );

  Widget productBuilder(ProductModel? model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image.network(
            '${model!.image}',
            width: double.infinity,
            height: 200,
          ),
          if (model.discount != 0)
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
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.name}',
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.3,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 18,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget categoryBuilder(CatDataOfDataModel model,context) => InkWell(
    onTap: () {
      ShopCubit.getCubit(context).changeBottomNav(1);
    },
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          '${model.image}',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            return child;
          },
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress == null){
              return child;
            }else{
              return Center(
                child: Image.asset(
                  'assets/images/image1.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              );
            }
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          width: 100,
          color: Colors.black.withOpacity(0.6),
          child:  Text(
            '${model.name}',
            maxLines: 1,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  Widget skeletonBuilder() => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SkeletonContainer(width: double.infinity, height: 200),
        const SizedBox(height: 8,),
        const SkeletonContainer(width: 130, height: 20),
        const SizedBox(height: 8,),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const SkeletonContainer(width: 100, height: 100),
              separatorBuilder: (context, index) => const SizedBox(width: 8,),
              itemCount: 5),
        ),
        const SizedBox(height: 8,),
        const SkeletonContainer(width: 150, height: 20),
        const SizedBox(height: 8,),
        Expanded(child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1 / 1.85,
          children:const [
            SkeletonContainer(width: double.infinity, height: double.infinity),
            SkeletonContainer(width: double.infinity, height: double.infinity),
            SkeletonContainer(width: double.infinity, height: double.infinity),
          ],
        ),
        ),
      ],
    ),
  );

}
