# ADR-0002 — Comment organiser la pyramide des tests ?

## Contexte

Limiter le coût de maintenance tout en sécurisant les parcours métier.

## Décision

Appliquer la pyramide : **beaucoup d’unitaires (Jest)**, **intégration headless (JSDOM) + API (Bruno)**, et **peu d’E2E (Robot)**.

## Conséquences

- Temps de pipeline maîtrisé.
- E2E réservés aux happy paths.
