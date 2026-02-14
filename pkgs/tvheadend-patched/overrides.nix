{
  # Dieses Package benötigt zusätzliche Argumente aus anderen Packages
  extraArgs = autoPackages: {
    inherit (autoPackages) libdvbcsa-patched;
  };
}
