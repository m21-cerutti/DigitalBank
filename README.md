# DigitalBank — Automatisation des tests (Étude de cas)

[![Main](https://github.com/m21-cerutti/DigitalBank/actions/workflows/main-push.yml/badge.svg)](https://github.com/m21-cerutti/DigitalBank/actions/workflows/main-push.yml)
[![Develop](https://github.com/m21-cerutti/DigitalBank/actions/workflows/develop-push.yml/badge.svg?branch=develop)](https://github.com/m21-cerutti/DigitalBank/actions/workflows/develop-push.yml)

> Ce dépôt implémente une **stratégie d’automatisation complète** pour une application bancaire démonstrative.

- [Description](#description)
- [Hierarchie](#hierarchie)
- [Synthèse du travail demandé](#synthèse-du-travail-demandé)
- [Stack technique](#stack-technique)
  - [Application](#application)
  - [Qualité \& Tests \& automatisation](#qualité--tests--automatisation)
  - [Documentation](#documentation)
- [Quick start](#quick-start)
  - [Installation](#installation)
  - [Lancer les linter](#lancer-les-linter)
  - [Lancer/Stopper l'application](#lancerstopper-lapplication)
  - [Lancer les tests](#lancer-les-tests)
  - [Autres commandes usuels](#autres-commandes-usuels)

## Description

Ce projet a pour objectif de mettre en place une stratégie d’automatisation des tests pour une application bancaire (DigitalBank), dans un contexte Agile.

Il couvre :

- les tests fonctionnels automatisés sur les parcours critiques :
  - authentification
  - consultation de compte
  - virements bancaires
  - paiement de factures
- l’intégration dans un pipeline CI/CD (GitHub Actions)
- la gestion des données de test
- la documentation des choix techniques (ADR)
- la mise en place de bonnes pratiques QA (qualité, maintenabilité, traçabilité)

Le projet est conçu comme un socle d’automatisation en entreprise.

## Hierarchie

```bash
DigitalBank/
│   CHANGELOG.md                   # Historique des versions
│   LICENSE                        # Licence du projet
│   package.json                   # Dépendances Node.js et scripts d’exécution
│   README.md                      # Documentation principale du projet
│   runner_e2e.js                  # Point d’entrée pour exécuter les tests E2E
│
├───.github                        # Configuration CI/CD (GitHub Actions)
│   └───workflows                  # Pipelines (build, tests, lint, etc.)
│
├───.husky                         # Hooks Git (qualité du code avant commit)
│       pre-commit                 # Lint + vérifications avant commit
│
├───.vscode                        # Configuration recommandée pour VS Code
│       extensions.json            # Extensions suggérées
│       settings.json              # Paramètres de formatage/édition
│
├───app                            # Application bancaire (front simulé)
│       index.html                 # Point d’entrée UI
│       README.md                  # Documentation spécifique app
│
├───docs                           # Documentation projet
│   │   Gestion_Anomalie.md        # Processus de gestion des bugs
│   │   Git_Flow.md                # Stratégie de branches
│   │   Glossaire.md               # Terminologie projet
│   │   Pipeline.md                # Description CI/CD
│   │   Étude de Cas...            # Sujet initial
│   └───adr                        # Architecture Decision Records
│
└───tests                          # Automatisation des tests
    │   README.md                  # Documentation des tests
    ├───data                       # Données de test (fixtures, jeux de données)
    ├───docs                       # Documentation QA
    │   │   Abaque_Test_Autom.md   # Critères d’automatisation
    │   │   Decision_Autom.md      # Choix techniques
    │   │   Gestion_TNR.md         # Stratégie de non-régression
    │   │   Outils_Tests.md        # Stack de test
    │   │   Strategie_Test_Autom.md# Stratégie globale QA
    │   └───adr                    # Décisions QA
    └───src                        # Code des tests automatisés

```

## Synthèse du travail demandé

Le projet répond aux objectifs suivants :

1. Définition d’une stratégie d’automatisation
   - Identification des scénarios critiques
   - Définition des critères d’automatisation
   - Choix des outils et architecture de test

2. Implémentation des tests
   - Scripts automatisés maintenables
   - Structuration claire (data / logique / exécution)
   - Respect des bonnes pratiques QA

3. Gestion des données de test
   - Isolation des données
   - Réutilisabilité des jeux de données
   - Adaptation multi-environnements

4. Intégration CI/CD
   - Exécution automatique des tests
   - Validation des pull requests
   - Feedback rapide aux équipes

5. Documentation et traçabilité
   - ADR pour les décisions techniques
   - Documentation QA complète
   - Visibilité des processus

## Stack technique

### Application

- index.html généré AI

### Qualité & Tests & automatisation

> Voir ➡ [tests/docs/Strategie_Test_Autom.md](tests/docs/Strategie_Test_Autom.md)

### Documentation

- Markdown
- ADR (Architecture Decision Records)

---

## Quick start

### Installation

```bash
# Cloner le projet
git clone https://github.com/m21-cerutti/DigitalBank.git

# Installer les dépendances
npm install
npm run test:e2e:install
npm prepare
```

### Lancer les linter

```bash
npm run lint:all
```

### Lancer/Stopper l'application

```bash
# Aller sur localhost:5173
npm start
npm stop
```

### Lancer les tests

```bash
npm run test:unit
npm run test:api
npm run test:integration
npm run test:e2e
```

### Autres commandes usuels

```bash
npm lint:fix
```
