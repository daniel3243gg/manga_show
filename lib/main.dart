import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'search.dart';
import 'perfil.dart';

void main() {
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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MangaShow'),
          titleTextStyle: TextStyle(
              color: Colors.purple, fontSize: 25, fontFamily: 'padrao'),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark), // Ícone do botão
              onPressed: () {
                // Ação ao pressionar o botão
                print('Botão pressionado!');
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
                Perfil()
              ],
            )),
        backgroundColor: Colors.black,
      ),
    );
  }
}
