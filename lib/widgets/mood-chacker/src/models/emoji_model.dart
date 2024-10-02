class EmojiModel {
  final String src;
  final String label;
  final String? package;

  const EmojiModel({
    required this.src,
    required this.label,
    this.package,
  });
}
