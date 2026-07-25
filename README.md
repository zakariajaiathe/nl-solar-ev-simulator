# Solar & EV, after saldering — a Dutch home energy simulator (2026 vs 2027)

Dutch net metering (**salderingsregeling**) ends on 1 January 2027 — and the car is usually away when the sun is up. This interactive simulator puts numbers on what that mismatch costs a household with rooftop solar and an EV, and what smart charging wins back.

By [Zakaria Jaiathe](https://www.linkedin.com/in/zakaria-jaiathe/).

**Live demo:** https://zakariajaiathe.github.io/nl-solar-ev-simulator/

## What it models

- Hourly PV generation (calibrated to ~954 kWh/kWp, south 35°, 52°N) with orientation, tilt, east–west split and inverter clipping
- Household load (NEDU-shaped, seasonal, optional heat pump)
- Session-based EV charging with realistic **home-presence occupancy** — office / hybrid / WFH personas, commute times, workplace charging
- Five charging control strategies (uncontrolled, night, solar-surplus, hybrid, price-optimised)
- Optional home battery with round-trip losses and simple payback
- Both tariff regimes: 2026 annual netting vs. 2027 per-kWh feed-in with terugleverkosten, including the legal floor (net compensation ≥ 0; gross ≥ 50% of the bare supply tariff until 2030)
- Fixed/variable and dynamic (hourly market) contracts, with feed-in payment and terugleverkosten as free inputs

## Run locally

Open `index.html` directly, or:

```
python -m http.server 8000
```

No dependencies. The only network request is a Google webfont, which degrades cleanly offline.

## Data & disclaimers

Every tariff input is a generic, illustrative figure you set yourself — use your own contract's numbers. The dynamic price curve is synthesised (duck-curve shaped), not real EPEX data.

This is an educational model and **it can contain mistakes** — no guarantee is given as to the accuracy, completeness or currency of the figures or the model behind them. It is an illustration, not financial, tax or energy advice, and not a comparison of energy suppliers or their products.

A personal side project by [Zakaria Jaiathe](https://www.linkedin.com/in/zakaria-jaiathe/). It is mine alone, does not represent any organisation I work with or collaborate with, and is not affiliated with or endorsed by any energy supplier. Not intended for commercial reuse. Provided "as is", without warranty of any kind — use at your own risk.

Corrections and ideas are welcome: [LinkedIn](https://www.linkedin.com/in/zakaria-jaiathe/).

## License

MIT
