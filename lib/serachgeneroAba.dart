import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:manga_show/models/modelteste.dart';
import 'models/modelGenero.dart';

class AbaGenero extends StatelessWidget {
  const AbaGenero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fetchGeneroData(),
          builder: (context, AsyncSnapshot<List<GeneroData>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Exibe um indicador de carregamento enquanto aguarda
            } else if (snapshot.hasError) {
              return Text(
                  'Erro ao carregar dados: ${snapshot.error}'); // Exibe mensagem de erro se houver algum erro
            } else {
              return SizedBox(
                height: 450, // Defina a altura desejada aqui
                child: ListView.builder(
                  itemCount: (snapshot.data?.length ?? 0) ~/ 2,
                  itemBuilder: (context, cont) {
                    int currentIndex = cont * 2;
                    int nextIndex = currentIndex + 1;
                    String image = snapshot.data?[currentIndex].link ?? '';
                    String genero = snapshot.data?[currentIndex].genero ?? '';
                    String image2 = snapshot.data?[nextIndex].link ?? '';
                    String genero2 = snapshot.data?[nextIndex].genero ?? '';

                    return Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width:
                                190, // Define a largura desejada do container
                            height:
                                190, // Define a altura desejada do container
                            child: Stack(
                              alignment: Alignment
                                  .center, // Alinha os widgets no centro da stack
                              children: [
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(
                                        0.5), // Define o nível de opacidade da cor preta (0.5 é metade da opacidade)
                                    BlendMode
                                        .srcATop, // Define o modo de mesclagem para escurecer a imagem
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      image,
                                      width: 200, // Largura da imagem
                                      height: 200, // Altura da imagem
                                      fit: BoxFit
                                          .cover, // Ajusta a imagem para cobrir o widget
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom:
                                      50, // Define a distância do texto em relação ao final da imagem
                                  child: Text(
                                    genero,
                                    style: TextStyle(
                                      color: Color.fromARGB(
                                          255, 142, 51, 179), // Cor do texto
                                      fontSize: 50, // Tamanho do texto
                                      fontWeight: FontWeight.bold,
                                      // Estilo de fonte
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            width:
                                190, // Define a largura desejada do container
                            height:
                                190, // Define a altura desejada do container
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              alignment: Alignment
                                  .center, // Alinha os widgets no centro da stack
                              children: [
                                ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(
                                        0.5), // Define o nível de opacidade da cor preta (0.5 é metade da opacidade)
                                    BlendMode
                                        .srcATop, // Define o modo de mesclagem para escurecer a imagem
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      image2,
                                      width: 200, // Largura da imagem
                                      height: 200, // Altura da imagem
                                      fit: BoxFit
                                          .cover, // Ajusta a imagem para cobrir o widget
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom:
                                      50, // Define a distância do texto em relação ao final da imagem
                                  child: Text(
                                    genero2,
                                    style: TextStyle(
                                      color: Color.fromARGB(
                                          255, 129, 49, 175), // Cor do texto
                                      fontSize: 50, // Tamanho do texto
                                      fontWeight:
                                          FontWeight.bold, // Estilo de fonte
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }

  Future<List<GeneroData>> fetchGeneroData() async {
    // Simulando uma chamada assíncrona para buscar dados do usuário
    List<GeneroData> generoDataL = [];

    generoPic.forEach((mapG) {
      String genero = mapG['genero'] ?? '';
      String pic = mapG['pic'] ?? '';
      GeneroData dado = GeneroData(pic, genero);
      generoDataL.add(dado);
    });
    // Dados fictícios do usuário
    // Retornando os dados do usuário
    return generoDataL;
  }
}
