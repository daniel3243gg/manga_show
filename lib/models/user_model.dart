class UserModel {
  final String? id;
  final String nome;
  final String email;
  final String telefone;
  final DateTime dataNascimento;
  final String genero;
  final String bio;
  
  // Preferências de manga/anime
  final List<String> generosPreferidos;
  final List<String> mangasFavoritos;
  final List<String> animesFavoritos;
  final String tipoConteudoPreferido; // 'manga', 'anime', 'ambos'
  final String classificacaoEtariaPreferida;
  final bool notificacoesLancamentos;
  final bool notificacoesRecomendacoes;

  UserModel({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.dataNascimento,
    required this.genero,
    required this.bio,
    required this.generosPreferidos,
    required this.mangasFavoritos,
    required this.animesFavoritos,
    required this.tipoConteudoPreferido,
    required this.classificacaoEtariaPreferida,
    required this.notificacoesLancamentos,
    required this.notificacoesRecomendacoes,
  });

  // Converter para Map para armazenamento local
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'dataNascimento': dataNascimento.toIso8601String(),
      'genero': genero,
      'bio': bio,
      'generosPreferidos': generosPreferidos,
      'mangasFavoritos': mangasFavoritos,
      'animesFavoritos': animesFavoritos,
      'tipoConteudoPreferido': tipoConteudoPreferido,
      'classificacaoEtariaPreferida': classificacaoEtariaPreferida,
      'notificacoesLancamentos': notificacoesLancamentos,
      'notificacoesRecomendacoes': notificacoesRecomendacoes,
    };
  }

  // Criar do Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      dataNascimento: DateTime.parse(map['dataNascimento']),
      genero: map['genero'] ?? '',
      bio: map['bio'] ?? '',
      generosPreferidos: List<String>.from(map['generosPreferidos'] ?? []),
      mangasFavoritos: List<String>.from(map['mangasFavoritos'] ?? []),
      animesFavoritos: List<String>.from(map['animesFavoritos'] ?? []),
      tipoConteudoPreferido: map['tipoConteudoPreferido'] ?? '',
      classificacaoEtariaPreferida: map['classificacaoEtariaPreferida'] ?? '',
      notificacoesLancamentos: map['notificacoesLancamentos'] ?? false,
      notificacoesRecomendacoes: map['notificacoesRecomendacoes'] ?? false,
    );
  }
}