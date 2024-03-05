import 'package:flutter/material.dart';

class SuggestionButton extends StatelessWidget {
  final String title;
  final void Function() onClick;
  final bool isSelected;
  const SuggestionButton(
      {Key? key,
      required this.title,
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
            ? const Color.fromARGB(255, 33, 84, 40)
            : const Color(0xFF4AC382)),
        maximumSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
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
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
