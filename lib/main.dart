import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_vn_elife_app/routes.dart';
import 'package:mobile_vn_elife_app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  static const platform = MethodChannel('setup_config');
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? initData;
    platform.setMethodCallHandler((data) async {
      if (data.method == 'sendData') {
        initData = data.arguments as Map<String, dynamic>;
        return;
      }
      initData = null;
    });
    return MaterialApp(
      theme: theme(
        fontName: "Inter",
        package: "dynamic_interface_warehouse",
        color: Colors.white,
        useMaterial3: true,
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaleFactor: 1.0),
          // Không dùng MediaQuery of context vì bị reload trong textfield
          child: child ?? const SizedBox.shrink(),
        );
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (routeSettings) {
        return RouteGenerator.generateRoute(
          routeSettings,
          initData,
        );
      },
      onUnknownRoute: RouteGenerator.errorRoute,
      title: 'Form IO Demo',
    );
  }
}
