import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class UserRegisterScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  UserRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        titleTextStyle: TextStyle(
          color: Colors.purple,
          fontSize: 20,
          fontFamily: 'padrao'
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.purple),
      ),
      body: Obx(() => Stepper(
        currentStep: controller.currentStep.value,
        onStepTapped: controller.goToStep,
        controlsBuilder: (context, details) {
          return Row(
            children: [
              if (details.stepIndex < 2) 
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Próximo'),
                ),
              SizedBox(width: 10),
              if (details.stepIndex > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text('Voltar', style: TextStyle(color: Colors.purple)),
                ),
              if (details.stepIndex == 2)
                ElevatedButton(
                  onPressed: controller.isLoading.value 
                    ? null 
                    : controller.saveUserData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: controller.isLoading.value 
                    ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : Text('Salvar'),
                ),
            ],
          );
        },
        onStepContinue: () {
          if (controller.currentStep.value == 0) {
            if (controller.validateForm()) {
              controller.nextStep();
            }
          } else {
            controller.nextStep();
          }
        },
        onStepCancel: controller.previousStep,
        steps: [
          Step(
            title: Text('Informações Pessoais', 
              style: TextStyle(color: Colors.purple)),
            content: _buildPersonalInfoStep(),
            isActive: controller.currentStep.value == 0,
          ),
          Step(
            title: Text('Preferências', 
              style: TextStyle(color: Colors.purple)),
            content: _buildPreferencesStep(),
            isActive: controller.currentStep.value == 1,
          ),
          Step(
            title: Text('Confirmação', 
              style: TextStyle(color: Colors.purple)),
            content: _buildConfirmationStep(),
            isActive: controller.currentStep.value == 2,
          ),
        ],
      )),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nomeController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nome Completo',
              labelStyle: TextStyle(color: Colors.purple),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nome é obrigatório';
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: controller.emailController,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.purple),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'E-mail é obrigatório';
              }
              if (!value.contains('@')) {
                return 'E-mail inválido';
              }
              return null;
            },
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: controller.telefoneController,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Telefone',
              labelStyle: TextStyle(color: Colors.purple),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2),
              ),
            ),
          ),
          SizedBox(height: 15),
          Obx(() => InkWell(
            onTap: () => _showDatePicker(),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.purple),
                  SizedBox(width: 10),
                  Text(
                    controller.selectedDate.value != null
                      ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
                      : 'Data de Nascimento',
                    style: TextStyle(
                      color: controller.selectedDate.value != null 
                        ? Colors.white 
                        : Colors.purple
                    ),
                  ),
                ],
              ),
            ),
          )),
          SizedBox(height: 15),
          Obx(() => DropdownButtonFormField<String>(
            value: controller.selectedGender.value.isEmpty 
              ? null 
              : controller.selectedGender.value,
            dropdownColor: Colors.grey[800],
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Gênero',
              labelStyle: TextStyle(color: Colors.purple),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2),
              ),
            ),
            items: ['Masculino', 'Feminino', 'Outro', 'Prefiro não informar']
              .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              )).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.selectedGender.value = value;
              }
            },
          )),
          SizedBox(height: 15),
          TextFormField(
            controller: controller.bioController,
            style: TextStyle(color: Colors.white),
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Biografia (opcional)',
              labelStyle: TextStyle(color: Colors.purple),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purple, width: 2),
              ),
              hintText: 'Conte um pouco sobre você...',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipo de Conteúdo Preferido:',
          style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Obx(() => Column(
          children: ['manga', 'anime', 'ambos'].map((type) => 
            RadioListTile<String>(
              title: Text(
                type == 'manga' ? 'Manga' : 
                type == 'anime' ? 'Anime' : 'Ambos',
                style: TextStyle(color: Colors.white),
              ),
              value: type,
              groupValue: controller.selectedContentType.value,
              activeColor: Colors.purple,
              onChanged: (value) {
                if (value != null) {
                  controller.selectedContentType.value = value;
                }
              },
            )
          ).toList(),
        )),
        SizedBox(height: 20),
        Text(
          'Gêneros Preferidos:',
          style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8,
          children: controller.availableGenres.map((genre) {
            final isSelected = controller.selectedGenres.contains(genre);
            return FilterChip(
              label: Text(genre),
              selected: isSelected,
              backgroundColor: Colors.grey[800],
              selectedColor: Colors.purple.withOpacity(0.7),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[300],
              ),
              onSelected: (selected) {
                controller.toggleGenre(genre);
              },
            );
          }).toList(),
        )),
        SizedBox(height: 20),
        Text(
          'Classificação Etária Preferida:',
          style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Obx(() => DropdownButtonFormField<String>(
          value: controller.selectedAgeRating.value,
          dropdownColor: Colors.grey[800],
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple, width: 2),
            ),
          ),
          items: ['livre', '10+', '12+', '14+', '16+', '18+']
            .map((rating) => DropdownMenuItem(
              value: rating,
              child: Text(rating),
            )).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.selectedAgeRating.value = value;
            }
          },
        )),
        SizedBox(height: 20),
        _buildFavoritesSection(),
        SizedBox(height: 20),
        _buildNotificationSettings(),
      ],
    );
  }

  Widget _buildFavoritesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mangás Favoritos:',
          style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildFavoritesList(
          controller.favoriteManga,
          'Digite o nome do mangá',
          controller.addFavoriteManga,
          controller.removeFavoriteManga,
        ),
        SizedBox(height: 15),
        Text(
          'Animes Favoritos:',
          style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _buildFavoritesList(
          controller.favoriteAnime,
          'Digite o nome do anime',
          controller.addFavoriteAnime,
          controller.removeFavoriteAnime,
        ),
      ],
    );
  }

  Widget _buildFavoritesList(
    RxList<String> list,
    String hintText,
    Function(String) addFunction,
    Function(String) removeFunction,
  ) {
    final textController = TextEditingController();
    
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  addFunction(textController.text);
                  textController.clear();
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 10),
        Obx(() => list.isNotEmpty 
          ? Wrap(
              spacing: 8,
              children: list.map((item) => Chip(
                label: Text(item, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.purple.withOpacity(0.7),
                deleteIcon: Icon(Icons.close, color: Colors.white, size: 18),
                onDeleted: () => removeFunction(item),
              )).toList(),
            )
          : Container()),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configurações de Notificação:',
          style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Obx(() => SwitchListTile(
          title: Text('Notificações de Lançamentos', 
            style: TextStyle(color: Colors.white)),
          value: controller.releaseNotifications.value,
          activeColor: Colors.purple,
          onChanged: (value) {
            controller.releaseNotifications.value = value;
          },
        )),
        Obx(() => SwitchListTile(
          title: Text('Notificações de Recomendações', 
            style: TextStyle(color: Colors.white)),
          value: controller.recommendationNotifications.value,
          activeColor: Colors.purple,
          onChanged: (value) {
            controller.recommendationNotifications.value = value;
          },
        )),
      ],
    );
  }

  Widget _buildConfirmationStep() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirme suas informações:',
          style: TextStyle(color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        _buildInfoCard('Nome', controller.nomeController.text),
        _buildInfoCard('E-mail', controller.emailController.text),
        _buildInfoCard('Telefone', controller.telefoneController.text),
        _buildInfoCard('Data de Nascimento', 
          controller.selectedDate.value != null
            ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
            : 'Não informado'),
        _buildInfoCard('Gênero', controller.selectedGender.value),
        _buildInfoCard('Tipo de Conteúdo', 
          controller.selectedContentType.value == 'manga' ? 'Manga' :
          controller.selectedContentType.value == 'anime' ? 'Anime' : 'Ambos'),
        if (controller.selectedGenres.isNotEmpty)
          _buildInfoCard('Gêneros Preferidos', controller.selectedGenres.join(', ')),
        if (controller.favoriteManga.isNotEmpty)
          _buildInfoCard('Mangás Favoritos', controller.favoriteManga.join(', ')),
        if (controller.favoriteAnime.isNotEmpty)
          _buildInfoCard('Animes Favoritos', controller.favoriteAnime.join(', ')),
      ],
    ));
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[900],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value.isEmpty ? 'Não informado' : value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Colors.purple,
            colorScheme: ColorScheme.dark(primary: Colors.purple),
          ),
          child: child!,
        );
      },
    );
    
    if (date != null) {
      controller.selectedDate.value = date;
    }
  }
}