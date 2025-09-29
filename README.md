# MangaShow - Sistema de Cadastro de Usuário

Este aplicativo Flutter agora conta com um sistema completo de cadastro de usuário, incluindo preferências personalizadas para mangás.

## 🎯 Funcionalidades do Sistema de Usuário

### ✨ Cadastro Completo
- **Informações Pessoais**: Nome, email, telefone, data de nascimento, gênero e biografia
- **Preferências de Leitura**: Gêneros favoritos, autores preferidos, mangás favoritos
- **Nível de Experiência**: Iniciante, intermediário, avançado ou expert
- **Plataformas de Leitura**: Onde o usuário costuma ler mangás
- **Configurações de Notificação**: Lançamentos e recomendações personalizadas

### 🎨 Interface de Usuário
- **Design Dark Theme**: Interface escura com acentos em roxo
- **Formulário Multi-Etapas**: Processo de cadastro dividido em etapas para melhor experiência
- **Validações**: Validação completa de email, telefone e idade mínima
- **Progress Indicator**: Indicador visual de progresso durante o cadastro
- **Cards Interativos**: Seleção múltipla com chips para preferências

### 📱 Telas Implementadas

#### 1. Tela de Cadastro (`UserRegistrationScreen`)
- **Etapa 1**: Informações pessoais básicas
- **Etapa 2**: Preferências e gostos de leitura
- **Etapa 3**: Confirmação dos dados inseridos
- Navegação fluida entre etapas com animações

#### 2. Tela de Perfil (`UserProfileScreen`)
- **Visualização**: Perfil completo com avatar personalizado
- **Edição**: Modo de edição inline para informações básicas
- **Cards Organizados**: Informações divididas em seções lógicas
- **Status Visual**: Indicadores de notificações e preferências

### 🏗️ Arquitetura

#### Padrão GetX
- **Controllers**: `UserController` para gerenciamento de estado
- **Services**: `UserService` para lógica de negócio e persistência
- **Models**: `User` com campos completos e serialização JSON

#### Persistência Local
- **SharedPreferences**: Armazenamento local dos dados do usuário
- **Validações**: Métodos de validação para email, telefone e idade
- **Backup**: Sistema de cópia e atualização de perfil

### 🔧 Como Usar

#### Instalação
1. Execute `flutter pub get` para instalar as dependências
2. Execute `flutter run` para iniciar o aplicativo

#### Navegação
- **Ícone de Perfil** (Header): Acessa o perfil do usuário atual
- **Tab Perfil** (Bottom Navigation): Terceira aba para visualização do perfil
- **Cadastro Automático**: Redirecionamento para cadastro se não houver usuário

#### Fluxo de Uso
1. **Primeiro Acesso**: Sistema detecta ausência de usuário e oferece cadastro
2. **Cadastro**: Processo guiado em 3 etapas com validações
3. **Perfil**: Visualização completa com opção de edição
4. **Edição**: Modo inline para alterações rápidas

### 📋 Campos do Usuário

#### Informações Básicas
- Nome completo (obrigatório)
- Email (obrigatório, com validação)
- Telefone (obrigatório, com máscara)
- Data de nascimento (obrigatório, idade mínima 13 anos)
- Gênero (seleção obrigatória)
- Biografia (opcional, até 200 caracteres)

#### Preferências de Mangá
- **Gêneros Preferidos**: Lista com 23+ gêneros disponíveis
- **Autores Favoritos**: Campo de entrada livre para múltiplos autores
- **Mangás Favoritos**: Lista personalizada de títulos favoritos
- **Nível de Experiência**: 4 opções de classificação
- **Plataformas**: 12+ plataformas populares de leitura

#### Configurações
- **Notificações de Lançamentos**: Toggle para novos capítulos
- **Recomendações Personalizadas**: Sistema baseado em preferências

### 🎨 Personalizações Visuais

#### Tema Dark
- Fundo preto (`Colors.black`)
- Acentos em roxo (`Colors.purple`)
- Cards em cinza escuro (`Colors.grey[900]`)
- Texto em branco e cinza claro

#### Componentes Customizados
- **Multi-Select Lists**: Seleção múltipla com checkboxes
- **Chip Tags**: Tags removíveis para preferências
- **Progress Indicators**: Barras de progresso com cores temáticas
- **Avatar Circular**: Inicial do nome em avatar colorido

### 🚀 Próximos Passos

Este sistema de usuário serve como base para:
- Sistema de recomendações personalizadas
- Histórico de leitura
- Listas personalizadas (favoritos, lendo, quero ler)
- Sistema de reviews e avaliações
- Sincronização entre dispositivos
- Sistema social (seguir outros usuários)

### 🛠️ Dependências Principais
- `get: ^4.6.6` - Gerenciamento de estado e navegação
- `shared_preferences: ^2.2.2` - Persistência local de dados
- `flutter/material.dart` - Componentes de UI

---

**Desenvolvido com Flutter + GetX para uma experiência de usuário fluida e moderna!** 🎌