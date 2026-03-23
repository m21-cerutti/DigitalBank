# Tests automatisés

- [Architecture](#architecture)
- [Stratégie de test](#stratégie-de-test)
- [Lancer les tests](#lancer-les-tests)
  - [Exécution globale](#exécution-globale)
- [Commandes disponibles](#commandes-disponibles)
  - [Tests complets](#tests-complets)
  - [Tests par type](#tests-par-type)
  - [Qualité \& reporting](#qualité--reporting)
- [Bonnes pratiques](#bonnes-pratiques)

## Architecture

```bash
tests/
├── data/                           # Données de test (fixtures, jeux de données)
│
├── docs/                           # Documentation QA
│   ├── Abaque_Test_Autom.md        # Critères d’automatisation (ROI, stabilité, criticité)
│   ├── Decision_Autom.md           # Décisions techniques (framework, stratégie)
│   ├── Outils_Tests.md             # Stack technique de test
│   ├── Pipeline_Test.md            # Intégration CI/CD des tests
│   └── Strategie_Test_Autom.md     # Stratégie globale d’automatisation
│
├── src/                            # Implémentation des tests
│   ├── e2e/                        # Tests End-To-End (parcours utilisateurs)
│   │   ├── features/               # Scénarios fonctionnels
│   │   ├── libs/                   # Bibliothèques python custom
│   │   ├── pages/                  # Page Objects (abstraction UI)
│   │   ├── step-defs/              # Étapes BDD (Given/When/Then)
│   │   └── suppor/                 # Helpers spécifiques E2E
│   │
│   ├── integration/                # Tests d’intégration (API / services)
│   ├── smoke/                      # Tests rapides de validation (build health)
│   ├── system/                     # Tests système (fonctionnalités complètes)
│   └── unit/                       # Tests unitaires (logique isolée)
│
└── README.md                       # Documentation du module tests
```

## Stratégie de test

Les choix d'outils et les explications sont disponibles dans la [Stratégie des tests](docs/Strategie_Test_Autom.md)

## Lancer les tests

### Exécution globale

```bash
npm run test:all
```

---

## Commandes disponibles

> Ces commandes permettent d’exécuter les tests par niveau ou usage spécifique.

### Tests complets

```bash
npm run test:all          # Tous les tests
```

---

### Tests par type

```bash
npm run test:unit           # Tests unitaires
npm run test:integration    # Tests d’intégration
npm run test:api            # Tests d’intégration
npm run test:system         # Tests système
npm run test:e2e            # Tests end-to-end
```

---

### Qualité & reporting

```bash
npm run lint:*            # Vérification qualité code
npm run format            # Formatage automatique
```

---

## Bonnes pratiques

- **Isolation des tests** : aucun état partagé entre scénarios
- **Données maîtrisées** :
  - jeux de données versionnés (`tests/data`)
  - pas de dépendance à des environnements instables

- **Lisibilité** :
  - Page Object Pattern
  - Séparation claire specs / logique

- **Maintenabilité** :
  - factorisation des helpers (`utils/support`)
  - limitation de la duplication

- **CI-ready** :
  - tests déterministes
  - exécution headless
  - logs exploitables
