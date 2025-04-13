import 'package:cloud_firestore/cloud_firestore.dart';

enum SkillCategory {
  technical,
  social,
  organizational,
  creative,
  physical,
  other
}

class Skill {
  final String id;
  final String name;
  final String description;
  final SkillCategory category;
  final int level; // 1-5 representing beginner to expert
  final List<String> relatedSkills;
  final DateTime createdAt;

  Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.level = 1,
    this.relatedSkills = const [],
    required this.createdAt,
  }) : assert(level >= 1 && level <= 5, 'Skill level must be between 1 and 5');

  // Create skill from Firestore document
  factory Skill.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Skill(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      category: SkillCategory.values.firstWhere(
        (c) => c.toString() == data['category'],
        orElse: () => SkillCategory.other,
      ),
      level: data['level'] ?? 1,
      relatedSkills: List<String>.from(data['relatedSkills'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert skill to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'category': category.toString(),
      'level': level,
      'relatedSkills': relatedSkills,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // Create a copy of skill with updated fields
  Skill copyWith({
    String? name,
    String? description,
    SkillCategory? category,
    int? level,
    List<String>? relatedSkills,
  }) {
    return Skill(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      level: level ?? this.level,
      relatedSkills: relatedSkills ?? this.relatedSkills,
      createdAt: createdAt,
    );
  }
}