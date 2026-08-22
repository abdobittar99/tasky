import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_size.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFFFFFF),
    secondary: Color(0xff3A4640),
  ),
  scaffoldBackgroundColor: Color(0xffF6F7F9),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontSize: AppSize.sp20,
      fontWeight: FontWeight.w400,
      color: Color(0xff161F1B),
    ),
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSize.sp24,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: AppSize.sp28,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: AppSize.sp32,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      fontSize: AppSize.sp14,
      color: Color(0xff3A4640),
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      fontSize: AppSize.sp16,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    //  for Done tasks
    titleLarge: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize: AppSize.sp16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: AppSize.sp20,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: AppSize.sp16),
    labelLarge: TextStyle(color: Colors.black, fontSize: AppSize.sp24),
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),
      borderSide: BorderSide(color: Colors.redAccent, width: 0.5),
    ),
    hintStyle: TextStyle(color: Color(0xff9E9E9E)),
    filled: true,
    fillColor: Color(0xffFFFFFF),
    focusColor: Color(0xff9E9E9E),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xff9e9e9e);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9e9e9e);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xff15B86C),
      foregroundColor: Color(0xfffffcfc),
      minimumSize: Size.fromHeight(AppSize.h40),
      textStyle: TextStyle(fontSize: AppSize.sp14, fontWeight: FontWeight.w500),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.black),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xfffffcfc),
    extendedTextStyle: TextStyle(
      fontSize: AppSize.sp14,
      fontWeight: FontWeight.w500,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xffD1DAD6), width: AppSize.w2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(AppSize.r4),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: AppSize.sp16,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.grey[300],
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xffF6F7F9),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xff3A4640),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xffF6F7F9),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),
    ),
    elevation: 3,
    shadowColor: Color(0xff15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        fontSize: AppSize.sp16,
        fontWeight: FontWeight.w400,
        color: Color(0xff161F1B),
      ),
    ),
  ),
);
