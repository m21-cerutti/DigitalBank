# Comparatif des outils d’automatisation

## Objectif

Présenter les **outils retenus pour l’automatisation des tests** DigitalBank, **justifier** les choix par rapport aux **concurrents**, et préciser **forces/limites** afin d’asseoir la décision technique.

## Synthèse

| Domaine         | Outil                                                                                     |
| --------------- | ----------------------------------------------------------------------------------------- |
| Lint            | **ESLint** , **prettier**, **markdownlint**, **dockerfilelint**, **yaml-lint**, **black** |
| Pre-commit      | **Husky**                                                                                 |
| Secrets         | **Secretlint**                                                                            |
| Unitaires       | **Jest**                                                                                  |
| Intégration DOM | **JSDOM**                                                                                 |
| API             | **Bruno CLI**                                                                             |
| E2E             | **RobotFramework** (+ SeleniumLibrary)                                                    |
| Coverage        | (TODO) Jest (unit)                                                                        |
| Performance     | (TODO) JMeter                                                                             |
| Sécurité        | (TODO) OWASP ZAP / Snyk                                                                   |
| Accessibilité   | (TODO) axe + contrôles Robot                                                              |
| Monitoring      | (TODO) Prometheus/Grafana ou ELK                                                          |

---

## 1. ESLint – Lint

### Avantages

- Standard JS/TS, **règles extensibles** et écosystème riche.
- Intégration **IDE/CI** facile, corrigeurs automatiques (`--fix`).

### Limites

- Peut nécessiter une **gouvernance** des règles (overrides/monorepo).

### Alternatives

- **StandardJS** (moins personnalisable), **SonarLint** (utile mais complément IDE), **Biome** (très rapide, encore en adoption).

**Pourquoi ESLint ?**  
Il **couvre la majorité** des besoins JS/TS, s’intègre à Husky et reste **référent** dans l’écosystème.

---

## 2. Husky – Pre-commit

### Avantages

- Bloque les **commits non conformes** (lint, secrets), usage très simple.

### Limites

- Légère **latence** sur commit ; contournable (`--no-verify`) si non surveillé.

### Alternatives

- **Lefthook** (multi-plateforme, moins répandu), **pre-commit (Python)** (moins naturel pour un repo JS).

**Pourquoi Husky ?**  
Adoption large **dans l’écosystème JS**, intégration **plug-and-play** des scripts projet.

---

## 3. Secretlint – Détection de secrets

### Avantages

- Présente des **règles prêtes à l’emploi** (tokens, clés, etc.), usage **local + CI**.

### Limites

- Peut générer des **faux positifs** sur jeux de tests/démo.

### Alternatives

- **Gitleaks** (très efficace en CI, config différente), **TruffleHog** (puissant, plus verbeux).

**Pourquoi Secretlint ?**  
S’aligne avec un workflow **Node/NPM** (Husky + ESLint) et **centralise** l’hygiène de base, et marche en local.

---

## 4. Jest – Tests unitaires

### Avantages

- Rapide, **mocking natif**, **coverage intégré**, communauté **massive**.

### Limites

- Moins pertinent pour **tests UI pilotés** .
- Des limitations avec le code moderne ESM.

### Alternatives

- **Vitest** (rapide, très moderne), **Mocha** (historique, plus verbeux).

**Pourquoi Jest ?**  
**Standard de facto** pour les tests unitaires JS, **zéro friction** avec notre stack et **coverage** prêt à l’emploi.

---

## 5. JSDOM – Intégration headless (DOM)

### Avantages

- Permet de tester la **logique DOM** **sans navigateur**, **rapide et déterministe**.

- **Pas un vrai navigateur** (pas de layout/JS engine complet).

### Limites

- **Pas un vrai navigateur** (pas de layout/JS engine complet).

### Alternatives

- **Playwright** (plus proche du réel mais plus lourd), **happy-dom** (alternative légère).

**Pourquoi JSDOM ?**  
Solution temporaire qui marche avec DOM du index.html fourni, et plus rapide que des tests E2E classique.

---

## 6. Bruno + Jest – Tests API

### Avantages

- **Bruno** : collections **fichiers** (git‑friendly), simple à versionner et **rapide** en CLI.
- **Jest** pilote l’exécution : assertions, **reporting homogène** avec le reste (snapshots, coverage si besoin).

### Limites

- Moins d’**UX graphique** que Postman/Insomnia ; nécessite un **glue code** pour rapporter dans Jest.
- Pas d'API à tester

### Alternatives

- **Postman + Newman** (UX riche mais plus lourd en CI), **Insomnia** (orienté dev), **REST Assured** (Java‑centric).

**Pourquoi Bruno ?**

- Bruno **gère la description** des requêtes **en texte** (parfait pour PR/code review).
- Tout compris en local sécuritaire (vs PostMan)
- Avec CLI intégré pour CI

---

## 7. RobotFramework (+ SeleniumLibrary) – E2E

### Avantages

- **Lisibilité** orientée « métier » (syntaxe mots‑clés) → **partageable** avec PO/QA non dev.
- **Multi-navigateurs** (Selenium), **écosystème riche** (librairies, tags, reporting).
- Sélecteurs **data-testid** compatibles, intégration CI simple.
- Execution parrallèle possible (pabot) et analyse compilé de plusieurs run possibles.
- Proche de librairie mobile Appium

### Limites

- **Plus verbeux** que Playwright/Cypress
- Dépend de Selenium (plus lent que Playwright)
- Ne fonctionne pas en headless http-serveur :skull:

### Alternatives

- **Playwright** (très rapide, API moderne)
- **Cypress** (DX excellente mais contraintes multi-tabs/iframes)
- **Selenium pur** (bas niveau)
- **Appium** (mobile)

**Pourquoi RobotFramework ?**  
C’est **adapté à une équipe QA fonctionnelle**, facilite la **relecture par le métier** et s’aligne bien avec des **parcours critiques** peu nombreux mais **stables**.
Proche aussi de **Appium** pour transitionner vers des tests mobiles.

---

## 8. Coverage – Jest

> :warning: Reste encore à comparer les outils

### Avantages

- **Intégré** (Istanbul), **seuils par dossier/fichier**, rapports **HTML/LCOV**.

### Limites

- La **couverture n’est pas la qualité** : on cible surtout **unit/headless**.

### Alternatives

- **nyc** (Istanbul CLI), **SonarQube** (conso de rapports LCOV).

**Pourquoi Jest coverage ?**  
Zéro friction avec les **tests unitaires** et les **suites Jest** (y compris nos tests API orchestrés par Jest).

---

## 9. JMeter – Performance & Charge

> :warning: Compaison des outils en cours, aussi réparti sur l'ensemble de la pyramide de test.

### Avantages

- Mature, **open‑source**, riche en **plugins**, **CI‑friendly**.

### Limites

- DSL **verbeux**, UI vieillissante, scripts **moins lisibles**.

### Alternatives

- **k6** (DX moderne, scripting JS), **Gatling** (Scala, très performant), **Locust** (Python).

**Pourquoi JMeter ?**  
Référence **open‑source** stable ; facile à intégrer **à la marge** si besoin sur quelques scénarios de charge.

---

## 10. Sécurité – ZAP / Trivy / Snyk

> :warning: Compaison des outils en cours

### Avantages

- Couverture **SAST/DAST/deps** complémentaire ; exécutions **CI** automatisables.

### Limites

- **Faux positifs** possibles ; **temps de scan** significatif ; coût pour Snyk entreprise.

### Alternatives

- **Burp Suite** / **Nessus** / **Qualys** (mêmes usages, modèles de licence différents).

**Pourquoi ce trio ?**  
Panoplie **OSS + SaaS** facilement **scriptable**, adaptée aux **gates** minimes d’un projet démonstratif.

---

## 11. Accessibilité – axe-core (+ Selenium/Robot)

### Avantages

- **Règles WCAG** automatisables en partie ; **rapports** exploitables ; intégration **Selenium** via `axe-core`/`axe-webdriverjs`.

### Limites

- **30–40 %** des contrôles automatisables (audit humain requis).

### Alternatives

- **Lighthouse** (bon screening, moins précis), **WAVE** (manuel).

**Pourquoi axe-core ?**  
Permet d’**outiller** nos **parcours Robot** avec un **scan accessible** et d’automatiser une **partie** de la conformité WCAG.

---

## 12. Monitoring – Prometheus + Grafana (option)

### Avantages

- **Metrics temps réel**, **alerting**, **dashboards** custom.

### Limites

- Moins orienté logs (→ ELK/Datadog), **setup** infra nécessaire.

### Alternatives

- **ELK** (logs), **Datadog/NewRelic** (SaaS complet).

**Pourquoi (option) ?**  
Utile si l’on veut **pousser** la visibilité (perf/fiabilité) en **pré‑prod**, non requis pour la démonstration de base.
