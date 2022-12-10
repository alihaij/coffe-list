import 'dart:convert';
import 'package:http/http.dart' as http;

class CoffeeApi {
  Future<String> CoffeeData(String type) async {
    http.Response response =
        await http.get(Uri.parse('https://api.sampleapis.com/coffee/$type'));
    String data = response.body;

    return data;
  }
}
