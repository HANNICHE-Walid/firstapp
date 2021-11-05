import 'dart:convert';

import 'package:http/http.dart' as http;
import 'assisMethods.dart';

class RequestAssist {
  static Future<dynamic> getReqeust(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    try {
      if (response == 200) {
        String jSondata = response.body;
        var decoData = jsonDecode(jSondata);
        return decoData;
      } else {
        return "echec de repense";
      }
    } catch (exp) {
      return "echec";
    }
  }
}
