import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserController extends GetxController {
  final UserService _userService = Get.find<UserService>();
  
  Rx<User?> currentUser = Rx<User?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      currentUser.value = await _userService.getCurrentUser();
    } catch (e) {
      errorMessage.value = 'Erro ao carregar usuário: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveUser(User user) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final savedUser = await _userService.saveUser(user);
      currentUser.value = savedUser;
      
      Get.snackbar(
        'Sucesso',
        'Perfil salvo com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple,
        colorText: Colors.white,
      );
      
      return true;
    } catch (e) {
      errorMessage.value = 'Erro ao salvar usuário: ${e.toString()}';
      Get.snackbar(
        'Erro',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final updatedUser = await _userService.updateUser(user);
      currentUser.value = updatedUser;
      
      Get.snackbar(
        'Sucesso',
        'Perfil atualizado com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple,
        colorText: Colors.white,
      );
      
      return true;
    } catch (e) {
      errorMessage.value = 'Erro ao atualizar usuário: ${e.toString()}';
      Get.snackbar(
        'Erro',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }

  bool get hasUser => currentUser.value != null;
  User? get user => currentUser.value;
}