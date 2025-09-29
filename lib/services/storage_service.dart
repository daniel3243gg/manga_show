import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String USER_DATA_KEY = 'user_data';

  // Salvar dados do usuário
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = jsonEncode(userData);
      await prefs.setString(USER_DATA_KEY, userJson);
    } catch (e) {
      print('Erro ao salvar dados do usuário: $e');
      rethrow;
    }
  }

  // Carregar dados do usuário
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(USER_DATA_KEY);
      
      if (userJson != null) {
        return jsonDecode(userJson) as Map<String, dynamic>;
      }
      
      return null;
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
      return null;
    }
  }

  // Limpar dados do usuário
  Future<void> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(USER_DATA_KEY);
    } catch (e) {
      print('Erro ao limpar dados do usuário: $e');
      rethrow;
    }
  }

  // Verificar se existe dados do usuário
  Future<bool> hasUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(USER_DATA_KEY);
    } catch (e) {
      print('Erro ao verificar dados do usuário: $e');
      return false;
    }
  }
}