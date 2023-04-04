import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiConstants {
  static String sendOtp = 'https://test-otp-api.7474224.xyz/sendotp.php';
  static String verifyOtp = 'https://test-otp-api.7474224.xyz/verifyotp.php';
  static String submitProfile =
      'https://test-otp-api.7474224.xyz/profilesubmit.php';
}

class ApiService {
//
//
//---------------------------------send otp--------------------//
//
//
  Future getOtp(String phoneNumber) async {
    try {
      final body = {"mobile": phoneNumber};
      final jsonString = json.encode(body);
      var url = Uri.parse(ApiConstants.sendOtp);
      print(phoneNumber);
      log("url $url");
      var response = await http.post(url,
          body: jsonString, headers: {'Access-Control-Allow-Origin': '*'});
      // var response = await http.get(url, headers: {"mobile": phoneNumber});
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        return jsonData;
      }
    } catch (e) {
      log("error ->${e.toString()}");
    }
  }

  //
//
//---------------------------------verify otp--------------------//
//
//
  Future verifyOtp(String reqId, String Otp) async {
    try {
      print(reqId);
      print(Otp);
      var url = Uri.parse(ApiConstants.verifyOtp);
      final body = {"request_id": reqId, "code": Otp};
      final jsonString = json.encode(body);
      log("url $url");
      var response = await http.post(url,
          body: jsonString, headers: {'Access-Control-Allow-Origin': '*'});
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        return jsonData;
      }
    } catch (e) {
      log("error ->${e.toString()}");
    }
  }

  //
//
//---------------------------------verify otp--------------------//
//
//
  Future submitProfile(String name, String mail, String token) async {
    try {
      var url = Uri.parse(ApiConstants.submitProfile);
      final body = {"name": name, "email": mail};
      final jsonString = json.encode(body);
      log("url $url");
      var response = await http.post(url,
          body: jsonString,
          headers: {"Token": token, 'Access-Control-Allow-Origin': '*'});
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        return jsonData;
      }
    } catch (e) {
      log("error ->${e.toString()}");
    }
  }
}
