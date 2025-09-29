import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/user_controller.dart';
import 'services/user_service.dart';
import 'screens/user_registration_screen.dart';
import 'screens/user_profile_screen.dart';

void main() {
  // Inicializar dependências
  Get.put(UserService());
  Get.put(UserController());
  
  runApp(MangaShow());
}

class MangaShow extends StatefulWidget {
  const MangaShow({super.key});

  @override
  State<MangaShow> createState() => _MangaShowState();
}

class _MangaShowState extends State<MangaShow> {
  int pagina = 0;
  late PageController pageController;

  void initState() {
    super.initState();
    pageController = PageController(initialPage: pagina);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Padrao', // Definindo a fonte padrão para todo o aplicativo
      ),
      // Definir rotas nomeadas
      getPages: [
        GetPage(name: '/home', page: () => MainScreen()),
        GetPage(name: '/register', page: () => UserRegistrationScreen()),
        GetPage(name: '/profile', page: () => UserProfileScreen()),
      ],
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pagina = 0;
  late PageController pageController;

  void initState() {
    super.initState();
    pageController = PageController(initialPage: pagina);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MangaShow'),
        titleTextStyle: TextStyle(
            color: Colors.purple, fontSize: 25, fontFamily: 'padrao'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.purple), // Mudou para ícone de pessoa
            onPressed: () {
              // Navega para o perfil do usuário
              Get.to(() => UserProfileScreen());
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this.pagina,
        onTap: (opc) {
          print(opc);
          setState(() {
            pagina = opc;
            pageController.animateToPage(
              pagina,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        fixedColor: Colors.purple,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.purple[300],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(5.0),
          child: PageView(
            controller: pageController,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                pagina = index;
              });
            },
            children: [
              Home(),
              Search(),
              UserProfileScreen(), // Terceira tela agora é o perfil do usuário
            ],
          )),
      backgroundColor: Colors.black,
    );
  }
}

// Telas básicas (você pode substituir pelo conteúdo real)
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 80,
            color: Colors.purple[300],
          ),
          SizedBox(height: 16),
          Text(
            'Home - Lista de Mangás',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'padrao',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Aqui você encontrará os mangás em destaque',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.purple[300],
          ),
          SizedBox(height: 16),
          Text(
            'Buscar Mangás',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'padrao',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Encontre seus mangás favoritos',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Digite o nome do mangá...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.purple[300]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}