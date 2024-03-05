part of 'values.dart';

class Styles {
  static TextStyle underLineTextStyle = const TextStyle(
      color: AppColors.darkRed,
      fontSize: 14,
      decorationThickness: 1,
      decoration: TextDecoration.underline);

  static TextStyle textStyle = const TextStyle(
    color: AppColors.darkRed,
    fontSize: 14,
  );
}

class Borders {
  static BorderSide darkRedBorderSide =
      const BorderSide(width: 1, color: AppColors.darkRed);
  static BorderSide whiteBorderSide =
      const BorderSide(width: 1, color: AppColors.white);
}

class Paddings {
  static EdgeInsetsGeometry textPadding =
      const EdgeInsets.symmetric(horizontal: 10, vertical: 10);
}
