# 📜 Regras de Desenvolvimento - DashLingo

Este documento define as diretrizes e padrões de qualidade que regem o desenvolvimento do DashLingo. Estas regras devem ser seguidas rigorosamente em cada iteração.

## 1. Documentação e Histórico
- **Dev Logs**: Toda funcionalidade concluída deve ser documentada em um novo arquivo `docs/history/dev_log_XX_nome.md`.
- **Relatório de Commits**: Antes de realizar grandes commits, uma proposta detalhada deve ser apresentada ao usuário.

## 2. Padrão de Commits
- **Conventional Commits**: Usar estritamente os prefixos `feat:`, `fix:`, `refactor:`, `chore:`, `docs:`.
- **Atomicidade**: Commits devem ser granulares e separados por lógica/funcionalidade, nunca um "init commit" gigante com tudo dentro.

## 3. Automação e Validação
- **Compilação Contínua**: Sempre que uma feature for finalizada, o app deve ser compilado e executado no dispositivo conectado (`flutter run`).
- **Análise Estática**: Rodar `flutter analyze` frequentemente para garantir que não existam erros de lint ou membros depreciados.

## 4. Design e UX "Premium"
- **Estética Vibrante**: Cores harmoniosas, gradientes suaves e tipografia moderna (Outfit).
- **Imersão**: Uso de navegação moderna (ex: slides verticais estilo TikTok para lições).
- **Responsividade**: Todo conteúdo deve ser envolto em containers roláveis (`SingleChildScrollView`, `ListView`) para evitar o erro de "Pixel Overflow" em qualquer tamanho de tela.

## 5. Pedagogia de Aprendizado
- **Feedback Educativo**: Questões erradas devem mostrar uma explicação clara do "Porquê".
- **Repetição Inteligente**: Questões erradas são movidas para o final da fila do quiz até que o usuário as acerte.
- **Teoria sem Spoiler**: As lições devem ensinar o conceito base sem dar a resposta exata das questões do quiz.

## 6. Arquitetura Técnica
- **State Management**: Uso de **Riverpod** para estados globais e lógica de sessão.
- **Imports Absolutos**: Sempre usar o caminho completo do pacote (`package:dash_lingo/...`) para evitar ambiguidades.
