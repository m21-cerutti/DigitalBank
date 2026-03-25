# ADR-0003 — Comment envoyer les alertes CI par e-mail ?

## Contexte

Nous voulons un e-mail en cas d’échec CI contenant un **résumé** et des **extraits de logs**.

## Options

- SMTP Gmail (App Password)
- **SendGrid SMTP**
- API REST d’un ESP (ex: SendGrid action)

## Décision

Utiliser **SendGrid SMTP** via l’action `dawidd6/action-send-mail` pour lire un **corps HTML depuis fichier** et **joindre les artefacts**.

## Conséquences

- Secrets à créer : `SENDGRID_API_KEY`, `SENDGRID_FROM`, `SENDGRID_TO`.
- Pipeline « notify_sendgrid » `if: failure()`.
