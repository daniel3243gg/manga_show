import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manga_show/models/modelteste.dart';
import 'models/modelGenero.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String pesquisa = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          const SizedBox(height: 14),
          TextField(
            decoration: InputDecoration(
              hintText: 'Solo Leving...', // Texto de sugestão
              labelText: 'Pesquisa', // Rótulo do campo
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 87, 72, 90)), // Cor do texto de sugestão
              labelStyle: TextStyle(color: Colors.purple),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),

              // Borda ao redor do campo
            ),
            style: TextStyle(color: Color.fromARGB(255, 201, 87, 230)),
            onChanged: (text) {
              pesquisa = text;
              print(pesquisa);
            },
          ),
          const SizedBox(height: 20),
           Obx(
              () {
                if ("".obs == null || "".obs!.isEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: 10, // Substitua pelo número de itens do resultado da pesquisa
                      itemBuilder: (context, index) {
                        // Substitua isso pelo layout do item da lista
                        return ListTile(
                          title: Text('Item ${index + 1}'),
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text('Resultado da pesquisa: ${_searchController.text}'),
                    ),
                  );
                }
              },
            ),
          
        ],
      ),
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
