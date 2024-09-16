import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/pages/edit_task.dart';
import 'package:todoapp/pages/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todoapp/pages/signin.dart';
import 'package:todoapp/pages/signup.dart';
import 'package:todoapp/providers/bottom_nav_select.dart';
import 'package:todoapp/providers/firbase_provider.dart';
import 'package:todoapp/providers/select_language.dart';
import 'package:todoapp/providers/select_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/providers/user_provider.dart';
import 'package:todoapp/style/theme_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///shared preferences for language
  SelectLanguage languageProvider = SelectLanguage();
  await languageProvider.loadLanguage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => languageProvider),
        ChangeNotifierProvider(create: (context) => BottomNavSelect()),
        ChangeNotifierProvider(create: (context) => SelectTheme()),
        ChangeNotifierProvider(create: (context) => FireBaseProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<SelectLanguage>(context);
    var themeProvider = Provider.of<SelectTheme>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignIn.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        EditTask.routeName: (context) => EditTask(),
        Signup.routeName: (context) => Signup(),
        SignIn.routeName: (context) => SignIn(),
      },
      themeMode: themeProvider.themeState,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
