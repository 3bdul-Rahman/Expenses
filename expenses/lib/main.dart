import 'package:expenses/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

ThemeMode appmode = ThemeMode.light;

var myColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 59, 96, 179),
);
var myDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 59, 96, 179),
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: appmode,
        theme: ThemeData.light().copyWith(
          brightness: Brightness.light,
          // ignore: deprecated_member_use
          useMaterial3: true,
          colorScheme: myColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: myColorScheme.primary,
            foregroundColor: myColorScheme.onPrimary,
          ),
          cardTheme: const CardTheme().copyWith(
            color: myColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: myColorScheme.primaryContainer),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: myColorScheme.onSecondaryContainer,
                  fontSize: 22,
                ),
              ),
        ),
        darkTheme: ThemeData.dark().copyWith(
            brightness: Brightness.dark,
            // ignore: deprecated_member_use
            useMaterial3: true,
            colorScheme: myDarkColorScheme,
            bottomSheetTheme: const BottomSheetThemeData().copyWith(
              backgroundColor: myDarkColorScheme.primary,
            ),
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: myDarkColorScheme.onPrimaryContainer,
              foregroundColor: myDarkColorScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
              color: myDarkColorScheme.secondary,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: myDarkColorScheme.primaryContainer,
                foregroundColor: myDarkColorScheme.onPrimaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: myDarkColorScheme.onSecondaryContainer,
                  fontSize: 22,
                ),
                bodyMedium: TextStyle(
                  color: myDarkColorScheme.secondaryContainer,
                  fontWeight: FontWeight.normal,
                )),
            iconTheme: const IconThemeData()
                .copyWith(color: myDarkColorScheme.secondaryContainer)),
        debugShowCheckedModeBanner: false,
        home: const Expenses());
  }
}
