import 'dart:convert';
import 'package:amazonclone/common/widgets/bottom_bar.dart';
import 'package:amazonclone/features/home/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:amazonclone/constants/global_variables.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//importing personal files
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AuthService {
  /*
  * This function is used to register a new user
  * @param email: email of the user
  * @param password: password of the user
  * @param name: name of the user
  * @return: returns a user object if the user is registered successfully
  * */
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
      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, res.body.toString());
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  /*
  * This function is used to login a user
  * @param email: email of the user
  * @param password: password of the user
  * @return: returns a user object if the user is logged in successfully
  * */
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        //if token is null i set it up to a empty string
        await prefs.setString('x-auth-token', '');
        token = '';
      }
      http.Response tokenResp = await http.get(
        Uri.parse('$uri/api/user/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );
      var response = jsonDecode(tokenResp.body);
      if (response == true) {
        http.Response res = await http.get(
          Uri.parse('$uri/api/user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );
        print(res.body);
        httpErrorHandler(
            response: res,
            context: context,
            onSuccess: () {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(res.body);
            });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
