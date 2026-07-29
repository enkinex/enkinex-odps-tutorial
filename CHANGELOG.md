# Changelog

This document tracks the history and evolution of the **Enkinex ODPS Tutorial** for the **Enkinex ODPS Library**.

## v1.0.0 - First Stable Release

* Sample Data Product Project
    * ODPS customer data product example implemented as a KCL modular project
    * Product Metadata Schemas
    * Input and Output Port Schemas
    * Management Port and Support Schemas
    * Team Schemas
    * Moved the project to the repository root, so `git clone` + `just export` works with no `cd`
    * Renamed the root file to `product.k`, exporting `product.yaml`
    * Composed the root as an anonymous `DataProduct`, dropping the `-S product` selector
    * Restored `team.tags` and `team.customProperties` from the upstream example
* Documentation
    * `README.md`, `CONTRIBUTING.md`, `AUTHORS.md`, `history.md`
    * The tutorial pages now live on the [Enkinex website](https://enkinex.org/docs/governance/odps/tutorial/)
* Tooling
    * `Justfile` with `init`, `fmt`, `lint`, and `export` recipes
    * Apache-2.0 `LICENSE` and a shared `.gitignore`
* Dependencies
    * Depend on the stable `enkinex-odps` `v1.0.0` release tag
    * `kcl.mod` version `1.0.0`, edition `0.12.7`
