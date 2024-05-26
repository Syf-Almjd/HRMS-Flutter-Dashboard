import 'dart:ui';

import 'package:admin/config/utils/managers/app_constants.dart';
import 'package:admin/domain/entities/Authentication/AuthPage.dart';
import 'package:admin/presentation/Cubits/Tabs_cubit/tabs_cubit.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Cubits/tabsNavi_Bloc/tabsNavigation_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_seo/flutter_web_seo.dart';
import 'package:provider/provider.dart';

import 'config/bloc_observer.dart';
import 'config/themes/theme_manager.dart';
import 'data/local/localData_cubit/local_data_cubit.dart';
import 'data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'data/remote/firebase_options.dart';
import 'domain/controllers/MenuAppController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        BlocProvider<LocalDataCubit>(
          create: (context) => LocalDataCubit(),
        ),
        BlocProvider<RemoteDataCubit>(
          create: (context) => RemoteDataCubit(),
        ),
        BlocProvider<UserRegisterBloc>(
          create: (context) => UserRegisterBloc(),
        ),
        BlocProvider<RegisterNavigationBloc>(
          create: (context) => RegisterNavigationBloc(),
        ),
        BlocProvider<TabsCubit>(
          create: (context) => TabsCubit(),
        ),
        BlocProvider<NaviCubit>(
          create: (context) => NaviCubit(),
        ),
      ],
      child: MaterialApp(
              scrollBehavior: MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown
                },
              ),
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              title: AppConstants.appTitle,
              theme: getDarkApplicationTheme(),
              // darkTheme: getDarkApplicationTheme(),
              home: AuthPage())
          .seo(),
    );
  }
}
