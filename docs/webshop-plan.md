# Webshop plan

## Doel

Later een eigen webshop koppelen aan de FiveM server voor veilige donaties/VIP pakketten.

## Betaalmethodes

- Stripe iDEAL
- Stripe creditcard
- Eventueel crypto later

## Reward verwerking

Veiligste flow:

1. Speler koopt pakket op website.
2. Stripe webhook bevestigt betaling.
3. Webhook schrijft order naar database.
4. FiveM resource of worker leest pending rewards.
5. Reward wordt gegeven als speler online is.
6. Order status wordt `completed`.

## Database voorbereiding

`database/jv_starter.sql` bevat al:

```txt
jv_donations
```

## Voorbeelden rewards

- Discord rol
- VIP status
- Bank bonus
- Custom kenteken
- Extra garage slot
- Cosmetic item

## Niet doen

- Geen OP wapens verkopen
- Geen extreem veel geld verkopen
- Geen staff/admin powers verkopen
