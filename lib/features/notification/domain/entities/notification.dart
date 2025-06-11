class Notification {
  final int? id;
  final String? title;
  final String? message;
  final int? status;
  final DateTime? createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.status,
    required this.createdAt,
  });
}
