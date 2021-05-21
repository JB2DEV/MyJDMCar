import 'package:flutter/material.dart';
class ThemeButton extends StatelessWidget {

  final Function function;
  final String buttonText;
  const ThemeButton({Key key, this.function, this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 230,
          child: ElevatedButton(
            onPressed: function,
            child: Text(buttonText.toUpperCase()),
          ),
        ),
      ],
    );
  }
}
