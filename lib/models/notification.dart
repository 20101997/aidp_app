class NotificationItem {
  String title;
  String description;

  static NotificationItem fromJson(Map<String, Object?> json) =>
      NotificationItem(
          title: json["titolo"] as String,
          description: json["descrizione"] as String);

  NotificationItem({
    required this.title,
    required this.description,
  });
}
