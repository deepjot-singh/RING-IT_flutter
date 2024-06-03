import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodorder/app/core/locationFinder/locationFinder.dart';
import 'package:foodorder/app/core/constant/globalVariable.dart';
import 'package:foodorder/app/core/routes/routes.dart';
import 'package:foodorder/app/core/sharedPreference/LocalStore.dart';
import 'package:foodorder/app/modules/homeScreenPage/view/homeScreenView.dart';
import 'package:foodorder/app/modules/loginPage/view/loginView.dart';
import 'package:foodorder/app/modules/onboardingPage/view/onboardingView.dart';
import 'package:foodorder/app/modules/splashPage/view/splashView.dart';
import 'package:foodorder/app/services/firbaseSerivce/firebaseService.dart';
import 'package:foodorder/app/services/firbaseSerivce/firebase_options.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(myApp()));
}

class myApp extends StatefulWidget {
  myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  var tokenKey;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    Routes.keyboadClose();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      print("TokeIntial");
      await FirebaseService().initNotification();
      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler)
      tokenKey = await LocalStore().getToken();
      checkOnborading();
      print("token -- ${tokenKey.toString()}");
      // var  provider = GlobalVariable.addressProviderManager ;
    });
  }

  String isOnboarding = '0';
  checkOnborading() async {
    //check if user has seen the onboarding screens or click on skip while app is open at first time
    isOnboarding = await LocalStore().getIsGetStarted();
    setState(() {});
    print('isOnboarding $isOnboarding');
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          var provider = GlobalVariable.addressProviderManager;
          return provider;
        }),
        ChangeNotifierProvider(create: (_) {
          var productProviderManager = GlobalVariable.productProviderManager;
          return productProviderManager;
        }),
        ChangeNotifierProvider(create: (_) {
          var profileProvider = GlobalVariable.ProfileProviderManager;
          return profileProvider;
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: GlobalVariable.navigatorKey,
        theme: ThemeData(
            fontFamily: 'Poppins',
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.black,
            )),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SplashView(
            //   navigateRoute: isOnboarding == "1" ? OnboardingView() : OnboardingView(),
            navigateRoute: isOnboarding == "1"
                ? tokenKey == 'null' || tokenKey.toString().isEmpty
                    ? LoginView()
                    : HomeScreenView()
                : OnboardingView(),
          ),
          //SplashView(),
        ),
      ),
    );
  }
}
