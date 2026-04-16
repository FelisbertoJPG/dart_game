# Proposta de Commits - DashLingo

Abaixo estão os commits propostos seguindo o padrão **Conventional Commits**. Como o repositório foi iniciado agora, poderei fazer esses commits de forma atômica para manter o histórico limpo e profissional.

### Instruções:
- Se concordar, responda com "Aprovado".
- Se quiser mudar alguma mensagem ou agrupar algo, descreva abaixo.

---

| Tipo | Mensagem | Arquivos Principais |
| :--- | :--- | :--- |
| **chore** | initialize flutter project and documentation structure | `pubspec.yaml`, `docs/history/initial_design_plan.md` |
| **feat** | implement core design system and application theme | `lib/core/theme.dart` |
| **feat** | define domain models for curriculum and quizzes | `lib/features/modules/domain/models.dart` |
| **feat** | setup global state management with riverpod (progress, xp, hearts) | `lib/features/profile/domain/progress_provider.dart` |
| **feat** | implement module path screen with zigzag navigation | `lib/features/modules/presentation/module_path_screen.dart` |
| **feat** | implement interactive quiz engine and UI components | `lib/features/quiz/presentation/quiz_screen.dart` |
| **refactor** | standardize all imports to package-based absolute paths | Vários arquivos em `lib/` |
| **feat** | expand curriculum logic and implement question repetition system | `lib/features/modules/domain/curriculum_data.dart`, `quiz_provider.dart` |
| **fix** | resolve syntax error in curriculum string interpolation | `lib/features/modules/domain/curriculum_data.dart` |
| **fix** | correct typo in add() quiz question validation | `lib/features/modules/domain/curriculum_data.dart` |
| **chore** | add dev logs for project phase 1 and 2 | `docs/history/dev_log_*.md` |

---

> [!NOTE]
> Como o Git foi inicializado agora, esses commits serão feitos em sequência (um após o outro) para que o histórico mostre a evolução lógica do projeto, mesmo que todos os arquivos já existam fisicamente.
