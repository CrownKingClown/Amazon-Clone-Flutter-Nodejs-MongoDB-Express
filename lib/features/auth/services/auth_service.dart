import 'package:amazonclone/constants/global_variables.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        name: name,
        password: password,
        email: email,
        address: '',
        id: '',
        token: '',
        type: '',
      );
      final res = http.post(Uri.parse('$uri/api/users/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }) as http.Response;
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'message');
          });
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
}
