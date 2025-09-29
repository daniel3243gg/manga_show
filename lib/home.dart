import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/user_register_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao MangaShow!',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'padrao',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Descubra novos mangás e animes incríveis!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 30),
            Card(
              color: Colors.grey[900],
              child: ListTile(
                leading: Icon(Icons.person_add, color: Colors.purple),
                title: Text(
                  'Complete seu Perfil',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Cadastre suas preferências para receber recomendações personalizadas',
                  style: TextStyle(color: Colors.grey[400]),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple),
                onTap: () {
                  Get.to(() => UserRegisterScreen());
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Recursos Principais:',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildFeatureCard(
                    Icons.search,
                    'Busca Avançada',
                    'Encontre mangás e animes por gênero, classificação etária e muito mais',
                  ),
                  _buildFeatureCard(
                    Icons.bookmark,
                    'Lista de Favoritos',
                    'Salve seus mangás e animes favoritos em uma lista personalizada',
                  ),
                  _buildFeatureCard(
                    Icons.notifications,
                    'Notificações',
                    'Receba alertas sobre novos lançamentos e recomendações',
                  ),
                  _buildFeatureCard(
                    Icons.person,
                    'Perfil Personalizado',
                    'Configure suas preferências e acompanhe seu progresso',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple, size: 30),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}