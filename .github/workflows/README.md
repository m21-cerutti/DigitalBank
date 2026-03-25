# GitHub Workflows

Ce dépôt contient un ensemble de workflows GitHub Actions organisés selon ../docs/Git_Flow.md.  
Pour une vision globale, voir le document ../docs/Pipeline.md.

---

## Liste des Workflows

| Fichier workflow      | Type            | Déclencheur (`on:`)                     | Jobs inclus                                                                                                                                  | Description                                                                      |
| --------------------- | --------------- | --------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| **guard.yml**         | Reusable        | `workflow_call`                         | `branch_env`                                                                                                                                 | Centralise les variables d’environnement et expose les flags de type de branche. |
| **feature-pr.yml**    | PR              | `pull_request` → `develop`              | `call-guard`, `is_feature_pr`, `feature_linter_check_pr`, `feature_secret_check_pr`, `feature_unit_tests_pr`, `feature_integration_tests_pr` | Pipeline PR pour `feature/*`.                                                    |
| **bugfix-pr.yml**     | PR              | `pull_request` → `develop`, `release/*` | `call-guard`, `is_bugfix_pr`, `bugfix_linter_check_pr`, `bugfix_secret_check_pr`, `bugfix_unit_tests_pr`, `bugfix_integration_tests_pr`      | Pipeline PR pour `bugfix/*`.                                                     |
| **hotfix-pr.yml**     | PR              | `pull_request` → `main`, `develop`      | `call-guard`, `is_hotfix_pr`, `hotfix_linter_check_pr`, `hotfix_secret_check_pr`, `hotfix_unit_tests_pr`, `hotfix_integration_tests_pr`      | Pipeline PR pour `hotfix/*`.                                                     |
| **release-pr.yml**    | PR              | `pull_request` → `main`                 | `call-guard`, `is_release_pr`, `release_smoke_tests_pr`, `release_system_tests_pr`                                                           | Validation finale avant merge production.                                        |
| **develop-push.yml**  | Push            | `push` → `develop`                      | `dev_smoke_tests`, `dev_sanity_check`                                                                                                        | CI continue sur branche d’intégration.                                           |
| **develop-daily.yml** | Schedule/Manual | `cron` + `workflow_dispatch`            | `checkout_develop`, `dev_integration_tests_api_daily`                                                                                        | Tests API quotidiens.                                                            |
| **release-push.yml**  | Push            | `push` → `release/*`                    | `release_smoke_tests_push`, `release_system_tests_push`, `release_e2e_tests_push`                                                            | Validation complète avant production.                                            |
| **main-push.yml**     | Push            | `push` → `main`                         | `main_sanity_check`                                                                                                                          | Vérification post-déploiement.                                                   |

---

## Liste des Jobs

| Job                                           | Type     | Description                                           |
| --------------------------------------------- | -------- | ----------------------------------------------------- |
| **branch_env**                                | Reusable | Expose les variables de contexte et flags de branche. |
| **is_feature_pr / bugfix / hotfix / release** | PR       | Filtrage conditionnel des workflows.                  |
| **linter_check**                              | PR       | Vérification qualité du code via action composite.    |
| **secret_check**                              | PR       | Scan sécurité basique.                                |
| **unit_tests**                                | PR       | Validation logique applicative.                       |
| **integration_tests**                         | PR       | Validation des échanges inter-services.               |
| **smoke_tests**                               | Push/PR  | Validation rapide du build.                           |
| **system_tests**                              | Push     | Validation fonctionnelle globale.                     |
| **e2e_tests**                                 | Push     | Validation des parcours utilisateurs critiques.       |
| **sanity_check**                              | Push     | Vérification rapide post-déploiement.                 |

---

## Liste des Actions composites

Le projet utilise des actions composites pour factoriser les comportements communs et éviter la duplication dans les workflows.

| Action composite   | Emplacement                      | Description                                                                                                                             |
| ------------------ | -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **setup-node**     | `.github/actions/setup-node`     | Configure l’environnement Node.js (version, cache npm, installation des dépendances) afin de garantir une exécution cohérente des jobs. |
| **setup-selenium** | `.github/actions/setup-selenium` | Initialise l’environnement Selenium (python, driver, navigateur, configuration headless) nécessaire à l’exécution des tests E2E.        |
| **run-npm-cmd**    | `.github/actions/run-npm-cmd`    | Exécute une commande `npm` paramétrable (tests, lint, build, etc.) pour standardiser l’appel des scripts dans les workflows.            |

## Variables d’environnement exposées par `branch_env`

| Variable     | Description                               |
| ------------ | ----------------------------------------- |
| `REPO`       | Nom du dépôt                              |
| `BRANCH`     | Branche source (PR) / branche courante    |
| `COMMIT`     | SHA du commit courant                     |
| `IS_FEATURE` | `true` si la branche source = `feature/*` |
| `IS_BUGFIX`  | `true` si la branche source = `bugfix/*`  |
| `IS_HOTFIX`  | `true` si la branche source = `hotfix/*`  |
| `IS_RELEASE` | `true` si la branche source = `release/*` |
| `IS_DEVELOP` | `true` si la branche source = `develop`   |

---

## Exemple d’un job PR

```yaml
jobs:
  call-guard:
    uses: ./.github/workflows/guard.yml

  is_feature_pr:
    needs: call-guard
    if: needs.call-guard.outputs.IS_FEATURE == 'true'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Running PR workflow for feature/*"
```
