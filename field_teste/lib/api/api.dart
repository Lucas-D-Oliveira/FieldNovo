import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> fetch() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  var todo = Todo(id: json['id'], completed: json['completed'], title: json['title'], userId: json['userId']);
  return json;
}

class Todo {
  final String title;
  final int id;
  final int userId;
  final bool completed;

  Todo({required this.title, required this.id, required this.userId,  required this.completed});
}

class Logar {
  final String login;
  final String senha;

  Logar({required this.login, required this.senha});
}