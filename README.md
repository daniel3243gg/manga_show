# MangaShow - Aplicativo Flutter

Um aplicativo Flutter para descobrir e acompanhar mangás e animes com sistema completo de cadastro de usuário e preferências personalizadas.

## 📱 Funcionalidades

### Sistema de Cadastro de Usuário
- **Cadastro Completo**: Formulário em 3 etapas (Stepper)
  - Informações pessoais (nome, email, telefone, data de nascimento, gênero, bio)
  - Preferências de conteúdo (gêneros, mangás/animes favoritos, classificação etária)
  - Confirmação e salvamento dos dados

### Características do Cadastro
- **Validação de formulários** com feedback visual
- **Seleção de preferências** por chips interativos
- **Lista de favoritos** com adição/remoção dinâmica
- **Configurações de notificações** personalizáveis
- **Persistência local** usando SharedPreferences
- **Interface responsiva** com tema dark personalizado

### Navegação e UI
- **Bottom Navigation** com 3 abas principais
- **Tema escuro** com destaque em roxo
- **Integração GetX** para gerenciamento de estado
- **Validações em tempo real** dos formulários

## 🚀 Como Usar

### Instalação
1. Certifique-se de ter o Flutter instalado
2. Execute `flutter pub get` para instalar as dependências
3. Execute `flutter run` para iniciar o aplicativo

### Usando o Cadastro de Usuário
1. Na aba **Home**, clique em "Complete seu Perfil"
2. Preencha as informações pessoais no primeiro step
3. Configure suas preferências de manga/anime no segundo step
4. Revise e confirme os dados no terceiro step
5. Seus dados são salvos automaticamente no dispositivo

### Acessando o Perfil
- Na aba **Perfil**, você pode visualizar todos os dados cadastrados
- Edite seu perfil clicando em "Editar Perfil"
- Exclua seus dados com "Excluir Perfil" (ação irreversível)

## 📂 Estrutura do Projeto

```
lib/
├── main.dart                     # Arquivo principal do app
├── home.dart                     # Tela inicial
├── search.dart                   # Tela de busca
├── perfil.dart                   # Tela de perfil do usuário
├── models/
│   └── user_model.dart           # Modelo de dados do usuário
├── controllers/
│   └── user_controller.dart      # Controlador GetX do usuário
├── services/
│   └── storage_service.dart      # Serviço de persistência local
└── screens/
    └── user_register_screen.dart # Tela de cadastro completo
```

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework UI
- **GetX**: Gerenciamento de estado e navegação
- **SharedPreferences**: Armazenamento local
- **Material Design**: Componentes de UI

## 🎨 Características de Design

- **Tema Dark**: Interface escura profissional
- **Cor primária**: Roxo (#Purple) para destaque
- **Componentes**: Cards, chips, steppers, formulários validados
- **Responsividade**: Layout adaptativo para diferentes tamanhos de tela

## 📋 Dados Coletados no Cadastro

### Informações Pessoais
- Nome completo
- E-mail
- Telefone
- Data de nascimento
- Gênero
- Biografia (opcional)

### Preferências de Conteúdo
- Tipo preferido (Manga, Anime ou Ambos)
- Gêneros favoritos (múltipla escolha)
- Lista de mangás favoritos
- Lista de animes favoritos
- Classificação etária preferida
- Configurações de notificações

## 🔧 Próximas Melhorias

- [ ] Integração com APIs de mangá/anime
- [ ] Sistema de recomendações baseado nas preferências
- [ ] Sincronização na nuvem
- [ ] Sistema de avaliações e reviews
- [ ] Notificações push para lançamentos

---

Desenvolvido com ❤️ usando Flutter