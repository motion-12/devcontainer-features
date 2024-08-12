# Antidote (neovim)

Installs neovim. Includes the following dependencies:

- lazygit
- ripgrep

## Example Usage

```json
"features": {
    "ghcr.io/motion-12/devcontainer-features/neovim:1": {}
}
```

## Options

| Options Id | Description                                  | Type   | Default Value |
| ---------- | -------------------------------------------- | ------ | ------------- |
| plugins    | List of plugins to install (comma separated) | string | -             |
| username   | Username to use                              | string | -             |

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/motion-12/devcontainer-features/blob/main/src/neovim/devcontainer-feature.json). Add additional notes to a `NOTES.md`._
