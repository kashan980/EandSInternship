class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({required this.id, required this.title, required this.body});

  // This factory constructor safely parses the JSON from the server
  factory PostModel.fromJson(Map<String, dynamic> json) {
    // 1. DATA PARSING EXCEPTION: Wrap the parsing in a try/catch
    try {
      // 2. TYPE CASTING EXCEPTION: Safely check if 'id' is an integer
      int parsedId = 0;
      if (json['id'] is int) {
        parsedId = json['id'];
      } else if (json['id'] is String) {
        // 3. FORMAT EXCEPTION: Try to convert a string to an int without crashing
        parsedId = int.tryParse(json['id']) ?? 0;
      }

      return PostModel(
        id: parsedId,
        // 4. NULL EXCEPTION: Use ?? to provide a fallback if the server forgot the title
        title: json['title'] ?? 'No Title Provided',
        body: json['body'] ?? 'No Body Provided',
      );
    } catch (e) {
      // If the JSON structure is completely broken, we catch the parsing exception here
      throw Exception('Data Parsing Exception: Failed to parse PostModel - $e');
    }
  }
}
