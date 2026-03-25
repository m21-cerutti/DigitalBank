# Stratégie d’automatisation des tests - DigitalBank – Banking Web App

- [Contexte](#contexte)
  - [Objectifs qualité d'autoamtisation](#objectifs-qualité-dautoamtisation)
  - [Principes d'automatisation](#principes-dautomatisation)
- [Périmètre de l’automatisation](#périmètre-de-lautomatisation)
  - [Environnements et navigateurs cibles](#environnements-et-navigateurs-cibles)
    - [Navigateurs](#navigateurs)
    - [Environnements de tests](#environnements-de-tests)
  - [Types de tests automatisés](#types-de-tests-automatisés)
  - [Critères d’éligibilité](#critères-déligibilité)
  - [Estimation \& Abaque d'automatisation](#estimation--abaque-dautomatisation)
- [Implémentation](#implémentation)
  - [Choix outils](#choix-outils)
  - [Architecture des tests](#architecture-des-tests)
    - [Organisation](#organisation)
    - [Page Object Model](#page-object-model)
  - [Gestion des environnements](#gestion-des-environnements)
  - [Gestion des données (JDD)](#gestion-des-données-jdd)
- [Organisation Agile](#organisation-agile)
  - [Avantages](#avantages)
  - [Inconvénients](#inconvénients)
  - [Processus](#processus)
- [Bonnes pratiques](#bonnes-pratiques)

## Contexte

DigitalBank est une application web bancaire de démonstration permettant :

- Connexion (avec 2FA optionnelle) et réinitialisation de mot de passe,
- Consultation des comptes et de l’historique des transactions,
- Virements internes et vers bénéficiaires tiers (validation IBAN),
- Paiement de factures, réglages de sécurité.

L’automatisation vise à fiabiliser les livraisons, réduire les régressions et accélérer la validation continue.

### Objectifs qualité d'autoamtisation

> **Lecture recommandée** : QA Lead, Scrum Master, Dev Lead, Product Owner, DevOps.  
> **But** : suivre vitesse**, stabilité, couverture et conformité, décider Go/No‑Go, et prioriser les actions correctives pour l'automatisation.
> :warning:**A combiner avec la stratégie de test global

| KPI                                        | À quoi ça sert                                                   | Mesure / Formule (source)                         |                                                    Cible | Fréquence | Lecteurs clés              | Actions si hors cible                                                       |
| ------------------------------------------ | ---------------------------------------------------------------- | ------------------------------------------------- | -------------------------------------------------------: | --------- | -------------------------- | --------------------------------------------------------------------------- |
| **Perf actions critiques (p95)**           | Vérifier que les parcours critiques respectent la perf attendue. | p95 (TTFB + rendu) sur scénarios clés en PRE‑PROD |                                                **≤ 2 s** | Hebdo     | Tech Lead, PO              | Profilage & optimisations ; budget perf en CI ; gate perf (bloquer release) |
| **% tests en échec (par criticité)**       | Qualité de livraison et respect des exigences.                   | FAIL / planifiés × 100 (par criticité)            |                  Critiques **< 5 %** ; Global **≤ 20 %** | Sprint    | QA Lead, PO                | Prioriser corrections critiques ; revue risques ; gate release              |
| **Taux de flakiness**                      | Détecter l’instabilité des tests/env.                            | Tests intermittents / exécutions × 100            |                                                **≤ 2 %** | Hebdo     | QA Lead, Dev Lead          | Stabiliser env ; durcir wait/locators ; refacto scénarios                   |
| **% d’automatisation (par niveau)**        | Mesurer l’industrialisation (régression, smoke, E2E).            | tests auto / tests totaux (ou éligibles) × 100    | **≥ 70 %** régression ; **100 %** smoke ; **≥ 30 %** E2E | Sprint    | QA/Automation Lead, DevOps | Plan d’automatisation ; refacto cas manuels ; allocation capacité           |
| **Temps de CI (max) / sprint**             | Maîtriser la durée des pipelines et le feedback.                 | Max durées pipelines du sprint                    |        **≤ 30 min** / branche ; **≤ 2 h** hebdo complète | Sprint    | DevOps, Dev Lead           | Paralléliser ; cache ; découper pipelines ; artefacts incrémentaux          |
| **MTTR pipeline (Mean Time To Repair)**    | Mesurer la réactivité après échec CI.                            | Temps moyen 1er fail → run vert                   |                                                **≤ 4 h** | Sprint    | DevOps, QA Lead            | Alerting ; ownership ; “fix‑first” policy ; runs ciblés                     |
| **Temps de pannes par env**                | Assurer la dispo des environnements.                             | Incidents + temps d’arrêt                         |                       **0** crit. ; **≤ 1** mineure/sem. | Hebdo     | DevOps, QA Lead            | Scaling/auto‑healing ; redondance ; SLO env                                 |
| **Taille totale des artefacts (pré‑prod)** | Maîtriser stockage/coûts (éco‑conso).                            | Somme Mo artefacts                                |                                     **≤ +10 %** vs seuil | Mensuel   | DevOps, GreenOps           | Purge/archivage ; compression ; politique de rétention                      |
| **Conso CI (kWh) / sprint**                | Piloter l’empreinte énergétique.                                 | kWh mesurés                                       |                                     **−5 %** vs baseline | Sprint    | IT/DevOps, GreenOps        | Extinction hors heures ; right‑sizing ; green pipelines                     |

### Principes d'automatisation

- **Shift-left testing** : démarrage aux niveaux unitaires & intégration (JSDOM, API).
- **Pyramide des tests** : majorité de tests rapides (unit/headless/API), E2E sur parcours critiques.
- **Revue systématique** : tout test passe en Pull Request.
- **3 Amigos** : PO, QA, Dev valident les cas à automatiser.
- **Automatisation utile** : focus scénarios stables, forte valeur métier, ROI positif.

## Périmètre de l’automatisation

### Environnements et navigateurs cibles

#### Navigateurs

| Navigateur | Support                   |
| ---------: | :------------------------ |
|     Chrome | Oui                       |
|    Firefox | À court terme             |
|     Safari | À moyen terme (si besoin) |

#### Environnements de tests

| Environnement | Acteurs                  | Objectif                                                                                     |
| ------------- | ------------------------ | -------------------------------------------------------------------------------------------- |
| LOCAL         | Développeurs             | Développement, TU, tests headless/API                                                        |
| DEV           | Dev, QA                  | Intégration, validation fonctionnelle                                                        |
| FEATURE       | QA                       | Validation par branche                                                                       |
| RECETTE       | QA, Specififique, Métier | Validation métier et/ou spécifique à une recette (charge, métier, performance, acessibilité) |
| PRE-PROD      | QA, PO                   | Simulation production, E2E critiques                                                         |
| PROD          | Métier                   | Monitoring post-déploiement                                                                  |

### Types de tests automatisés

> Voir ➡ [docs/Pipeline.md](../../docs/Pipeline.md)

| Type            | Outil / Approche                       |
| --------------- | -------------------------------------- |
| Unitaire        | **Jest**                               |
| Intégration     | **JSDOM** (DOM headless)               |
| API             | **Bruno CLI** (avec cli)               |
| Système / Smoke | Node scripts + vérifications minimales |
| E2E             | **RobotFramework** + SeleniumLibrary   |
| Performance     | JMeter (à investiguer)                 |
| Charge          | JMeter (à investiguer)                 |

### Critères d’éligibilité

> Voir ➡ [tests/docs/Gestion_TNR.md](Gestion_TNR.md) et [tests\docs\Decision_Autom.md](Decision_Autom.md)

- Stabilité fonctionnelle
- Valeur métier et priorité
- Fréquence d’exécution
- Données disponibles/maîtrisées
- ROI positif (mise en place + maintenance)

### Estimation & Abaque d'automatisation

> Voir ➡ [text](tests/docs/Abaque_Test_Autom.md.md) pour la **grille** et le **calcul d’effort**.

L’estimation prend en compte :

- Complexité fonctionnelle
- Nombre de cas
- Dépendances externes
- Maintenance estimée

## Implémentation

### Choix outils

> Voir ➡ [tests/docs/Outils_Tests.md](Outils_Tests.md)

### Architecture des tests

#### Organisation

- Dossier `tests/` séparé et **structuré par niveau** (`unit`, `integration`, `system`, `e2e`).
- `notif/mail/` pour générer un **email HTML** à partir des artefacts (logs + JUnit) (TODO).
- Conventions de nommage et de répertoires homogènes.

#### Page Object Model

- Pour l’E2E, privilégier mots‑clés **Robot** et sélecteurs **data-testid** stables.
- Centraliser les sélecteurs clés et éviter la duplication.
- Pas d’assertions dans les « pages » : assertions dans les tests ou step-defs.

### Gestion des environnements

- Exécution locale via `http-server`
- CI : **GitHub Actions**, Environment
- Nettoyage minimal (artefacts)
- Job de déploiment (TODO Site remote develop, release, main)

### Gestion des données (JDD)

- Données **UI** simulées dans `app/index.html`.
- Données **API** via Bruno (`environments/local.bru`).
- Évolution possible : fixtures/outillage dans `tests/data` pour scenarios avancés, scripts sql des évolution DB, scripts smoke verification entre sql/json.

## Organisation Agile

### Avantages

- Feedback rapide, pipeline stable, qualité visible.

### Inconvénients

- Flakiness E2E si sélecteurs instables ; dette de maintenance si sur‑automatisation.

### Processus

1. **Décision d’automatisation** (après 1 sprint de stabilisation si nécessaire).
2. **3 Amigos** : critères d’acceptation & priorisation.
3. **Pull Request** : couverture du bas vers le haut (unit → E2E), revue QA.
4. **Bugs** : tout correctif critique = test automatisé associé.
5. **Reporting** : artefacts CI + **mail HTML** (échecs), KPI mensuels.
6. **Go/No Go** : résultats, couverture, criticité des anomalies.

## Bonnes pratiques

- Tests tagués
- CI systématique (push/PR)
- Sélecteurs **data-testid** pour l’E2E
- Collecte d’artefacts (logs, JUnit)
- Secrets en **Actions secrets**
- Documentation vivante (`docs/`, ADR)
