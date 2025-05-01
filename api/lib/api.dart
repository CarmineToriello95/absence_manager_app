import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

const absencesPath = 'json_files/absences.json';
const membersPath = 'json_files/members.json';

class CrewmeisterApi {
  final bool isTest;
  CrewmeisterApi({this.isTest = false});

  Future<List<dynamic>> readJsonFile(String path) async {
    final prefix = isTest ? 'assets/' : 'api/assets/';
    String content = await rootBundle.loadString('$prefix$path');
    Map<String, dynamic> data = jsonDecode(content);
    return data['payload'];
  }

  Future<List<dynamic>> absences() async {
    return await readJsonFile(absencesPath);
  }

  Future<List<dynamic>> members() async {
    return await readJsonFile(membersPath);
  }
}
