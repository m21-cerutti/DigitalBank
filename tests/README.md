# Tests automatisés

- [Architecture](#architecture)
- [Lancer les tests](#lancer-les-tests)

## Architecture

```bash
tests/
├── data/                           # Données de test utilisées par les scripts
│
├── docs/                           # Documentation sur les tests
│   ├── Abaque_Test_Autom.md        # Critères d’automatisation
│   ├── Decision_Autom.md           # Justification des choix de tests automatisés
│   ├── Outils_Tests.md             # Outils et technologies utilisés pour les tests
│   ├── Pipeline_Test.md            # Pipeline CI/CD pour tests
│   └── Strategie_Test_Autom.md     # Stratégie globale de tests automatisés
│
├── src/                            # Code source des tests
│   ├── e2e/                        # Tests End-To-End
│   │   ├── pages/                  # Page Objects (comportements pages)
│   │   ├── specs/                  # Scénarios E2E
│   │   ├── stepdefs/               # Étapes BDD
│   │   └── utils/                  # Helpers spécifiques E2E
│   ├── integration/                # Tests d'intégration, notamment API
│   ├── smoke/                      # Tests rapides smoke tests (avant système, e2e)
│   ├── system/                     # Tests systèmes partie de fonctionnalités
│   ├── unit/                       # Tests unitaires
│   └── utils/                      # Fonctions utilitaires communes
│
└── README.md                       # Documentation et instructions sur le module tests
```

Les choix d'outils et les explications sont disponibles dans la [Stratégie des tests](docs/Strategie_Test_Autom.md)

## Lancer les tests

```bash
npm run test:all
```
