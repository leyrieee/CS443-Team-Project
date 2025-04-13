import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/event.dart';
import '../models/organization.dart';
import '../models/skill.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore}) 
    : _firestore = firestore ?? FirebaseFirestore.instance;

  // Collection references
  CollectionReference<Map<String, dynamic>> get _users => 
      _firestore.collection('users');
  CollectionReference<Map<String, dynamic>> get _events => 
      _firestore.collection('events');
  CollectionReference<Map<String, dynamic>> get _organizations => 
      _firestore.collection('organizations');
  CollectionReference<Map<String, dynamic>> get _skills => 
      _firestore.collection('skills');

  // Updated User CRUD operations
  Future<User> createUser(String uid, User user) async {
    await _users.doc(uid).set(user.toFirestore());
    return user;
  }

  Future<User?> getUser(String uid) async {
    final docSnap = await _users.doc(uid).get();
    if (!docSnap.exists) return null;
    return User.fromFirestore(docSnap);
  }

  Future<List<User>> getUsers() async {
    final querySnap = await _users.get();
    return querySnap.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  Future<User> updateUser(String uid, User user) async {
    await _users.doc(uid).update(user.toFirestore());
    return user;
  }

  Future<void> deleteUser(String uid) async {
    await _users.doc(uid).delete();
  }

  // Event CRUD operations
  Future<Event> createEvent(Event event) async {
    final docRef = _events.doc(event.id);
    await docRef.set(event.toFirestore());
    return event;
  }

  Future<Event?> getEvent(String id) async {
    final docSnap = await _events.doc(id).get();
    if (!docSnap.exists) return null;
    return Event.fromFirestore(docSnap);
  }

  Future<List<Event>> getEvents({
    String? organizationId,
    List<String>? skills,
    bool? upcoming,
  }) async {
    Query<Map<String, dynamic>> query = _events;
    
    if (organizationId != null) {
      query = query.where('organizationId', isEqualTo: organizationId);
    }

    if (skills != null && skills.isNotEmpty) {
      query = query.where('requiredSkills', arrayContainsAny: skills);
    }

    if (upcoming == true) {
      query = query.where('startTime', isGreaterThan: DateTime.now());
    }

    final querySnap = await query.get();
    return querySnap.docs.map((doc) => Event.fromFirestore(doc)).toList();
  }

  Future<Event> updateEvent(Event event) async {
    await _events.doc(event.id).update(event.toFirestore());
    return event;
  }

  Future<void> deleteEvent(String id) async {
    await _events.doc(id).delete();
  }

  // Organization CRUD operations
  Future<Organization> createOrganization(Organization org) async {
    final docRef = _organizations.doc(org.id);
    await docRef.set(org.toFirestore());
    return org;
  }

  Future<Organization?> getOrganization(String id) async {
    final docSnap = await _organizations.doc(id).get();
    if (!docSnap.exists) return null;
    return Organization.fromFirestore(docSnap);
  }

  Future<List<Organization>> getOrganizations({
    OrganizationType? type,
    bool? verified,
  }) async {
    Query<Map<String, dynamic>> query = _organizations;
    
    if (type != null) {
      query = query.where('type', isEqualTo: type.toString());
    }
    
    if (verified != null) {
      query = query.where('isVerified', isEqualTo: verified);
    }

    final querySnap = await query.get();
    return querySnap.docs.map((doc) => Organization.fromFirestore(doc)).toList();
  }

  Future<Organization> updateOrganization(Organization org) async {
    await _organizations.doc(org.id).update(org.toFirestore());
    return org;
  }

  Future<void> deleteOrganization(String id) async {
    await _organizations.doc(id).delete();
  }

  // Skill CRUD operations
  Future<Skill> createSkill(Skill skill) async {
    final docRef = _skills.doc(skill.id);
    await docRef.set(skill.toFirestore());
    return skill;
  }

  Future<Skill?> getSkill(String id) async {
    final docSnap = await _skills.doc(id).get();
    if (!docSnap.exists) return null;
    return Skill.fromFirestore(docSnap);
  }

  Future<List<Skill>> getSkills({
    SkillCategory? category,
    int? minLevel,
  }) async {
    Query<Map<String, dynamic>> query = _skills;
    
    if (category != null) {
      query = query.where('category', isEqualTo: category.toString());
    }
    
    if (minLevel != null) {
      query = query.where('level', isGreaterThanOrEqualTo: minLevel);
    }

    final querySnap = await query.get();
    return querySnap.docs.map((doc) => Skill.fromFirestore(doc)).toList();
  }

  Future<Skill> updateSkill(Skill skill) async {
    await _skills.doc(skill.id).update(skill.toFirestore());
    return skill;
  }

  Future<void> deleteSkill(String id) async {
    await _skills.doc(id).delete();
  }

  // ➕ New: Register user for event
  Future<void> registerForEvent(String eventId, String userId) async {
    final eventRef = _events.doc(eventId);
    final userRef = _users.doc(userId);

    await _firestore.runTransaction((transaction) async {
      final eventSnap = await transaction.get(eventRef);
      final userSnap = await transaction.get(userRef);

      if (!eventSnap.exists || !userSnap.exists) return;

      final eventData = eventSnap.data()!;
      final userData = userSnap.data()!;

      final List<dynamic> registeredUsers = List.from(eventData['registeredUsers'] ?? []);
      final List<dynamic> eventsRegistered = List.from(userData['eventsRegistered'] ?? []);

      if (!registeredUsers.contains(userId)) {
        registeredUsers.add(userId);
      }

      if (!eventsRegistered.contains(eventId)) {
        eventsRegistered.add(eventId);
      }

      transaction.update(eventRef, {'registeredUsers': registeredUsers});
      transaction.update(userRef, {'eventsRegistered': eventsRegistered});
    });
  }
}
