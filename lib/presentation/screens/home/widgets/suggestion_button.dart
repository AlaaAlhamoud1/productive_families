import 'package:flutter/material.dart';
import 'package:productive_families/core/values/values.dart';

class SuggestionButton extends StatelessWidget {
  final String image;
  final void Function() onClick;
  final bool isSelected;
  const SuggestionButton(
      {Key? key,
      required this.image,
      required this.onClick,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
        backgroundColor: MaterialStateProperty.all<Color>(isSelected
            ? AppColors.appColor
            : AppColors.appColor.withOpacity(0.5)),
        maximumSize: MaterialStateProperty.all<Size>(const Size(400, 100)),
        minimumSize: MaterialStateProperty.all<Size>(const Size(100, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      child: Image.asset(
        image,
        color: Colors.white,
        fit: BoxFit.fill,
      ),
    );
  }
}
