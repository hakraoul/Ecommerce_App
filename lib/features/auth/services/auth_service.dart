import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variables.dart';

class AuthService {
  void SignUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        name: name,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Please Login with the same credentials.',
          );
        },
      );
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }
}
