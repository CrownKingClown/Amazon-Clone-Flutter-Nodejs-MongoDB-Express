import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart ' as http;
import './../constants/utils.dart';

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 401:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 403:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 404:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 502:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 503:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 504:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    default:
      showSnackBar(context, jsonDecode(response.body)['message']);
  }
}
