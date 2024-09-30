class TestModel {
  final int id;
  final String title;
  final String topic;
  final String description;
  final String duration;
  final int createdBy;

  // Constructor
  TestModel({
    required this.id,
    required this.title,
    required this.topic,
    required this.description,
    required this.duration,
    required this.createdBy,
  });

  // Factory method to create a Test instance from JSON
  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as int,
      title: json['title'] as String,
      topic: json['topic'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      createdBy: json['created_by'] as int,
    );
  }

  // Method to convert a Test instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title': title,
      'topic': topic,
      'description': description,
      'created_by': createdBy,
      'duration' : duration
    };
  }
}
