import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/search_screen/search_screen.dart';
import '../shared/components/component.dart';
import '../shared/cubits/shop_cubit/shop_cubit.dart';
import '../shared/cubits/shop_cubit/shop_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.getCubit(context);
        return  Scaffold(
          appBar: AppBar(
            title: const Text('Salla',
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Janna',
              ),
            ),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, const SearchScreen());
              }, icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps_rounded),
                  label: 'Category'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorite'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
