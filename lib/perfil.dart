import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/user_controller.dart';
import 'screens/user_register_screen.dart';
import 'services/storage_service.dart';

class Perfil extends StatefulWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final StorageService _storageService = StorageService();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final data = await _storageService.getUserData();
      setState(() {
        userData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: _loadUserData,
        color: Colors.purple,
        backgroundColor: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.purple))
            : userData == null
              ? _buildEmptyProfile()
              : _buildUserProfile(),
        ),
      ),
    );
  }

  Widget _buildEmptyProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person_outline,
          size: 100,
          color: Colors.purple.withOpacity(0.5),
        ),
        SizedBox(height: 20),
        Text(
          'Nenhum perfil encontrado',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Complete seu cadastro para personalizar sua experiência no MangaShow',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {
            Get.to(() => UserRegisterScreen())?.then((_) {
              _loadUserData();
            });
          },
          icon: Icon(Icons.person_add, color: Colors.white),
          label: Text('Criar Perfil', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfile() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header do perfil
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.purple.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: Colors.purple),
                ),
                SizedBox(height: 15),
                Text(
                  userData!['nome'] ?? 'Usuário',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (userData!['bio']?.isNotEmpty == true)
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      userData!['bio'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Informações pessoais
          _buildSectionTitle('Informações Pessoais'),
          _buildInfoCard(Icons.email, 'E-mail', userData!['email'] ?? 'Não informado'),
          _buildInfoCard(Icons.phone, 'Telefone', userData!['telefone'] ?? 'Não informado'),
          _buildInfoCard(Icons.cake, 'Data de Nascimento', _formatDate(userData!['dataNascimento'])),
          _buildInfoCard(Icons.person, 'Gênero', userData!['genero'] ?? 'Não informado'),
          
          SizedBox(height: 20),

          // Preferências
          _buildSectionTitle('Preferências'),
          _buildInfoCard(
            Icons.category, 
            'Tipo de Conteúdo', 
            _formatContentType(userData!['tipoConteudoPreferido'])
          ),
          _buildInfoCard(
            Icons.star, 
            'Classificação Preferida', 
            userData!['classificacaoEtariaPreferida'] ?? 'Não informado'
          ),

          if (userData!['generosPreferidos']?.isNotEmpty == true) ...[
            SizedBox(height: 10),
            _buildChipSection('Gêneros Preferidos', userData!['generosPreferidos']),
          ],

          if (userData!['mangasFavoritos']?.isNotEmpty == true) ...[
            SizedBox(height: 10),
            _buildChipSection('Mangás Favoritos', userData!['mangasFavoritos']),
          ],

          if (userData!['animesFavoritos']?.isNotEmpty == true) ...[
            SizedBox(height: 10),
            _buildChipSection('Animes Favoritos', userData!['animesFavoritos']),
          ],

          SizedBox(height: 20),

          // Configurações
          _buildSectionTitle('Configurações'),
          _buildSwitchCard(
            Icons.notifications,
            'Notificações de Lançamentos',
            userData!['notificacoesLancamentos'] ?? false,
          ),
          _buildSwitchCard(
            Icons.recommend,
            'Notificações de Recomendações',
            userData!['notificacoesRecomendacoes'] ?? false,
          ),

          SizedBox(height: 30),

          // Botões de ação
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => UserRegisterScreen())?.then((_) {
                      _loadUserData();
                    });
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text('Editar Perfil', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showDeleteDialog,
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text('Excluir Perfil', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.purple,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple),
        title: Text(label, style: TextStyle(color: Colors.grey[400])),
        subtitle: Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSwitchCard(IconData icon, String label, bool value) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.only(bottom: 10),
      child: SwitchListTile(
        secondary: Icon(icon, color: Colors.purple),
        title: Text(label, style: TextStyle(color: Colors.white)),
        value: value,
        activeColor: Colors.purple,
        onChanged: (newValue) {
          // Implementar atualização das configurações
        },
      ),
    );
  }

  Widget _buildChipSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.purple,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: items.map((item) => Chip(
            label: Text(item.toString()),
            backgroundColor: Colors.purple.withOpacity(0.7),
            labelStyle: TextStyle(color: Colors.white),
          )).toList(),
        ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'Não informado';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return 'Data inválida';
    }
  }

  String _formatContentType(String? type) {
    switch (type) {
      case 'manga':
        return 'Manga';
      case 'anime':
        return 'Anime';
      case 'ambos':
        return 'Ambos';
      default:
        return 'Não informado';
    }
  }

  void _showDeleteDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Excluir Perfil', style: TextStyle(color: Colors.white)),
        content: Text(
          'Tem certeza que deseja excluir seu perfil? Esta ação não pode ser desfeita.',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancelar', style: TextStyle(color: Colors.purple)),
          ),
          ElevatedButton(
            onPressed: () async {
              await _storageService.clearUserData();
              Get.back();
              setState(() {
                userData = null;
              });
              Get.snackbar(
                'Sucesso',
                'Perfil excluído com sucesso',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Excluir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}