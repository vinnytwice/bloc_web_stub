import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      onPressed: _onPressed,
      child: Text(
        'Register',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
//          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
