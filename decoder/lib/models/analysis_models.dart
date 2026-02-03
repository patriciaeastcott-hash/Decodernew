class AnalysisResponse {
  final List<dynamic> transcript;
  final List<dynamic> speakers;
  final String overview;
  final String aiDisclosure;

  AnalysisResponse({
    required this.transcript,
    required this.speakers,
    required this.overview,
    required this.aiDisclosure,
  });

  factory AnalysisResponse.fromJson(Map<String, dynamic> json) {
    return AnalysisResponse(
      transcript: json['transcript_log'] ?? [],
      speakers: json['speakers'] ?? [],
      overview: json['conversation_overview']?['interaction_summary'] ?? '',
      aiDisclosure: json['ai_disclosure'] ?? '',
    );
  }
}
