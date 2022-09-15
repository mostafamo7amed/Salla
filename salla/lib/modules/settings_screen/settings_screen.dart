import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/login_screen/login_screen.dart';
import 'package:salla/modules/update_screen/update_screen.dart';
import 'package:salla/shared/components/component.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_cubit.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_states.dart';
import 'package:salla/shared/network/local/cache_helper/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.getCubit(context);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  navigateTo(context, UpdateScreen());
                },
                child: Row(
                  children: const [
                    Icon(Icons.person,
                    size: 35,
                    color: Colors.blue,),
                    SizedBox(width: 10,),
                    Text('Update Profile',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              InkWell(
                onTap: () {
                  //dark mode
                  cubit.changeTheme();
                },
                child: Row(
                  children: const [
                    Icon(Icons.brightness_4_outlined,
                      size: 35,
                      color: Colors.blue,),
                    SizedBox(width: 10,),
                    Text('Dark Mode',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              InkWell(
                onTap: () {
                  signOut(context);
                },
                child: Row(
                  children: [
                    const Icon(Icons.exit_to_app,
                      size: 35,
                      color: Colors.blue,),
                    const SizedBox(width: 10,),
                    Text('Logout',
                      style:Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    );
  }
  void signOut (context){
    CacheHelper.removeData(key: 'token').then((value) {
      navigateAndFinish(context, LoginScreen());
    });
  }
}
