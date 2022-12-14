import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/shop_layout.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_states.dart';
import 'modules/boarding_screen/boarding_screen.dart';
import 'modules/login_screen/login_screen.dart';
import 'shared/cubits/shop_cubit/shop_cubit.dart';
import 'shared/network/local/cache_helper/cache_helper.dart';
import 'shared/network/remote/dio_helper/dio_helper.dart';
import 'shared/observer/blocObserver.dart';
import 'shared/styles/styles.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  if(CacheHelper.getData(key: 'onBoarding')!=null){
    print(CacheHelper.getData(key: 'token'));
    print('on boarding');
    if(CacheHelper.getData(key: 'token')== null){
      print('login');
      widget = LoginScreen();
    }else{
      print('home');
      widget = const ShopLayout();
    }
  }else{
    widget = const OnBoardingScreen();
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool? isDark = CacheHelper.getDark(key: 'isDark');
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()
          ..getHomeData()..getCategoryData()
          ..getFavorites()..getUserData()..changeTheme(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) { },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.getCubit(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark? ThemeMode.dark:ThemeMode.light,
            home: widget,
          );
        },
      ),
    );
  }


}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}