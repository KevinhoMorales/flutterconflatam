import 'dart:convert';

import 'package:http/http.dart' as http;

// TODO - Necesitas correr algún server local o poner una url real acá
// Si no te va a tirar error
const String backendUrl = "http://localhost:5173/api";

class ApiClient {
  Future<String> translate(String text) async {
    final response = await http.post(Uri.parse("$backendUrl/translate"),
        body: jsonEncode({"message": text, "language": "english"}));

    final Map<String, dynamic> translation = jsonDecode(response.body);
    if (translation.containsKey("success") &&
        (translation["success"] is bool) &&
        translation["success"] == true) {
      return translation["answer"];
    } else {
      throw Exception("Sorry, there was an error :(");
    }
    // TODO - Si quieres probar con texto dummy,
    // puedes descomentar esto para simular una respuesta de la API.
    // return Future.delayed(Duration(seconds: 2))
    //    .then((value) => "Some translation");
  }
}
