# Neovim configuration

Personal configuration built on [LazyVim](https://www.lazyvim.org/).

## Local tooling

Mason installs Prettier for JSON/YAML formatting and Mypy for Python type checking.
Formatting uses LazyVim's Conform integration; Mypy diagnostics use nvim-lint.
Prettier fixes formatting, not schema or application-level errors.

Base64 tools load on `:B64Encode` / `:B64Decode`; VimBeGood loads on `:VimBeGood`.
Folding uses LazyVim's defaults rather than a global marker-folding override.

YAML's language server, formatter, linter, and validation shortcut live together in `lua/plugins/yaml.lua`.

## Custom shortcuts

`<leader>` is Space.

| Shortcut | Action |
| --- | --- |
| `<leader>su` | Toggle Undotree (replaces the Snacks undo picker binding) |
| `<leader>ze` | Encrypt the current file with SOPS |
| `<leader>zd` | Decrypt the current file with SOPS |
| `<leader>cY` | Validate the current Kubernetes YAML with `yayamlls --render` |

The `<leader>z` group is labeled "secrets" in WhichKey. SOPS retains its in-place file behavior.

## Intentional keymap choices

`J` intentionally invokes TreeSJ's syntax-aware split/join toggle, including YAML structures.
Keep this override: native `J` only joins lines and does not replace TreeSJ's structural behavior.
