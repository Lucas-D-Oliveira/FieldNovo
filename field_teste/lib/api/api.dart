import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  static const String baseURL = 'http://10.0.2.2:8000';

  // Este método busca tanto atividades quanto coletas
  static Future<List<AtividadesEColeta>> fetchAtividades() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Se os dados salvos existirem, remova-os antes de salvar os novos dados
    if (prefs.containsKey('atividades')) {
      prefs.remove('atividades');
    }

    // Se não houver dados salvos ou se estiver online, faz a chamada para a API
    if (await isOnline()) {
      http.Response response = await http.get(Uri.parse('$baseURL/atividades'));
      if (response.statusCode == 200) {
        String jsonUTF8 = utf8.decode(response.bodyBytes);
        print('Lista retornada pela API: $jsonUTF8');
        List<dynamic> data = jsonDecode(jsonUTF8);

        // Salva os novos dados tratados em SharedPreferences
        prefs.setString('atividades', jsonUTF8);
        return data.map((item) => AtividadesEColeta.fromJson(item)).toList();
      } else {
        throw Exception('Erro ao carregar dados da API, erro: ${response.statusCode}');
      }
    } else {
      // Se não houver conexão de rede, tente recuperar os dados salvos
      if (prefs.containsKey('atividades')) {
        String? savedData = prefs.getString('atividades');
        if (savedData != null) {
          List<dynamic> data = jsonDecode(savedData);
          return data.map((item) => AtividadesEColeta.fromJson(item)).toList();
        }
      }
      throw Exception('Sem conexão de rede e dados salvos não encontrados.');
    }
  }



  static Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (_) {}
    return false;
  }
}

class Atividade {
  final String tituloProj;
  final String tituloAtiv;
  final String pesqResp;
  final String municipio;
  final String local;

  Atividade({
    required this.tituloProj,
    required this.tituloAtiv,
    required this.pesqResp,
    required this.municipio,
    required this.local,
  });

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      tituloProj: json['titulo_Proj'],
      tituloAtiv: json['titulo_Ativ'],
      pesqResp: json['pesq_Resp'],
      municipio: json['municipio'],
      local: json['local'],
    );
  }
}

class Coleta {
  final Map<String, List<String>> parcelas;
  final List<String> tratamentos;
  final List<String> repeticao;
  final List<String> variavel;

  Coleta({
    required this.parcelas,
    required this.tratamentos,
    required this.repeticao,
    required this.variavel,
  });

  factory Coleta.fromJson(Map<String, dynamic> json) {
    return Coleta(
      parcelas: Map.from(json['parcelas']).map((key, value) => MapEntry(key, List<String>.from(value))),
      tratamentos: List<String>.from(json['tratamentos']),
      repeticao: List<String>.from(json['repeticao']),
      variavel: List<String>.from(json['variavel']),
    );
  }
}

class AtividadesEColeta {
  final Atividade atividade;
  late final Coleta coleta;

  AtividadesEColeta({
    required this.atividade,
    required this.coleta,
  });

  factory AtividadesEColeta.fromJson(Map<String, dynamic> json) {
    return AtividadesEColeta(
      atividade: Atividade.fromJson(json['atividade']),
      coleta: Coleta.fromJson(json['coleta']),
    );
  }
}

