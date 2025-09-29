import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import 'user_registration_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final bool isEditing;
  
  const UserProfileScreen({Key? key, this.isEditing = false}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserController userController = Get.find<UserController>();
  final UserService userService = Get.find<UserService>();
  
  bool _isEditing = false;
  User? _currentUser;

  // Controladores para edição
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isEditing;
    _currentUser = userController.user;
    
    _initializeControllers();
  }

  void _initializeControllers() {
    _nomeController = TextEditingController(text: _currentUser?.nome ?? '');
    _emailController = TextEditingController(text: _currentUser?.email ?? '');
    _telefoneController = TextEditingController(text: _currentUser?.telefone ?? '');
    _bioController = TextEditingController(text: _currentUser?.bio ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (_currentUser == null) return;

    final updatedUser = _currentUser!.copyWith(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim(),
      telefone: _telefoneController.text.trim(),
      bio: _bioController.text.trim(),
    );

    final success = await userController.updateUser(updatedUser);
    if (success) {
      setState(() {
        _isEditing = false;
        _currentUser = updatedUser;
      });
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
    _initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Perfil' : 'Meu Perfil'),
        titleTextStyle: TextStyle(
          color: Colors.purple,
          fontSize: 20,
          fontFamily: 'padrao',
        ),
        backgroundColor: Colors.black,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.purple),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
            ),
          if (_isEditing)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: _cancelEditing,
                  child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: _saveChanges,
                  child: Text('Salvar', style: TextStyle(color: Colors.purple)),
                ),
              ],
            ),
        ],
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Colors.purple),
          );
        }

        if (!userController.hasUser) {
          return _buildNoUserCard();
        }

        return _buildProfileContent();
      }),
    );
  }

  Widget _buildNoUserCard() {
    return Center(
      child: Card(
        color: Colors.grey[900],
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.person_outline,
                size: 80,
                color: Colors.purple[300],
              ),
              SizedBox(height: 16),
              Text(
                'Nenhum perfil encontrado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Crie seu perfil para personalizar sua experiência',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => UserRegistrationScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Criar Perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(),
          _buildPersonalInfo(),
          _buildPreferences(),
          _buildNotificationSettings(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      color: Colors.grey[900],
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.purple[300],
            child: Text(
              _currentUser?.nome.isNotEmpty == true 
                  ? _currentUser!.nome[0].toUpperCase()
                  : '?',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12),
          if (_isEditing)
            TextFormField(
              controller: _nomeController,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple[300]!)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            )
          else
            Text(
              _currentUser?.nome ?? '',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          SizedBox(height: 8),
          Text(
            _calculateAge(_currentUser?.dataNascimento),
            style: TextStyle(
              color: Colors.purple[300],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações Pessoais',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 16),
            
            _buildInfoField(
              'Email',
              _currentUser?.email ?? '',
              _emailController,
              Icons.email,
              isEditing: _isEditing,
            ),
            
            _buildInfoField(
              'Telefone',
              _currentUser?.telefone ?? '',
              _telefoneController,
              Icons.phone,
              isEditing: _isEditing,
            ),
            
            _buildInfoField(
              'Gênero',
              _currentUser?.genero ?? '',
              null,
              Icons.person,
              isEditing: false,
            ),
            
            if (_currentUser?.bio?.isNotEmpty == true || _isEditing)
              _buildInfoField(
                'Bio',
                _currentUser?.bio ?? '',
                _bioController,
                Icons.description,
                isEditing: _isEditing,
                maxLines: 3,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferences() {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferências',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 16),
            
            if (_currentUser?.generosPreferidos.isNotEmpty == true)
              _buildChipSection('Gêneros Preferidos', _currentUser!.generosPreferidos),
            
            if (_currentUser?.autoresFavoritos.isNotEmpty == true)
              _buildChipSection('Autores Favoritos', _currentUser!.autoresFavoritos),
            
            if (_currentUser?.mangasFavoritos.isNotEmpty == true)
              _buildChipSection('Mangás Favoritos', _currentUser!.mangasFavoritos),
            
            if (_currentUser?.plataformasLeitura.isNotEmpty == true)
              _buildChipSection('Plataformas de Leitura', _currentUser!.plataformasLeitura),
            
            ListTile(
              leading: Icon(Icons.school, color: Colors.purple[300]),
              title: Text(
                'Nível de Experiência',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                _currentUser?.statusLeitura.capitalize ?? '',
                style: TextStyle(color: Colors.grey[400]),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notificações',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            SizedBox(height: 8),
            
            ListTile(
              leading: Icon(
                _currentUser?.notificacaoLancamentos == true 
                    ? Icons.notifications_active 
                    : Icons.notifications_off,
                color: _currentUser?.notificacaoLancamentos == true 
                    ? Colors.purple[300] 
                    : Colors.grey[400],
              ),
              title: Text(
                'Lançamentos',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                _currentUser?.notificacaoLancamentos == true 
                    ? 'Ativo' 
                    : 'Inativo',
                style: TextStyle(color: Colors.grey[400]),
              ),
              contentPadding: EdgeInsets.zero,
            ),
            
            ListTile(
              leading: Icon(
                _currentUser?.notificacaoRecomendacoes == true 
                    ? Icons.recommend 
                    : Icons.block,
                color: _currentUser?.notificacaoRecomendacoes == true 
                    ? Colors.purple[300] 
                    : Colors.grey[400],
              ),
              title: Text(
                'Recomendações',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                _currentUser?.notificacaoRecomendacoes == true 
                    ? 'Ativo' 
                    : 'Inativo',
                style: TextStyle(color: Colors.grey[400]),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(
    String label,
    String value,
    TextEditingController? controller,
    IconData icon, {
    bool isEditing = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.purple[300], size: 20),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          if (isEditing && controller != null)
            TextFormField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              maxLines: maxLines,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 28),
              child: Text(
                value.isNotEmpty ? value : 'Não informado',
                style: TextStyle(
                  color: value.isNotEmpty ? Colors.grey[300] : Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChipSection(String title, List<String> items) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: items.map((item) => Chip(
              label: Text(
                item,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              backgroundColor: Colors.purple[700],
            )).toList(),
          ),
        ],
      ),
    );
  }

  String _calculateAge(DateTime? birthDate) {
    if (birthDate == null) return 'Idade não informada';
    
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    
    return '$age anos';
  }
}

extension StringCapitalization on String {
  String get capitalize {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}