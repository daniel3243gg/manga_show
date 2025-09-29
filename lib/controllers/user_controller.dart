import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';

class UserController extends GetxController {
  // Controladores dos campos de texto
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final bioController = TextEditingController();
  
  // Observáveis para os dados do usuário
  var selectedDate = Rx<DateTime?>(null);
  var selectedGender = ''.obs;
  var selectedContentType = 'ambos'.obs;
  var selectedAgeRating = 'livre'.obs;
  
  // Listas de preferências
  var selectedGenres = <String>[].obs;
  var favoriteManga = <String>[].obs;
  var favoriteAnime = <String>[].obs;
  
  // Configurações de notificações
  var releaseNotifications = true.obs;
  var recommendationNotifications = true.obs;
  
  // Estado da tela
  var currentStep = 0.obs;
  var isLoading = false.obs;
  
  // Chave do formulário para validação
  final formKey = GlobalKey<FormState>();
  
  final StorageService _storageService = StorageService();

  // Gêneros disponíveis
  final List<String> availableGenres = [
    'Ação', 'Aventura', 'Comédia', 'Drama', 'Fantasia', 'Terror',
    'Romance', 'Slice of Life', 'Sobrenatural', 'Mistério', 
    'Ficção Científica', 'Esportes', 'Histórico', 'Psicológico'
  ];

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  @override
  void onClose() {
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    bioController.dispose();
    super.onClose();
  }

  // Carregar dados do usuário salvos
  Future<void> loadUserData() async {
    try {
      final userData = await _storageService.getUserData();
      if (userData != null) {
        final user = UserModel.fromMap(userData);
        
        nomeController.text = user.nome;
        emailController.text = user.email;
        telefoneController.text = user.telefone;
        bioController.text = user.bio;
        selectedDate.value = user.dataNascimento;
        selectedGender.value = user.genero;
        selectedContentType.value = user.tipoConteudoPreferido;
        selectedAgeRating.value = user.classificacaoEtariaPreferida;
        selectedGenres.value = user.generosPreferidos;
        favoriteManga.value = user.mangasFavoritos;
        favoriteAnime.value = user.animesFavoritos;
        releaseNotifications.value = user.notificacoesLancamentos;
        recommendationNotifications.value = user.notificacoesRecomendacoes;
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
    }
  }

  // Validar formulário
  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      if (selectedDate.value == null) {
        Get.snackbar('Erro', 'Por favor, selecione sua data de nascimento');
        return false;
      }
      if (selectedGender.value.isEmpty) {
        Get.snackbar('Erro', 'Por favor, selecione seu gênero');
        return false;
      }
      return true;
    }
    return false;
  }

  // Salvar dados do usuário
  Future<void> saveUserData() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      final user = UserModel(
        nome: nomeController.text,
        email: emailController.text,
        telefone: telefoneController.text,
        dataNascimento: selectedDate.value!,
        genero: selectedGender.value,
        bio: bioController.text,
        generosPreferidos: selectedGenres,
        mangasFavoritos: favoriteManga,
        animesFavoritos: favoriteAnime,
        tipoConteudoPreferido: selectedContentType.value,
        classificacaoEtariaPreferida: selectedAgeRating.value,
        notificacoesLancamentos: releaseNotifications.value,
        notificacoesRecomendacoes: recommendationNotifications.value,
      );

      await _storageService.saveUserData(user.toMap());
      
      Get.snackbar(
        'Sucesso', 
        'Dados salvos com sucesso!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      Get.back(); // Voltar para tela anterior
      
    } catch (e) {
      Get.snackbar(
        'Erro', 
        'Erro ao salvar dados: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Adicionar/remover gênero das preferências
  void toggleGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
    } else {
      selectedGenres.add(genre);
    }
  }

  // Adicionar manga favorito
  void addFavoriteManga(String manga) {
    if (manga.isNotEmpty && !favoriteManga.contains(manga)) {
      favoriteManga.add(manga);
    }
  }

  // Remover manga favorito
  void removeFavoriteManga(String manga) {
    favoriteManga.remove(manga);
  }

  // Adicionar anime favorito
  void addFavoriteAnime(String anime) {
    if (anime.isNotEmpty && !favoriteAnime.contains(anime)) {
      favoriteAnime.add(anime);
    }
  }

  // Remover anime favorito
  void removeFavoriteAnime(String anime) {
    favoriteAnime.remove(anime);
  }

  // Navegar entre steps do formulário
  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
  }
}