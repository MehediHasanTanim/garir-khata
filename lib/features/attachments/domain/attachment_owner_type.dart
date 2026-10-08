enum AttachmentOwnerType {
  fuel,
  expense,
  service,
  repair,
  document,
  tyre,
  battery,
  vehicle,
  note,
}

extension AttachmentOwnerTypeX on AttachmentOwnerType {
  String get code => name;

  static AttachmentOwnerType? tryParse(String raw) {
    for (final value in AttachmentOwnerType.values) {
      if (value.name == raw) {
        return value;
      }
    }
    return null;
  }
}
