import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/layout/cubit/cubit.dart';
import 'package:shopapp/layout/home_Layout.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/network/local/cach_helper.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

import 'modules/onBoarding_screen.dart';
import 'shared/bloc_observer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();

  Widget widget;

  bool? onBoarding = CachHelper.getData(key: 'OnBoarding');

  String? token = CachHelper.getData(key: 'token');

   print(token);

  if(onBoarding !=null) {
    if (token !=null) widget =ShopLayout();
    else widget = LoginScreen();
  }else {
    widget = OnBoarding();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

 final Widget startWidget;

  const MyApp({ required this.startWidget}) ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getProfileData()),
      ],
      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark
                  ),
                  backwardsCompatibility: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(

                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.black
                  )

              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,


              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )
              ),

            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:HexColor('333739'),
                      statusBarIconBrightness: Brightness.light
                  ),
                  backwardsCompatibility: false,
                  backgroundColor:HexColor('333739'),
                  elevation: 0,
                  titleTextStyle: TextStyle(

                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.white
                  )

              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
                backgroundColor: HexColor('333739'),


              ),
              scaffoldBackgroundColor: HexColor('333739'),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )
              ),
            ),
            themeMode: ThemeMode.light,
            home:startWidget,
          )

    );
  }
}

