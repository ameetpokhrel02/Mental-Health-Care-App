class Doctor {
  final int id;
  final String name;
  final String specialization;
  final int experience;
  final String? imageUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    this.imageUrl,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      experience: json['experience'],
      imageUrl: json['imageUrl'],
    );
  }
}