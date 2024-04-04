import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static const String baseURL = 'http://10.0.2.2:8000';

  static Future<Map<String, dynamic>> fetch(String path) async {
    http.Response response = await http.get(Uri.parse('$baseURL/$path'));
    if (response.statusCode == 200) {
      // Se o servidor retornar uma resposta OK, parse o JSON.
      String jsonUTF8 = utf8.decode(response.bodyBytes);
      return jsonDecode(jsonUTF8);
    } else {
      // Se a resposta não for OK, lance uma exceção.
      throw Exception('Erro ao carregar dados da API, erro: ${response.statusCode}');
    }
  }
}

class ProjetosAPI {
  final String? tituloProj;
  final String? tituloAtiv;
  final String? pesqResp;
  final String? municipio;
  final String? local;

  ProjetosAPI({
    this.tituloProj,
    this.tituloAtiv,
    this.pesqResp,
    this.municipio,
    this.local,
  });

  factory ProjetosAPI.fromJson(Map<String, dynamic> json) {
    return ProjetosAPI(
      tituloProj: json['titulo_Proj'],
      tituloAtiv: json['titulo_Ativ'],
      pesqResp: json['pesq_Resp'],
      municipio: json['municipio'],
      local: json['local'],
    );
  }
}

class coletaAPI {
  List<Map<String, List<String>>>? parcelas;
  List<String>? tratamentos;
  List<String>? repeticao;
  List<String>? variavel;

  coletaAPI({this.parcelas, this.tratamentos, this.repeticao, this.variavel});

  coletaAPI.fromJson(Map<String, dynamic> json) {
    parcelas = [];
    json['parcelas'].forEach((key, value) {
      parcelas!.add({key: value});
    });
    tratamentos = json['tratamentos'].cast<String>();
    repeticao = json['repeticao'].cast<String>();
    variavel = json['variavel'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parcelas'] = this.parcelas;
    data['tratamentos'] = this.tratamentos;
    data['repeticao'] = this.repeticao;
    data['variavel'] = this.variavel;
    return data;
  }
}
