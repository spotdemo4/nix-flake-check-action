# nix-flake-check-action

> GitHub Action that runs `nix flake check` and appends failed check logs to the action summary

# Usage

```yaml
steps:
  - uses: actions/checkout@v4
  - uses: DeterminateSystems/nix-installer-action@main
  - uses: spotdemo4/nix-flake-check-action@v1
    with:
      args: -L --keep-going
```

An example of a failing check can be found [here](https://github.com/spotdemo4/nix-flake-check-action/actions/workflows/test.yaml)