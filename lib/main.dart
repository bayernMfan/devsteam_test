import 'package:flutter/material.dart';
import 'pages/auth_page.dart';
import 'pages/gallery_page.dart';
import 'pages/photo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devsteam_test app',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('AuthPage'),
            builder: (context) => AuthPage(
              title: 'AuthPage',
            ),
          ),
        ],
        initialRoute: '/AuthPage',
        onGenerateInitialRoutes: (navigator, initialRoute) {
          return <Route>[];
        },
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case '/AuthPage':
              return MaterialPageRoute(
                  builder: (context) => AuthPage(title: 'AuthPage'));
            case '/GalleryPage':
              return MaterialPageRoute(builder: (context) => GalleryPage());
            case '/PhotoPage':
              return MaterialPageRoute(builder: (context) => PhotoPage());
            default:
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('ERROR ROUTE'),
                  ),
                  body: Center(
                    child: Text('Page not found'),
                  ),
                ),
              );
          }
        },
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          return true;
        },
      ),
    );
  }
}
