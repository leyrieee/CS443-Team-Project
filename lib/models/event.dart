import 'package:cloud_firestore/cloud_firestore.dart';

enum EventStatus {
  upcoming,
  ongoing,
  completed,
  cancelled
}

class Event {
  final String id;
  final String title;
  final String description;
  final String organizationId;
  final String location;
  final String imageUrl;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final int maxParticipants;
  final List<String> requiredSkills;
  final List<String> registeredUsers;
  final EventStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.organizationId,
    required this.location,
    required this.imageUrl,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.maxParticipants,
    this.requiredSkills = const [],
    this.registeredUsers = const [],
    this.status = EventStatus.upcoming,
    required this.createdAt,
    required this.updatedAt,
  }) : assert(maxParticipants > 0),
       assert(endTime.isAfter(startTime));

  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final now = DateTime.now();
    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      organizationId: data['organizationId'] ?? '',
      location: data['location'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? now,
      startTime: (data['startTime'] as Timestamp?)?.toDate() ?? now,
      endTime: (data['endTime'] as Timestamp?)?.toDate() ?? now.add(Duration(hours: 1)),
      maxParticipants: data['maxParticipants'] ?? 1,
      requiredSkills: List<String>.from(data['requiredSkills'] ?? []),
      registeredUsers: List<String>.from(data['registeredUsers'] ?? []),
      status: EventStatus.values.firstWhere(
        (e) => e.toString() == data['status'],
        orElse: () => EventStatus.upcoming,
      ),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? now,
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? now,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'organizationId': organizationId,
      'location': location,
      'imageUrl': imageUrl,
      'date': Timestamp.fromDate(date),
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'maxParticipants': maxParticipants,
      'requiredSkills': requiredSkills,
      'registeredUsers': registeredUsers,
      'status': status.toString(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  bool get isFull => registeredUsers.length >= maxParticipants;

  bool hasStarted([DateTime? referenceTime]) {
    final now = referenceTime ?? DateTime.now();
    return now.isAfter(startTime);
  }

  bool hasEnded([DateTime? referenceTime]) {
    final now = referenceTime ?? DateTime.now();
    return now.isAfter(endTime);
  }

  Event copyWith({
    String? title,
    String? description,
    String? location,
    String? imageUrl,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    int? maxParticipants,
    List<String>? requiredSkills,
    List<String>? registeredUsers,
    EventStatus? status,
    DateTime? updatedAt,
  }) {
    return Event(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      organizationId: organizationId,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      requiredSkills: requiredSkills ?? this.requiredSkills,
      registeredUsers: registeredUsers ?? this.registeredUsers,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
