import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ServiceProvider serviceProvider = await resolveServiceProviderFromEnvironment();
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(MyApp(
    serviceProvider,
  ));
}

class MyApp extends StatelessWidget {
  final ServiceProvider serviceProvider;
  MyApp(
    this.serviceProvider,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => serviceProvider,
      child: GetMaterialApp(
        initialRoute: navigationWrapperRoute,
        unknownRoute: GetPage(
          name: '/not-found',
          page: () => PageNotFound(),
        ),
        getPages: [
          GetPage(
              name: rootRoute,
              page: () {
                return SiteLayout();
              }),
          GetPage(name: authenticationPageRoute, page: () => AuthenticationPage()),
          GetPage(name: navigationWrapperRoute, page: () => ApplicationNavigationWrapper()),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        theme: ThemeData(
          scaffoldBackgroundColor: light,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
        ),
        builder: (context, child) {
          return AppTheme(
            appTheme: context.theme.brightness == Brightness.light ? AppTheme.light : AppTheme.dark,
            child: ContextServiceProviderBlocs(child: child!),
          );
        },
        // home: AuthenticationPage(),
      ),
    );
  }
}
