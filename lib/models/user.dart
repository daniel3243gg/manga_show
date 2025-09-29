class User {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final DateTime dataNascimento;
  final String genero;
  final String bio;
  
  // Gostos e preferências
  final List<String> generosPreferidos;
  final List<String> autoresFavoritos;
  final List<String> mangasFavoritos;
  final String statusLeitura; // 'iniciante', 'intermediario', 'avancado', 'expert'
  final List<String> plataformasLeitura;
  final bool notificacaoLancamentos;
  final bool notificacaoRecomendacoes;
  
  User({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.dataNascimento,
    required this.genero,
    this.bio = '',
    this.generosPreferidos = const [],
    this.autoresFavoritos = const [],
    this.mangasFavoritos = const [],
    this.statusLeitura = 'iniciante',
    this.plataformasLeitura = const [],
    this.notificacaoLancamentos = true,
    this.notificacaoRecomendacoes = true,
  });

  User copyWith({
    String? id,
    String? nome,
    String? email,
    String? telefone,
    DateTime? dataNascimento,
    String? genero,
    String? bio,
    List<String>? generosPreferidos,
    List<String>? autoresFavoritos,
    List<String>? mangasFavoritos,
    String? statusLeitura,
    List<String>? plataformasLeitura,
    bool? notificacaoLancamentos,
    bool? notificacaoRecomendacoes,
  }) {
    return User(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      genero: genero ?? this.genero,
      bio: bio ?? this.bio,
      generosPreferidos: generosPreferidos ?? this.generosPreferidos,
      autoresFavoritos: autoresFavoritos ?? this.autoresFavoritos,
      mangasFavoritos: mangasFavoritos ?? this.mangasFavoritos,
      statusLeitura: statusLeitura ?? this.statusLeitura,
      plataformasLeitura: plataformasLeitura ?? this.plataformasLeitura,
      notificacaoLancamentos: notificacaoLancamentos ?? this.notificacaoLancamentos,
      notificacaoRecomendacoes: notificacaoRecomendacoes ?? this.notificacaoRecomendacoes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'dataNascimento': dataNascimento.toIso8601String(),
      'genero': genero,
      'bio': bio,
      'generosPreferidos': generosPreferidos,
      'autoresFavoritos': autoresFavoritos,
      'mangasFavoritos': mangasFavoritos,
      'statusLeitura': statusLeitura,
      'plataformasLeitura': plataformasLeitura,
      'notificacaoLancamentos': notificacaoLancamentos,
      'notificacaoRecomendacoes': notificacaoRecomendacoes,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      dataNascimento: DateTime.parse(json['dataNascimento']),
      genero: json['genero'],
      bio: json['bio'] ?? '',
      generosPreferidos: List<String>.from(json['generosPreferidos'] ?? []),
      autoresFavoritos: List<String>.from(json['autoresFavoritos'] ?? []),
      mangasFavoritos: List<String>.from(json['mangasFavoritos'] ?? []),
      statusLeitura: json['statusLeitura'] ?? 'iniciante',
      plataformasLeitura: List<String>.from(json['plataformasLeitura'] ?? []),
      notificacaoLancamentos: json['notificacaoLancamentos'] ?? true,
      notificacaoRecomendacoes: json['notificacaoRecomendacoes'] ?? true,
    );
  }
}