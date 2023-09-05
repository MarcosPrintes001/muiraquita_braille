
import 'package:http/http.dart' as http;

String baseUrl = "https://641c9603b556e431a8725da5.mockapi.io";

Future<http.Response> signUp(String name, String email, String password) async {
  var response = await http.post(Uri.parse("$baseUrl/users"),
      body: {"name": name, "email": email, "password": password});

  return response;
}
