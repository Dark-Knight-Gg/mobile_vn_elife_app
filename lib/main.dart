import 'package:flutter/material.dart';
import 'package:mobile_vn_elife_app/routes.dart';
import 'package:mobile_vn_elife_app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      onGenerateRoute: RouteGenerator.generateRoute,
      onUnknownRoute: RouteGenerator.errorRoute,
      title: 'Form IO Demo',
    );
  }
}
