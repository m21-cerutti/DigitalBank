# GitHub Workflows

Ce dépôt contient un ensemble de workflows GitHub Actions organisés selon ../docs/Git_Flow.md.  
Pour une vision globale, voir le document ../docs/Pipeline.md.

---

## 📋 Liste des Workflows

| Fichier workflow         | Type             | Déclencheur (`on:`)                                                                 | Jobs inclus                                                                                                                                                           | Description |
|--------------------------|------------------|--------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| **guard.yml**            | Reusable         | `workflow_call`                                                                      | `branch_env`                                                                                                                                                           | Centralise et expose les variables d’environnement liées à la branche/PR pour les workflows appelants. |
| **feature-pr.yml**       | PR               | `pull_request` → branches: `develop` ; types: `opened`, `synchronize`, `reopened`    | `call-guard`, `is_feature_pr`, `feature_linter_check_pr`, `feature_secret_check_pr`, `feature_unit_tests_pr`, `feature_integration_tests_pr`                           | Contrôles PR pour les branches `feature/*` ciblant `develop`. |
| **bugfix-pr.yml**        | PR               | `pull_request` → branches: `release/*`, `develop` ; types: `opened`, `synchronize`, `reopened` | `call-guard`, `is_bugfix_pr`, `bugfix_linter_check_pr`, `bugfix_secret_check_pr`, `bugfix_unit_tests_pr`, `bugfix_integration_tests_pr`                                | Contrôles PR pour `bugfix/*` vers `develop` ou `release/*`. |
| **hotfix-pr.yml**        | PR               | `pull_request` → branches: `main`, `develop` ; types: `opened`, `synchronize`, `reopened` | `call-guard`, `is_hotfix_pr`, `hotfix_linter_check_pr`, `hotfix_secret_check_pr`, `hotfix_unit_tests_pr`, `hotfix_integration_tests_pr`                                | Contrôles PR pour `hotfix/*` vers `main` ou `develop`. |
| **release-pr.yml**       | PR               | `pull_request` → branches: `main` ; types: `opened`, `synchronize`, `reopened`       | `call-guard`, `is_release_pr`, `release_smoke_tests_pr`, `release_system_tests_pr`                                                                                    | Validation des PR `release/*` ciblant `main`. |
| **develop-push.yml**     | Push             | `push` → branches: `develop`                                                         | `dev_smoke_tests`, `dev_sanity_check`                                                                                                                                  | CI post-push sur `develop`. Concurrency: `cancel-in-progress: false`. |
| **develop-daily.yml**    | Schedule/Manuel  | `schedule`: cron `30 05 * * *` ; `workflow_dispatch`                                 | `checkout_develop`, `dev_integration_tests_api_daily`                                                                                                                  | Routine quotidienne (intégration API) sur `develop`. |
| **release-push.yml**     | Push             | `push` → branches: `release/*`                                                       | `release_smoke_tests_push`, `release_system_tests_push`, `release_e2e_tests_push`                                                                                      | Pipeline de vérification sur push `release/*`. Concurrency: `cancel-in-progress: false`. |
| **main-push.yml**        | Push             | `push` → branches: `main`                                                            | `main_sanity_check`                                                                                                                                                    | Contrôles post-merge/production sur `main`. Concurrency: `cancel-in-progress: false`. |

---

# 🧠 Détail des Jobs – Tableau d’explications

## Tableau des Jobs

| Job                                   | Présent dans                                                                                      | Type        | Description détaillée |
|---------------------------------------|----------------------------------------------------------------------------------------------------|-------------|-----------------------|
| **branch_env**                        | `guard.yml`                                                                                       | Reusable    | Collecte les variables du contexte (nom du dépôt, branche, commit) et calcule les flags `IS_FEATURE`, `IS_BUGFIX`, `IS_HOTFIX`, `IS_RELEASE`, `IS_DEVELOP`. Expose ces valeurs en outputs pour les workflows appelants. |
| **call-guard**                        | `feature-pr.yml`, `bugfix-pr.yml`, `hotfix-pr.yml`, `release-pr.yml`                              | Reusable    | Appelle `guard.yml` et rend disponibles ses outputs (`REPO`, `BRANCH`, `COMMIT`, `IS_*`) aux autres jobs du workflow. C’est toujours la 1ʳᵉ étape des workflows PR. |
| **is_feature_pr**                     | `feature-pr.yml`                                                                                   | PR          | Porte d’entrée conditionnelle des jobs PR features. S’exécute uniquement si `IS_FEATURE == 'true'`. |
| **feature_linter_check_pr**           | `feature-pr.yml`                                                                                   | PR          | Lint spécifique aux PR features. |
| **feature_secret_check_pr**           | `feature-pr.yml`                                                                                   | PR          | Vérification basique de secrets pour PR features. |
| **feature_unit_tests_pr**             | `feature-pr.yml`                                                                                   | PR          | Exécute les tests unitaires (features). Dépend des checks linter/secret. |
| **feature_integration_tests_pr**      | `feature-pr.yml`                                                                                   | PR          | Tests d’intégration (features) après les unitaires. |
| **is_bugfix_pr**                      | `bugfix-pr.yml`                                                                                    | PR          | Porte d’entrée conditionnelle des jobs PR bugfix. S’exécute uniquement si `IS_BUGFIX == 'true'`. |
| **bugfix_linter_check_pr**            | `bugfix-pr.yml`                                                                                    | PR          | Lint pour PR bugfix. |
| **bugfix_secret_check_pr**            | `bugfix-pr.yml`                                                                                    | PR          | Vérification de secrets pour PR bugfix. |
| **bugfix_unit_tests_pr**              | `bugfix-pr.yml`                                                                                    | PR          | Tests unitaires (bugfix). |
| **bugfix_integration_tests_pr**       | `bugfix-pr.yml`                                                                                    | PR          | Tests d’intégration (bugfix). |
| **is_hotfix_pr**                      | `hotfix-pr.yml`                                                                                    | PR          | Porte d’entrée conditionnelle des jobs PR hotfix. S’exécute uniquement si `IS_HOTFIX == 'true'`. |
| **hotfix_linter_check_pr**            | `hotfix-pr.yml`                                                                                    | PR          | Lint pour PR hotfix. |
| **hotfix_secret_check_pr**            | `hotfix-pr.yml`                                                                                    | PR          | Vérification de secrets pour PR hotfix. |
| **hotfix_unit_tests_pr**              | `hotfix-pr.yml`                                                                                    | PR          | Tests unitaires (hotfix). |
| **hotfix_integration_tests_pr**       | `hotfix-pr.yml`                                                                                    | PR          | Tests d’intégration (hotfix). |
| **is_release_pr**                     | `release-pr.yml`                                                                                   | PR          | Porte d’entrée conditionnelle des jobs PR release. S’exécute uniquement si `IS_RELEASE == 'true'`. |
| **release_smoke_tests_pr**            | `release-pr.yml`                                                                                   | PR          | Tests de fumée sur PR release. |
| **release_system_tests_pr**           | `release-pr.yml`                                                                                   | PR          | Tests système sur PR release. |
| **dev_smoke_tests**                   | `develop-push.yml`                                                                                 | Push        | Tests de fumée rapides sur `develop`. |
| **dev_sanity_check**                  | `develop-push.yml`                                                                                 | Push        | Sanity checks post-push sur `develop`. |
| **checkout_develop**                  | `develop-daily.yml`                                                                                | Schedule    | Récupération de la branche `develop` pour la routine quotidienne. |
| **dev_integration_tests_api_daily**   | `develop-daily.yml`                                                                                | Schedule    | Tests d’intégration API quotidiens sur `develop`. |
| **release_smoke_tests_push**          | `release-push.yml`                                                                                 | Push        | Tests de fumée lors d’un push `release/*`. |
| **release_system_tests_push**         | `release-push.yml`                                                                                 | Push        | Tests système (release push). |
| **release_e2e_tests_push**            | `release-push.yml`                                                                                 | Push        | Tests end-to-end après les tests de fumée (release push). |
| **main_sanity_check**                 | `main-push.yml`                                                                                    | Push        | Contrôles de cohérence sur `main` (post-merge/production). |

---

## Variables d’environnement exposées par `branch_env`

| Variable       | Description                                   |
|----------------|-----------------------------------------------|
| `REPO`         | Nom du dépôt                                  |
| `BRANCH`       | Branche source (PR) / branche courante        |
| `COMMIT`       | SHA du commit courant                         |
| `IS_FEATURE`   | `true` si la branche source = `feature/*`     |
| `IS_BUGFIX`    | `true` si la branche source = `bugfix/*`      |
| `IS_HOTFIX`    | `true` si la branche source = `hotfix/*`      |
| `IS_RELEASE`   | `true` si la branche source = `release/*`     |
| `IS_DEVELOP`   | `true` si la branche source = `develop`       |

---

### Exemple d’utilisation d’un job PR

```yaml
jobs:
  call-guard:
    uses: ./.github/workflows/guard.yml
    with:
       environment:  feature
       deployment: false

  is_feature_pr:
    needs: call-guard
    if: needs.call-guard.outputs.IS_FEATURE == 'true'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Running PR workflow for feature/*"
```
