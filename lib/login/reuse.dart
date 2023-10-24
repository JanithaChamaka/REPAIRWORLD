import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();
Container buildLoginBtn(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.symmetric(vertical: 25),
    // width: double.infinity,
    child: ElevatedButton(
      onPressed: () => {onTap()},
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(15),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFF0E64D2),
        ),
      ),
      child: Text(
        isLogin ? 'LOGIN' : 'SIGNUP',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
  );
}
