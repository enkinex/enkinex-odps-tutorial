# Installing KCL

Enkinex ODPS is built as a KCL library, so the only tool this tutorial requires is the KCL command-line tool
itself. Follow the official guide:

**➡ [KCL — Install](https://www.kcl-lang.io/docs/user_docs/getting-started/install)**

Once installed, confirm the CLI is on your `PATH`:

```bash
kcl --help
```

This tutorial was written and validated against `kcl 0.12.4`, the minimum version the library's [`kcl.mod`](https://github.com/enkinex/enkinex-odps/blob/main/kcl.mod)
declares (`edition = "0.12.4"`). Check your version with:

```bash
kcl --version
```