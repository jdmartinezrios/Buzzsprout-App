import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiRest {
  String _url = 'https://www.buzzsprout.com/api/759992/episodes.json';
  String apiKey = 'Token token=de1da32d5178b61ee9511a43ff6912a9';

  getPlayList() async {
    http.Response response = await http.get(
      _url,
      headers: {HttpHeaders.authorizationHeader: apiKey},
    );

    final responseJson = json.decode(response.body);

    return responseJson;
  }
}
