class ConversationLog {
  final String date;
  final String text;
  final String context;

  ConversationLog({
    required this.date,
    required this.text,
    required this.context,
  });

  Map<String, dynamic> toJson() => {
    'date': date,
    'text': text,
    'context': context,
  };

  factory ConversationLog.fromJson(Map<String, dynamic> json) =>
      ConversationLog(
        date: json['date'] ?? '',
        text: json['text'] ?? '',
        context: json['context'] ?? '',
      );
}

class SpeakerProfile {
  final String name;
  final List<ConversationLog> conversationHistory;

  SpeakerProfile({required this.name, this.conversationHistory = const []});

  Map<String, dynamic> toJson() => {
    'name': name,
    'conversationHistory': conversationHistory.map((e) => e.toJson()).toList(),
  };

  factory SpeakerProfile.fromJson(Map<String, dynamic> json) => SpeakerProfile(
    name: json['name'] ?? 'Unknown',
    conversationHistory:
        (json['conversationHistory'] as List?)
            ?.map((e) => ConversationLog.fromJson(e))
            .toList() ??
        [],
  );
}
