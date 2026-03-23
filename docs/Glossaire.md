# Glossaire

- [Général](#général)
- [Web \& Technique](#web--technique)
- [Tests](#tests)
- [Automatisation](#automatisation)
- [CI/CD](#cicd)
- [Equivalences](#equivalences)

## Général

**PO (Product Owner)**
Responsable de la vision produit, priorise le backlog et valide les fonctionnalités.

**Stakeholder**
Partie prenante du projet (métier, direction, partenaires).

**MVP (Minimum Viable Product)**
Première version livrable d’un produit avec fonctionnalités essentielles.

**Backlog**
Liste priorisée des fonctionnalités à développer.

**User Story**
Description simple d’un besoin utilisateur.

**Sprint**
Itération Agile de développement (1 à 3 semaines).

**Release**
Version livrée en production.

**Hotfix**
Correctif urgent appliqué en production.

## Web & Technique

**API (Application Programming Interface)**
Interface permettant la communication entre systèmes.

**REST**
Architecture standard pour API HTTP.

**Endpoint**
URL exposée par une API.

**HTTP Status Code**
Code retour serveur (200 OK, 404, 500...).

**Frontend**
Partie visible pour l’utilisateur (UI).

**Backend**
Partie serveur (logique métier, BDD).

**DOM**
Structure HTML de la page.

**Selector**
Cible utilisée pour identifier un élément (CSS, XPath).

**Responsive**
Adaptation aux différents écrans.

**Cookie**
Stockage local navigateur.

**Token**
Jeton d’authentification (JWT).

**Session**
Connexion utilisateur active.

**Cache**
Stockage temporaire pour performance.

**Timeout**
Temps max d’attente.

**Flaky**
Test instable (succès aléatoire).

## Tests

**Recevabilité**
Test de conformité à des normes ou réglementations (RGPD, ISO, etc.).

**Correctif**
Test exécuté après correction d’un bug.

**Évolution**
Test lié à une nouvelle fonctionnalité.

**Non-régression**
Vérifie qu’une nouvelle version n’a rien cassé.

**Bout-en-bout (E2E)**
Test du parcours utilisateur complet.

**Partenaire**
Test d’intégration avec un système externe.

**Juridique / Réglementaire**
Vérifie conformité légale.

**UAT (User Acceptance Test)**
= Final + Acceptance + Métier
Validation par utilisateurs finaux.

**Acceptance**
Validation critères métier.

**Fonctionnel**
Test métier sans considération technique.

**Sanity Check**
Test rapide après déploiement.

**Smoke Test**
Test critique minimal.

**Load Test**
Test de charge.

**Stress Test**
Test au-delà des limites.

**Test de portabilité**
Compatibilité navigateurs / devices.

**Test exploratoire**
Test non scripté.

**Test système**
Validation système complet.

**Test intégration**
Vérifie échanges composants.

**Test unitaire**
Test fonction isolée.

## Automatisation

**Framework de test**
Outil d’automatisation (Playwright, Jest).

**BDD (Behavior Driven Development)**
Tests écrits en langage métier (Gherkin).

**Feature file**
Fichier `.feature` Cucumber.

**Step Definition**
Implémentation technique des steps.

**Page Object Model (POM)**
Pattern pour isoler la logique UI.

**Hook**
Action exécutée avant/après test.

**Test Runner**
Moteur d’exécution des tests.

**Assertion**
Vérification du résultat attendu.

**Mock**
Simulation de service.

**Stub**
Donnée factice.

**Data Driven**
Tests basés sur jeux de données.

**Headless**
Navigateur sans UI.

**Reporter**
Génération de rapports.

**Screenshot / Vidéo**
Preuves d’exécution.

## CI/CD

**Pipeline**
Chaîne d’exécution automatique.

**Build**
Compilation.

**Deploy**
Mise en production.

**Artifact**
Fichier généré (rapport).

**Rollback**
Retour arrière version.

**Branch**
Branche Git.

**Merge Request**
Demande fusion.

**Hook Git**
Script déclenché par Git.

**Docker**
Conteneurisation.

**docker-compose**
Orchestration multi-services.

**Image Docker**
Template de conteneur.

**Network Docker**
Réseau interne.

**Secrets**
Variables sensibles.

## Equivalences

| Terme                       | Équivalent                                                  |
| --------------------------- | ----------------------------------------------------------- |
| Final + Acceptance + Métier | UAT                                                         |
| Évolution                   | Acceptance                                                  |
| Fonctionnel                 | Métier                                                      |
| Sanity Check                | Test Manuel / Auto après déploiement et vérification du fix |
| Load                        | Charge                                                      |
