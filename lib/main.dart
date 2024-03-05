import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_loadingindicator/flutter_loadingindicator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:productive_families/app_store/app_store.dart';
import 'package:productive_families/business_logic/blocs/product/product_bloc.dart';
import 'package:productive_families/configure_di.dart';
import 'package:productive_families/core/local/app_localization.dart';
import 'package:productive_families/core/local/language_data_model.dart';
import 'package:productive_families/core/local/languages.dart';
import 'package:productive_families/core/local/languages/language_en.dart';
import 'package:productive_families/core/logic/global_bloc.dart';
import 'package:productive_families/firebase_options.dart';
import 'package:productive_families/presentation/screens/splash/splash_screen.dart';

import 'business_logic/blocs/auth/auth_bloc.dart';
import 'business_logic/blocs/cart/cart_bloc.dart';
import 'business_logic/blocs/wishlist/wishlist_bloc.dart';

BaseLanguage language = LanguageEn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await configureInjection();
  await getIt<AppStore>().initial();
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc()..add(CheckAuth()),
      ),
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(),
      ),
      BlocProvider<CartBloc>(
        create: (context) => CartBloc()..add(LoadCart()),
      ),
      BlocProvider<WishlistBloc>(
        create: (context) => WishlistBloc()..add(LoadWishlist()),
      ),
      BlocProvider<GlobalBloc>(
        create: (context) => GlobalBloc(),
      )
    ], child: const ProductStoreApp());
  }
}

class ProductStoreApp extends StatelessWidget {
  const ProductStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          builder: EasyLoading.init(),
          localizationsDelegates: const [
            AppLocalizations(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LanguageDataModel.languageLocales(),
          localeResolutionCallback: (locale, supportedLocales) => locale,
          locale: Locale(state.languageCode),
        );
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = const Color(0xFF4AC382)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
