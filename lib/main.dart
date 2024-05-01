import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:productive_families/core/values/values.dart';
import 'package:productive_families/firebase_options.dart';
import 'package:productive_families/notification/awesome_controller.dart';
import 'package:productive_families/notification/local_notifications.dart';
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
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'pushnotificationapp',
        channelName: 'pushnotificationappchannel',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.High,
        // enableVibration: true/,
        // soundSource: 'resource://raw/a',
        // playSound: true,
      ),
    ],
  );

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.onMessageOpenedApp.single
      .asStream()
      .single
      .then((value) => _firebaseMessagingHandler(value));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (message.notification != null) {
      Map<Object?, Object?> data = {
        'title': message.notification!.title,
        'body': message.notification!.body,
        'data': message.data
      };
      await LocalNotificationService.showMessage(data);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingHandler);
  configLoading();
  runApp(const MyApp());
}

void onMessageReceivedInTheForeground(Map<Object?, Object?> data) {
  LocalNotificationService.showMessage(data);
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingHandler(RemoteMessage message) async {
  if (message.notification != null) {
    Map<Object?, Object?> data = {
      'title': message.notification!.title,
      'body': message.notification!.body,
      'data': message.data
    };
    await LocalNotificationService.showMessage(data);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseMessaging.instance.subscribeToTopic('a');
    AwesomeNotifications().requestPermissionToSendNotifications(permissions: [
      NotificationPermission.Alert,
      NotificationPermission.FullScreenIntent
    ]);
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    FirebaseMessaging.instance
        .requestPermission(alert: true, announcement: true);
    super.initState();
  }

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
    ..backgroundColor = AppColors.appColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
