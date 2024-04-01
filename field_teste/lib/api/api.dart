import 'dart:convert';
import 'package:http/http.dart' as http;
import  'package:field_teste/paginas/LoginCad.dart';


Future<Map> fetch() async {
  var url = Uri.parse('http://127.0.0.1:8000/login');
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  var todo = Todo(id: json['id'], completed: json['completed'], title: json['title'], userId: json['userId']);
  var logar = Logar(email: json['usuario'], senha: json['senha']);
  return json;
}

class Todo {
  final String title;
  final int id;
  final int userId;
  final bool completed;

  Todo({required this.title, required this.id, required this.userId,  required this.completed});
}

class Logar{
  final String email;
  final String senha;

  Logar({required this.email, required this.senha});
}
