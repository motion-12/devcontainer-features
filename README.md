# M12 - Dev Container Features

## Packaging

```bash
devcontainer features package src
```

## Testing

Run the following to execute all user-generated tests:

```bash
devcontainer features test --skip-autogenerated
```

## Utils (./utils)

This is a package-manager-like utility for installing scripts from the `shared` into a feature.

### Install

```bash
./utils add <util-name> <feature-name>
```

### Sync

```bash
./utils sync [feature-names...]
```

### Remove

```bash
./utils remove <util-name> <feature-name>
```
