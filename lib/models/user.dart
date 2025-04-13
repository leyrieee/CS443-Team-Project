import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;
  final List<String> skills;
  final List<String> interests;
  final List<String> eventsRegistered;
  final List<String> eventsCompleted;
  final int volunteerHours;
  final DateTime createdAt;
  final DateTime lastActive;

  User({
    required this.uid,
    required this.email,
    required this.name,
    this.photoUrl,
    this.skills = const [],
    this.interests = const [],
    this.eventsRegistered = const [],
    this.eventsCompleted = const [],
    this.volunteerHours = 0,
    required this.createdAt,
    required this.lastActive,
  }) : assert(volunteerHours >= 0, 'Volunteer hours cannot be negative');

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final now = DateTime.now();
    return User(
      uid: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'],
      skills: List<String>.from(data['skills'] ?? []),
      interests: List<String>.from(data['interests'] ?? []),
      eventsRegistered: List<String>.from(data['eventsRegistered'] ?? []),
      eventsCompleted: List<String>.from(data['eventsCompleted'] ?? []),
      volunteerHours: data['volunteerHours'] ?? 0,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : now,
      lastActive: data['lastActive'] != null
          ? (data['lastActive'] as Timestamp).toDate()
          : now,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'skills': skills,
      'interests': interests,
      'eventsRegistered': eventsRegistered,
      'eventsCompleted': eventsCompleted,
      'volunteerHours': volunteerHours,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastActive': Timestamp.fromDate(lastActive),
    };
  }

  User copyWith({
    String? name,
    String? photoUrl,
    List<String>? skills,
    List<String>? interests,
    List<String>? eventsRegistered,
    List<String>? eventsCompleted,
    int? volunteerHours,
    DateTime? lastActive,
  }) {
    return User(
      uid: uid,
      email: email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      eventsRegistered: eventsRegistered ?? this.eventsRegistered,
      eventsCompleted: eventsCompleted ?? this.eventsCompleted,
      volunteerHours: volunteerHours ?? this.volunteerHours,
      createdAt: createdAt,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}
