import 'package:http/http.dart' as http;

class RestApiServices {
  static Future<dynamic> restApiRequest(String apiLink, dynamic payLoad, Function jsonFunction) async {
    var client = http.Client();
    var uriIE = Uri.parse(apiLink);
    var response = await client.put(uriIE, body: payLoad);

    print(response.statusCode);
    if (response.statusCode == 200) {
      //var responseBody = response.reasonPhrase;
      //var restApiReponse = await jsonFunction(responseBody);
      //return restApiReponse;
    } else {
      return "error";
    }
  }
}
