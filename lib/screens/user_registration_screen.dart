import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';
import '../services/user_service.dart';

class UserRegistrationScreen extends StatefulWidget {
  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final UserController userController = Get.find<UserController>();
  final UserService userService = Get.find<UserService>();
  
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _preferencesFormKey = GlobalKey<FormState>();
  
  int _currentPage = 0;
  final int _totalPages = 3;

  // Controladores de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // Dados do usuário
  DateTime? _dataNascimento;
  String _genero = '';
  List<String> _generosPreferidos = [];
  List<String> _autoresFavoritos = [];
  List<String> _mangasFavoritos = [];
  String _statusLeitura = 'Iniciante';
  List<String> _plataformasLeitura = [];
  bool _notificacaoLancamentos = true;
  bool _notificacaoRecomendacoes = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _bioController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 18 * 365)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.purple,
              onPrimary: Colors.white,
              surface: Colors.black87,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      if (_currentPage == 0 && !_personalFormKey.currentState!.validate()) {
        return;
      }
      
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  Future<void> _finishRegistration() async {
    if (!_preferencesFormKey.currentState!.validate()) {
      return;
    }

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      telefone: _telefoneController.text.trim(),
      dataNascimento: _dataNascimento!,
      genero: _genero,
      bio: _bioController.text.trim(),
      generosPreferidos: _generosPreferidos,
      autoresFavoritos: _autoresFavoritos,
      mangasFavoritos: _mangasFavoritos,
      statusLeitura: _statusLeitura.toLowerCase(),
      plataformasLeitura: _plataformasLeitura,
      notificacaoLancamentos: _notificacaoLancamentos,
      notificacaoRecomendacoes: _notificacaoRecomendacoes,
    );

    final success = await userController.saveUser(user);
    if (success) {
      Get.offAllNamed('/home'); // Navega para home e limpa stack de navegação
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        titleTextStyle: TextStyle(
          color: Colors.purple,
          fontSize: 20,
          fontFamily: 'padrao',
        ),
        backgroundColor: Colors.black,
        leading: _currentPage > 0
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.purple),
                onPressed: _previousPage,
              )
            : IconButton(
                icon: Icon(Icons.close, color: Colors.purple),
                onPressed: () => Get.back(),
              ),
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: List.generate(_totalPages, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index <= _currentPage ? Colors.purple : Colors.grey[800],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),
          
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildPersonalInfoPage(),
                _buildPreferencesPage(),
                _buildConfirmationPage(),
              ],
            ),
          ),
          
          // Navigation buttons
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentPage < _totalPages - 1)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text('Próximo'),
                    ),
                  ),
                if (_currentPage == _totalPages - 1)
                  Expanded(
                    child: Obx(() => ElevatedButton(
                      onPressed: userController.isLoading.value 
                          ? null 
                          : _finishRegistration,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: userController.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                          : Text('Finalizar Cadastro'),
                    )),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _personalFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações Pessoais',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'padrao',
              ),
            ),
            SizedBox(height: 20),
            
            TextFormField(
              controller: _nomeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nome Completo *',
                labelStyle: TextStyle(color: Colors.purple[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nome é obrigatório';
                }
                if (value.trim().length < 2) {
                  return 'Nome deve ter pelo menos 2 caracteres';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email *',
                labelStyle: TextStyle(color: Colors.purple[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email é obrigatório';
                }
                if (!userService.isValidEmail(value.trim())) {
                  return 'Email inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            
            TextFormField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Telefone *',
                hintText: '(11) 99999-9999',
                hintStyle: TextStyle(color: Colors.grey[600]),
                labelStyle: TextStyle(color: Colors.purple[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Telefone é obrigatório';
                }
                if (!userService.isValidPhone(value.trim())) {
                  return 'Telefone inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            
            InkWell(
              onTap: _selectDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento *',
                  labelStyle: TextStyle(color: Colors.purple[300]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                child: Text(
                  _dataNascimento == null
                      ? 'Selecione sua data de nascimento'
                      : '${_dataNascimento!.day.toString().padLeft(2, '0')}/${_dataNascimento!.month.toString().padLeft(2, '0')}/${_dataNascimento!.year}',
                  style: TextStyle(
                    color: _dataNascimento == null ? Colors.grey[600] : Colors.white,
                  ),
                ),
              ),
            ),
            if (_dataNascimento != null && !userService.isValidAge(_dataNascimento!))
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Idade mínima: 13 anos',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _genero.isEmpty ? null : _genero,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Gênero *',
                labelStyle: TextStyle(color: Colors.purple[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
              dropdownColor: Colors.grey[900],
              items: ['Masculino', 'Feminino', 'Outro', 'Prefiro não informar']
                  .map((genero) => DropdownMenuItem(
                        value: genero,
                        child: Text(genero, style: TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _genero = value ?? '';
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Gênero é obrigatório';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            
            TextFormField(
              controller: _bioController,
              maxLines: 3,
              maxLength: 200,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Bio (opcional)',
                hintText: 'Conte um pouco sobre você...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                labelStyle: TextStyle(color: Colors.purple[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _preferencesFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suas Preferências',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'padrao',
              ),
            ),
            SizedBox(height: 20),
            
            _buildMultiSelectField(
              'Gêneros Preferidos',
              userService.getAvailableGenres(),
              _generosPreferidos,
              (selected) => setState(() => _generosPreferidos = selected),
            ),
            SizedBox(height: 16),
            
            _buildTextListField(
              'Autores Favoritos (opcional)',
              _autoresFavoritos,
              (list) => setState(() => _autoresFavoritos = list),
              'Ex: Masashi Kishimoto, Eiichiro Oda...',
            ),
            SizedBox(height: 16),
            
            _buildTextListField(
              'Mangás Favoritos (opcional)',
              _mangasFavoritos,
              (list) => setState(() => _mangasFavoritos = list),
              'Ex: Naruto, One Piece, Attack on Titan...',
            ),
            SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _statusLeitura,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nível de Experiência',
                labelStyle: TextStyle(color: Colors.purple[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
              dropdownColor: Colors.grey[900],
              items: userService.getReadingStatus()
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status, style: TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _statusLeitura = value ?? 'Iniciante';
                });
              },
            ),
            SizedBox(height: 16),
            
            _buildMultiSelectField(
              'Plataformas de Leitura',
              userService.getReadingPlatforms(),
              _plataformasLeitura,
              (selected) => setState(() => _plataformasLeitura = selected),
            ),
            SizedBox(height: 20),
            
            Text(
              'Notificações',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            
            SwitchListTile(
              title: Text(
                'Notificações de Lançamentos',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Receber notificações sobre novos capítulos',
                style: TextStyle(color: Colors.grey[400]),
              ),
              value: _notificacaoLancamentos,
              onChanged: (value) {
                setState(() {
                  _notificacaoLancamentos = value;
                });
              },
              activeColor: Colors.purple,
              tileColor: Colors.transparent,
            ),
            
            SwitchListTile(
              title: Text(
                'Recomendações Personalizadas',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Receber sugestões baseadas nos seus gostos',
                style: TextStyle(color: Colors.grey[400]),
              ),
              value: _notificacaoRecomendacoes,
              onChanged: (value) {
                setState(() {
                  _notificacaoRecomendacoes = value;
                });
              },
              activeColor: Colors.purple,
              tileColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationPage() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirme seus dados',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'padrao',
            ),
          ),
          SizedBox(height: 20),
          
          _buildConfirmationCard('Informações Pessoais', [
            'Nome: ${_nomeController.text}',
            'Email: ${_emailController.text}',
            'Telefone: ${_telefoneController.text}',
            'Data de Nascimento: ${_dataNascimento != null ? '${_dataNascimento!.day.toString().padLeft(2, '0')}/${_dataNascimento!.month.toString().padLeft(2, '0')}/${_dataNascimento!.year}' : 'Não informado'}',
            'Gênero: $_genero',
            if (_bioController.text.isNotEmpty) 'Bio: ${_bioController.text}',
          ]),
          
          SizedBox(height: 16),
          
          _buildConfirmationCard('Preferências', [
            if (_generosPreferidos.isNotEmpty) 'Gêneros: ${_generosPreferidos.join(', ')}',
            if (_autoresFavoritos.isNotEmpty) 'Autores: ${_autoresFavoritos.join(', ')}',
            if (_mangasFavoritos.isNotEmpty) 'Mangás: ${_mangasFavoritos.join(', ')}',
            'Nível: $_statusLeitura',
            if (_plataformasLeitura.isNotEmpty) 'Plataformas: ${_plataformasLeitura.join(', ')}',
            'Notificações de lançamentos: ${_notificacaoLancamentos ? 'Sim' : 'Não'}',
            'Recomendações: ${_notificacaoRecomendacoes ? 'Sim' : 'Não'}',
          ]),
        ],
      ),
    );
  }

  Widget _buildMultiSelectField(
    String label,
    List<String> options,
    List<String> selected,
    Function(List<String>) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.purple[300],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple[300]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Container(
                height: 120,
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = selected.contains(option);
                    
                    return CheckboxListTile(
                      title: Text(
                        option,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      value: isSelected,
                      onChanged: (bool? value) {
                        List<String> newSelected = List.from(selected);
                        if (value == true) {
                          newSelected.add(option);
                        } else {
                          newSelected.remove(option);
                        }
                        onChanged(newSelected);
                      },
                      activeColor: Colors.purple,
                      checkColor: Colors.white,
                      dense: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        if (selected.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: selected.map((item) => Chip(
                label: Text(item, style: TextStyle(fontSize: 12)),
                deleteIcon: Icon(Icons.close, size: 16),
                onDeleted: () {
                  List<String> newSelected = List.from(selected);
                  newSelected.remove(item);
                  onChanged(newSelected);
                },
                backgroundColor: Colors.purple[700],
                labelStyle: TextStyle(color: Colors.white),
              )).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildTextListField(
    String label,
    List<String> items,
    Function(List<String>) onChanged,
    String hint,
  ) {
    final TextEditingController controller = TextEditingController();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.purple[300],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty && !items.contains(value.trim())) {
                    List<String> newItems = List.from(items);
                    newItems.add(value.trim());
                    onChanged(newItems);
                    controller.clear();
                  }
                },
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isNotEmpty && !items.contains(value)) {
                  List<String> newItems = List.from(items);
                  newItems.add(value);
                  onChanged(newItems);
                  controller.clear();
                }
              },
              icon: Icon(Icons.add, color: Colors.purple),
            ),
          ],
        ),
        if (items.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: items.map((item) => Chip(
                label: Text(item, style: TextStyle(fontSize: 12)),
                deleteIcon: Icon(Icons.close, size: 16),
                onDeleted: () {
                  List<String> newItems = List.from(items);
                  newItems.remove(item);
                  onChanged(newItems);
                },
                backgroundColor: Colors.purple[700],
                labelStyle: TextStyle(color: Colors.white),
              )).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildConfirmationCard(String title, List<String> items) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                item,
                style: TextStyle(color: Colors.white),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}