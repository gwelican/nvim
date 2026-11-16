# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Local tooling

Mason installs Prettier for JSON/YAML formatting and Mypy for Python type checking.
Formatting uses LazyVim's Conform integration; Mypy diagnostics use nvim-lint.
Prettier fixes formatting, not schema or application-level errors.

## Custom shortcuts

`<leader>` is Space.

| Shortcut | Action |
| --- | --- |
| `<leader>su` | Toggle Undotree (replaces the Snacks undo picker binding) |
| `<leader>ze` | Encrypt the current file with SOPS |
| `<leader>zd` | Decrypt the current file with SOPS |

The `<leader>z` group is labeled "secrets" in WhichKey. SOPS retains its in-place file behavior.
