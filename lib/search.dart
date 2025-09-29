import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = 'Todos';
  List<String> categories = ['Todos', 'Manga', 'Anime', 'Gêneros'];

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
              'Buscar',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'padrao',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Digite o nome do manga ou anime...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.purple),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purple),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.purple, width: 2),
                ),
              ),
              onChanged: (value) {
                // Implementar lógica de busca em tempo real
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            Text(
              'Filtrar por categoria:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      backgroundColor: Colors.grey[800],
                      selectedColor: Colors.purple.withOpacity(0.7),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[300],
                      ),
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Gêneros Populares:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _getPopularGenres().length,
                itemBuilder: (context, index) {
                  final genre = _getPopularGenres()[index];
                  return Card(
                    color: Colors.grey[900],
                    child: InkWell(
                      onTap: () {
                        // Implementar navegação para busca por gênero
                        _searchByGenre(genre);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: Text(
                          genre,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (searchController.text.isNotEmpty)
              Expanded(
                child: _buildSearchResults(),
              ),
          ],
        ),
      ),
    );
  }

  List<String> _getPopularGenres() {
    return [
      'Ação',
      'Romance',
      'Comédia',
      'Drama',
      'Fantasia',
      'Terror',
      'Slice of Life',
      'Sobrenatural',
      'Mistério',
      'Esportes',
      'Ficção Científica',
      'Aventura',
    ];
  }

  Widget _buildSearchResults() {
    // Simulação de resultados de busca
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resultados da busca:',
          style: TextStyle(
            color: Colors.purple,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Número simulado de resultados
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey[900],
                margin: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.image, color: Colors.purple),
                  ),
                  title: Text(
                    'Título ${index + 1}',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gênero: Ação, Aventura',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                        'Classificação: 16+',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple),
                  onTap: () {
                    // Implementar navegação para detalhes
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _searchByGenre(String genre) {
    searchController.text = genre;
    selectedCategory = 'Gêneros';
    setState(() {});
    // Implementar lógica de busca por gênero
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}