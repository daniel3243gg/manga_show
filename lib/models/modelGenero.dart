const List<Map<String,String>> generoPic = [
{'genero': 'Shounem', 'pic': 'https://t.ctcdn.com.br/68F2oiOaMIbOJ_A_Vl70effjBhY=/340x265:1654x1005/1200x675/smart/i521747.jpeg'},
{'genero': 'Shoujo', 'pic': 'https://cdn.ome.lt/XQbqwfqe3vc-rSn7VU62HCIKZTo=/1200x630/smart/extras/conteudos/shoujo-lista-capa.jpg'},
{'genero':'Kodom','pic':'https://static1.cbrimages.com/wordpress/wp-content/uploads/2022/03/Tai-Leads-The-First-Generation-Of-Digimon-And-Trainers-In-Digimon-Adventure.jpg'},
{'genero':'Seinen', 'pic':'https://animesalpha.com/wp-content/uploads/2023/03/animes-seinen.png'},
{'genero': 'josei', 'pic':'https://segredosdomundo.r7.com/wp-content/uploads/2021/05/josei-o-que-e-origem-caracteristicas-e-os-animes-mais-populares-da-categoria-1.jpg'},
{'genero': 'Mecha', 'pic': 'https://static0.gamerantimages.com/wordpress/wp-content/uploads/2023/10/the-best-mecha-anime-october-2023.jpg'}
];

class GeneroData {
  final String link;
  final String genero;

  GeneroData(this.link,this.genero);
}