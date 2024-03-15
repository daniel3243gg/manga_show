import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manga_show/models/modelteste.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

Future<List<UserData>> fetchUserData() async {
  // Simulando uma chamada assíncrona para buscar dados do usuário
  await Future.delayed(Duration(seconds: 3)); // Simula um atraso de 2 segundos
  List<UserData> userData = [];

  mangas.forEach((link) {
    UserData dado = UserData(link);
    userData.add(dado);
  });
  // Dados fictícios do usuário

  // Retornando os dados do usuário
  return userData;
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Principais escolhas',
                  style: TextStyle(color: Colors.purple, fontSize: 20),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5, // Defina a altura desejada para a linha
            color: const Color.fromARGB(255, 195, 146,
                204), // Defina a cor da linha conforme necessário
            indent: 0, // Define a margem à esquerda da linha
            endIndent: 200, // Define a margem à direita da linha
          ),
          SizedBox(height: 10),
          Container(
            height: 250,
            margin: EdgeInsets.only(left: 0),
            child: FutureBuilder(
              future: fetchUserData(),
              builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Exibe um indicador de carregamento enquanto aguarda
                } else if (snapshot.hasError) {
                  return Text(
                      'Erro ao carregar dados: ${snapshot.error}'); // Exibe mensagem de erro se houver algum erro
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, cont) {
                        String image = snapshot.data?[cont].link ?? '';
                        return Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Image.network(
                            image,
                            height: 250,
                            fit: BoxFit.fill,
                          ),
                        );
                      });
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Continue lendo',
                  style: TextStyle(color: Colors.purple, fontSize: 20),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5, // Defina a altura desejada para a linha
            color: const Color.fromARGB(255, 195, 146,
                204), // Defina a cor da linha conforme necessário
            indent: 0, // Define a margem à esquerda da linha
            endIndent: 200, // Define a margem à direita da linha
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: FutureBuilder(
              future: fetchUserData(),
              builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Exibe um indicador de carregamento enquanto aguarda
                } else if (snapshot.hasError) {
                  return Text(
                      'Erro ao carregar dados: ${snapshot.error}'); // Exibe mensagem de erro se houver algum erro
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, cont) {
                        String image = snapshot.data?[cont].link ?? '';
                        return Container(
                          height: 150,
                          margin: EdgeInsets.only(left: 10),
                          child: Image.network(
                            image,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        );
                      });
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Lançamentos',
                  style: TextStyle(color: Colors.purple, fontSize: 20),
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5, // Defina a altura desejada para a linha
            color: const Color.fromARGB(255, 195, 146,
                204), // Defina a cor da linha conforme necessário
            indent: 0, // Define a margem à esquerda da linha
            endIndent: 200, // Define a margem à direita da linha
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            child: FutureBuilder(
              future: fetchUserData(),
              builder: (context, AsyncSnapshot<List<UserData>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Exibe um indicador de carregamento enquanto aguarda
                } else if (snapshot.hasError) {
                  return Text(
                      'Erro ao carregar dados: ${snapshot.error}'); // Exibe mensagem de erro se houver algum erro
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, cont) {
                        String image = snapshot.data?[cont].link ?? '';
                        return Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Image.network(
                            image,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        );
                      });
                }
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
