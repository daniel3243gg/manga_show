import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  static const String _userKey = 'current_user';
  
  Future<User?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(_userKey);
      
      if (userData != null) {
        final Map<String, dynamic> userJson = json.decode(userData);
        return User.fromJson(userJson);
      }
      
      return null;
    } catch (e) {
      throw Exception('Erro ao carregar dados do usuário: ${e.toString()}');
    }
  }

  Future<User> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = json.encode(user.toJson());
      
      final success = await prefs.setString(_userKey, userJson);
      if (!success) {
        throw Exception('Falha ao salvar dados do usuário');
      }
      
      return user;
    } catch (e) {
      throw Exception('Erro ao salvar usuário: ${e.toString()}');
    }
  }

  Future<User> updateUser(User user) async {
    return await saveUser(user);
  }

  Future<bool> deleteUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_userKey);
    } catch (e) {
      throw Exception('Erro ao deletar usuário: ${e.toString()}');
    }
  }

  Future<bool> hasUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_userKey);
    } catch (e) {
      return false;
    }
  }

  // Métodos utilitários para validação
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidPhone(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return cleanPhone.length >= 10 && cleanPhone.length <= 11;
  }

  bool isValidAge(DateTime birthDate) {
    final now = DateTime.now();
    final age = now.difference(birthDate).inDays ~/ 365;
    return age >= 13; // Idade mínima
  }

  List<String> getAvailableGenres() {
    return [
      'Ação',
      'Aventura',
      'Comédia',
      'Drama',
      'Fantasia',
      'Romance',
      'Horror',
      'Mistério',
      'Thriller',
      'Ficção Científica',
      'Slice of Life',
      'Sobrenatural',
      'Histórico',
      'Esporte',
      'Ecchi',
      'Shounen',
      'Shoujo',
      'Seinen',
      'Josei',
      'Yaoi',
      'Yuri',
      'Mecha',
      'Isekai',
    ];
  }

  List<String> getReadingPlatforms() {
    return [
      'MangaDex',
      'Crunchyroll Manga',
      'VIZ Media',
      'ComiXology',
      'Mangamo',
      'MANGA Plus',
      'Webtoon',
      'Tapas',
      'Mangá Livre',
      'Union Mangás',
      'Mangás Zone',
      'Central de Mangás',
    ];
  }

  List<String> getReadingStatus() {
    return [
      'Iniciante',
      'Intermediário', 
      'Avançado',
      'Expert'
    ];
  }
}