import 'dart:convert';
import 'package:daymond_collaboration_app/collaboration/models/userModel.dart';
import 'package:http/http.dart' as http;

class TodoService {
  Future<List<User>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    // print(response);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final todos = json.map((json) {
        return User(
          id: json['id'],
          name: json['name'],
          prenom: json['prenom'],
          contact: json['contact'],
          contact_whatsap: json['contact_whatsap'],
          pays: json['pays'],
          ville: json['ville'],
          photo: json['contact_whatsap'],
          role_as: json['role_as'],
          profession: json['profession'],
          email: json['email'],
          created_at: json['created_at'],
        );
      }).toList();
      return todos;
    }
    return [];
  }
}