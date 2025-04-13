import 'package:cloud_firestore/cloud_firestore.dart';

enum OrganizationType {
  nonprofit,
  educational,
  government,
  community,
  other
}

class Organization {
  final String id;
  final String name;
  final String description;
  final String email;
  final String phone;
  final String website;
  final String logoUrl;
  final String address;
  final OrganizationType type;
  final bool isVerified;
  final List<String> causes;
  final List<String> eventIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  Organization({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.phone,
    required this.website,
    required this.logoUrl,
    required this.address,
    required this.type,
    this.isVerified = false,
    this.causes = const [],
    this.eventIds = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Organization.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Organization(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      website: data['website'] ?? '',
      logoUrl: data['logoUrl'] ?? '',
      address: data['address'] ?? '',
      type: OrganizationType.values.firstWhere(
        (t) => t.toString() == data['type'],
        orElse: () => OrganizationType.other,
      ),
      isVerified: data['isVerified'] ?? false,
      causes: List<String>.from(data['causes'] ?? []),
      eventIds: List<String>.from(data['eventIds'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'email': email,
      'phone': phone,
      'website': website,
      'logoUrl': logoUrl,
      'address': address,
      'type': type.toString(),
      'isVerified': isVerified,
      'causes': causes,
      'eventIds': eventIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Organization copyWith({
    String? name,
    String? description,
    String? email,
    String? phone,
    String? website,
    String? logoUrl,
    String? address,
    OrganizationType? type,
    bool? isVerified,
    List<String>? causes,
    List<String>? eventIds,
    DateTime? updatedAt,
  }) {
    return Organization(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      logoUrl: logoUrl ?? this.logoUrl,
      address: address ?? this.address,
      type: type ?? this.type,
      isVerified: isVerified ?? this.isVerified,
      causes: causes ?? this.causes,
      eventIds: eventIds ?? this.eventIds,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
