import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

import 'storage/favorite_notifier.dart';
import 'storage/theme_notifier.dart';
import 'storage/storage_manager.dart';
import 'supporting/app_theme.dart';
import 'ui/main_screen.dart';


void main() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.verbose;
  var delegate = await LocalizationDelegate.create(
      preferences: StorageManager(),
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'ru']);

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeNotifier()),
            ChangeNotifierProvider(create: (_) => FavoriteNotifier()),
          ],
      child: Phoenix(child: LocalizedApp(delegate, const MyApp()))
      )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    Provider.of<ThemeNotifier>(context, listen: false).initializeApp();
    Provider.of<FavoriteNotifier>(context, listen: false).initialize();
    
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: theme.darkMode ? MovieTheme.dark() : MovieTheme.light(),

          debugShowCheckedModeBanner: false,
          home: const MainScreen(),
        ),
      ),
    );
  }
}




