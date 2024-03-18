import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:manga_show/models/modelteste.dart';
import 'models/modelGenero.dart';
import 'serachgeneroAba.dart';

class SerachGet extends GetxController {
  // Variável observável para armazenar o texto de pesquisa
  var pesquisa = ''.obs;

  // Função para atualizar o texto de pesquisa
  void updatePesquisa(String query) {
    pesquisa.value = query;
  }

  String getResultados() {
    return 'ocorreu';
  }
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SerachGet searchController = Get.put(SerachGet());
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
                  color: Color.fromARGB(
                      255, 87, 72, 90)), // Cor do texto de sugestão
              labelStyle: TextStyle(color: Colors.purple),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),

              // Borda ao redor do campo
            ),
            style: TextStyle(color: Color.fromARGB(255, 201, 87, 230)),
            onChanged: (text) {
              searchController.updatePesquisa(text);
            },
          ),
          const SizedBox(height: 20),
          Obx(
            () {
              if (searchController.pesquisa.value.isEmpty) {
                return AbaGenero();
              } else {
                return Expanded(
                  child: Center(
                    child: Text(
                        'Resultado da pesquisa: ${searchController.getResultados()}'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
