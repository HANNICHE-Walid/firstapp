import 'package:firstapp/assist/requestAssist.dart';
import 'package:firstapp/configMap.dart';
import 'package:geolocator/geolocator.dart';

class AssiMethod {
  static Future<String> searchCooredinationAdress(Position position) async {
    String Adressplace = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.altitude}&key=${mapKey}";
    var responce = await RequestAssist.getReqeust(url);
    if (responce != "echech") {
      Adressplace = responce["results"][0]["formatted_address"];
    }

    return Adressplace;
  }
}
