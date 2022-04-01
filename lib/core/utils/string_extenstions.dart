extension ExtraExtensionFunctions on String {
  String getInitials() =>
      trim().split(' ').map((e) => e.trim().isEmpty ? '' : e[0]).join();

  String capitalize() => trim().isEmpty
      ? ''
      : trim().substring(0, 1).toUpperCase() + trim().substring(1);
}
