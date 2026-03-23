# Abaque des Tests

- [Caractérisation des tests](#caractérisation-des-tests)
  - [Où teste-t-on ?](#où-teste-t-on-)
    - [Environnement](#environnement)
  - [Quand teste-t-on ?](#quand-teste-t-on-)
    - [Niveau de test](#niveau-de-test)
  - [Qui teste ?](#qui-teste-)
    - [Mode de test](#mode-de-test)
  - [Comment teste-t-on ?](#comment-teste-t-on-)
    - [Type de test](#type-de-test)
  - [Qu’est-ce qu’on teste ?](#quest-ce-quon-teste-)
    - [Nature du test](#nature-du-test)
- [Estimation des tests](#estimation-des-tests)
  - [Grille d’estimation](#grille-destimation)
  - [Calcul](#calcul)
- [Exemples](#exemples)
  - [Exemple 1 – Connexion + 2FA](#exemple-1--connexion--2fa)
  - [Exemple 2 – Consultation de solde (Smoke)](#exemple-2--consultation-de-solde-smoke)
  - [Exemple 3 – Virement vers bénéficiaire tiers](#exemple-3--virement-vers-bénéficiaire-tiers)

## Caractérisation des tests

Cette section permet de qualifier précisément chaque campagne ou scénario de test selon plusieurs axes.

### Où teste-t-on ?

#### Environnement

| Environnement | Description                                 |
| ------------- | ------------------------------------------- |
| LOCAL         | Poste du développeur                        |
| FEATURE       | Environnement temporaire par branche        |
| DEV           | Environnement partagé de développement      |
| RECETTE_NAME  | Environnement de validation spécifique      |
| PRE-PROD      | Réplication proche de la production         |
| PROD          | Environnement réel utilisateur (simulation) |

### Quand teste-t-on ?

#### Niveau de test

| Niveau      | Objectif                              |
| ----------- | ------------------------------------- |
| Unitaire    | Validation d’une fonction isolée      |
| Intégration | Vérification des échanges/DOM/API     |
| Système     | Validation du système minimal complet |
| E2E         | Parcours utilisateur de bout en bout  |

### Qui teste ?

#### Mode de test

| Mode        | Description                   |
| ----------- | ----------------------------- |
| Automatique | Exécuté par pipeline CI       |
| Manuel      | Test réalisé par un QA        |
| Final       | Validation métier/utilisateur |

### Comment teste-t-on ?

#### Type de test

| Type         | Objectif                             |
| ------------ | ------------------------------------ |
| Statique     | Analyse du code & documentation      |
| Smoke        | Vérification rapide post-déploiement |
| Acceptance   | Validation critères métier           |
| Régression   | Non-régression                       |
| Exploratoire | Découverte                           |

### Qu’est-ce qu’on teste ?

#### Nature du test

| Nature        | Description          |
| ------------- | -------------------- |
| Composant     | Front isolé (DOM/JS) |
| API           | Services/contrats    |
| Configuration | Paramétrage          |
| Correctif     | Bugfix               |
| Réglementaire | Conformité           |
| Métier        | Processus business   |
| Sécurité      | Vulnérabilités       |
| Performance   | Temps de réponse     |
| Charge        | Montée en charge     |
| Accessibilité | WCAG                 |
| ECO           | Impact environnement |
| Partenaire    | Intégration externe  |

---

## Estimation des tests

### Grille d’estimation

| Critère        | Faible          | Moyen     | Élevé          |
| -------------- | --------------- | --------- | -------------- |
| Complexité     | Fonction simple | Parcours  | Logique métier |
| Volumétrie     | < 5 cas         | 5–15      | > 15           |
| Données        | Statiques       | Variables | Dynamiques     |
| Dépendances    | Aucune          | API       | Multi‑systèmes |
| Automatisation | Simple          | Moyen     | Complexe       |

### Calcul

```text
Charge = Complexité + Volumétrie + Dépendances
```

| Résultat | Effort |
| -------: | :----- |
|    1 – 3 | 0.5 j  |
|    4 – 6 | 1 j    |
|    7 – 9 | 2 j    |
|      > 9 | 3 j    |

## Exemples

### Exemple 1 – Connexion + 2FA

| Critère       | Valeur      |
| ------------- | ----------- |
| Environnement | RECETTE     |
| Niveau        | E2E         |
| Mode          | Automatique |
| Type          | Acceptance  |
| Nature        | Métier      |
| Estimation    | 1 jour      |

### Exemple 2 – Consultation de solde (Smoke)

| Critère       | Valeur      |
| ------------- | ----------- |
| Environnement | DEV         |
| Niveau        | Système     |
| Mode          | Automatique |
| Type          | Smoke       |
| Nature        | Composant   |
| Estimation    | 0.5 jour    |

### Exemple 3 – Virement vers bénéficiaire tiers

| Critère       | Valeur       |
| ------------- | ------------ |
| Environnement | PRE-PROD     |
| Niveau        | E2E          |
| Mode          | Manuel       |
| Type          | Exploratoire |
| Nature        | Métier       |
| Estimation    | 2 jours      |
