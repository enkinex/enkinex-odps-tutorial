[![Enkinex — Semantic & Governance as Code](https://raw.githubusercontent.com/enkinex/enkinex-odps/main/docs/images/enkinex-github-banner.png)](https://enkinex.org)

# Enkinex ODPS Tutorial

[![Standard](https://img.shields.io/badge/ODPS-v1.0.0-blue)](https://github.com/bitol-io/open-data-product-standard/tree/v1.0.0)
[![KCL](https://img.shields.io/badge/KCL-%E2%89%A5%200.12.7-7B68EE)](https://www.kcl-lang.io/)
[![Version](https://img.shields.io/badge/version-v1.0.0-green)](./CHANGELOG.md)
[![License](https://img.shields.io/badge/license-Apache--2.0-green)](./LICENSE)

---

## Getting Started with Enkinex ODPS

Learn from the **[Enkinex ODPS Tutorial](https://enkinex.org/docs/governance/odps/tutorial/)** how to write a data
product as a code project and export it to a YAML document.

**What you are going to learn:**

1. **Installing KCL**: set up the KCL CLI on your machine.
2. **Creating the Data Product Project Module**: initialize a KCL module, depend on [enkinex-odps](https://github.com/enkinex/enkinex-odps/tree/v1.0.0), and lay out a modular
   project.
3. **Declare the Data Product KCL Code**: author the data product as small, reusable typed KCL sources.
4. **Parse and Export to YAML**: validate, print, and export the data product to YAML or JSON.

## Requirements

- [KCL Language CLI](https://www.kcl-lang.io/docs/user_docs/getting-started/install) `>= 0.12.7`
- [`just` Command Runner](https://github.com/casey/just).

Check both are on your `PATH`:

```bash
kcl --version
just --version
```

## ODPS Tutorial Commands

Common tasks are wrapped in the [`Justfile`](Justfile):

```bash
just init      # sync library module dependencies
just export    # exports the KCL product.k to product.yaml
just fmt       # formats every `.k` file in the project
just lint      # Runs `kcl lint` against the root data product and every project directory
```

---

## External References and Resources

- **[Enkinex ODPS Library v.1.0.0](https://github.com/enkinex/enkinex-odps/tree/v1.0.0)**: The governance as code library for ODPS.
- **Open Data Product Standard (ODPS) v1.0.0**: the
  standard [GitHub project](https://github.com/bitol-io/open-data-product-standard/tree/v1.0.0).
    - Standard JSON Schema: [`odps-json-schema-v1.0.0.json`](https://github.com/enkinex/enkinex-odps/blob/v1.0.0/odps-json-schema-v1.0.0.json)
- **[KCL Language](https://www.kcl-lang.io/)**: the configuration & policy DSL used for the
  implementation.

---

## Contributing

Contributions are welcome — see [CONTRIBUTING.md](CONTRIBUTING.md) and the
contributor list in [AUTHORS.md](AUTHORS.md).

---

## License

Licensed under the Apache License 2.0 — see [LICENSE](LICENSE).
