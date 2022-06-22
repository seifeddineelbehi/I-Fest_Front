import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/default_size_handler.dart';
import 'package:flutter_template/utils/dependency_injection.dart' as di;
import 'package:flutter_template/utils/translations/codegen_loader.g.dart';
import 'package:flutter_template/viewModel/home_test_view_model.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/viewModel/users_view_model.dart';
import 'package:flutter_template/views/views.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: DefaultSizeInit(builder: () => const MyApp()),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
      ],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeTestViewModel>(
          create: (_) => HomeTestViewModel(),
        ),
        ChangeNotifierProvider<UsersViewModel>.value(value: GetIt.I.get()),
        ChangeNotifierProvider<ScheduleViewModel>.value(value: GetIt.I.get()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          NavigationBottom.id: (context) => const NavigationBottom(),
          LandingPageView.id: (context) => const LandingPageView(),
          LoginView.id: (context) => const LoginView(),
          SignUp.id: (context) => const SignUp(),
          HomeView.id: (context) => const HomeView(),
          HelpView.id: (context) => const HelpView(),
          HelpEmailView.id: (context) => const HelpEmailView(),
          AdminHomeView.id: (context) => const AdminHomeView(),
        },
      ),
    );
  }
}
