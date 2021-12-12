import 'package:api_appmusic/model/lagu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiService {
  final String baseURL = "http://192.168.43.18";
  //Client client = Client();

  Future<List<Lagu>> getLagus() async {
    final response = await http.get("$baseURL/api-appmusic/lagu");
    if (response.statusCode == 200) {
      return laguFromJson(response.body);
    } else {
      return null;
    }
  }

Future<bool> createLagu(Lagu data) async {
  final response = await http.post(
    "$baseURL/api-appmusic/lagu",
    headers: {"content-type": "application/json"},
    body: laguToJson(data),
  );
  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
    }
  }
}
