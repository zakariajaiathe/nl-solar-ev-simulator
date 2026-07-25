# Mismatch — NL solar & EV charging economics, 2026 vs 2027

An interactive simulator for the economics of home solar + EV charging in the Netherlands, before and after the end of the **salderingsregeling** (net metering) on 1 January 2027.

**Live demo:** https://zakariajaiathe.github.io/nl-solar-ev-simulator/

## What it models

- Hourly PV generation (calibrated to ~954 kWh/kWp, south 35°, 52°N) with orientation, tilt, east–west split and inverter clipping
- Household load (NEDU-shaped, seasonal, optional heat pump)
- Session-based EV charging with realistic **home-presence occupancy** — office / hybrid / WFH personas, commute times, workplace charging
- Five charging control strategies (uncontrolled, night, solar-surplus, hybrid, price-optimised)
- Optional home battery with round-trip losses and simple payback
- Both tariff regimes: 2026 annual netting vs. 2027 per-kWh feed-in with terugleverkosten, including the legal floor (net compensation ≥ 0; gross ≥ 50% of the bare supply tariff until 2030)
- 16 Dutch suppliers with preselected defaults (fixed and dynamic contracts, incl. Zonneplan's market-price + bonus model)

## Run locally

Open `index.html` directly, or:

```
python -m http.server 8000
```

No dependencies. The only network request is a Google webfont, which degrades cleanly offline.

## Data & disclaimers

Supplier feed-in rates are comparison-site snapshots (peildatum July 2026) and **will go stale** — verify against suppliers' published tariff sheets before relying on them. The dynamic price curve is synthesised (duck-curve shaped), not real EPEX data. This is an educational model, not financial advice, and is not affiliated with any energy supplier.

## License

MIT
