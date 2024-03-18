import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'models/modelPerfil.dart';
import 'models/modelteste.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  Future<List<UserData>> fetchUserData() async {
    // Simulando uma chamada assíncrona para buscar dados do usuário
    
    // Simula um atraso de 2 segundos
    List<UserData> userData = [];

    mangas.forEach((link) {
      UserData dado = UserData(link);
      userData.add(dado);
    });
    // Dados fictícios do usuário

    // Retornando os dados do usuário
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    PerfilModel perfil = PerfilModel();
    return Container(
        height: 300,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 200,
                  child: CircleAvatar(
                    radius: 100, // Metade da largura definida para o Container
                    child: ClipOval(
                        child: Image.network(perfil.link,
                            height: 200, fit: BoxFit.cover)),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(perfil.nome,
                          style: TextStyle(color: Colors.purple, fontSize: 25),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis),
                      Text(perfil.idade.toString() + ' Anos',
                          style: TextStyle(color: Colors.purple, fontSize: 20),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis),
                      Text(
                        perfil.desc,
                        style: TextStyle(color: Colors.purple, fontSize: 20),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Lendo...',
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
            ),const SizedBox(height: 20),
          Container(
            height: 200,
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
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        );
                      });
                }
              },
            ),
          )
          ],
        ));
  }
}
