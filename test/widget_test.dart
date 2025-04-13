import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:catchafire/services/firestore_service.dart';
import 'package:catchafire/models/user.dart';
import 'package:catchafire/models/event.dart';
import 'package:catchafire/models/organization.dart';
import 'package:catchafire/models/skill.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late FirestoreService firestoreService;
  final now = DateTime.now();

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    firestoreService = FirestoreService(firestore: mockFirestore);
  });

  group('User CRUD Operations', () {
    final testUser = User(
      uid: 'test_user_id',
      name: 'Test User',
      email: 'test@example.com',
      skills: ['coding', 'testing'],
      interests: ['volunteering'],
      createdAt: now,
      lastActive: now,
    );

    test('createUser should store user data', () async {
      await firestoreService.createUser(testUser.uid, testUser);

      final snapshot = await mockFirestore.collection('users').doc(testUser.uid).get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data()?['email'], testUser.email);
    });

    test('getUser should retrieve stored user data', () async {
      await firestoreService.createUser(testUser.uid, testUser);

      final retrievedUser = await firestoreService.getUser(testUser.uid);
      expect(retrievedUser?.email, testUser.email);
      expect(retrievedUser?.name, testUser.name);
      expect(retrievedUser?.skills, testUser.skills);
    });
  });

  group('Event CRUD Operations', () {
    final testEvent = Event(
      id: 'test_event_id',
      title: 'Test Event',
      description: 'Test Description',
      organizationId: 'test_org_id',
      location: 'Test Location',
      imageUrl: 'test_image.jpg',
      date: now,
      startTime: now,
      endTime: now.add(Duration(hours: 2)),
      maxParticipants: 10,
      requiredSkills: ['coding', 'testing'],
      createdAt: now,
      updatedAt: now,
    );

    test('createEvent should store event data', () async {
      await firestoreService.createEvent(testEvent);

      final snapshot = await mockFirestore.collection('events').doc(testEvent.id).get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data()?['title'], testEvent.title);
    });

    test('getEvent should retrieve stored event data', () async {
      await firestoreService.createEvent(testEvent);

      final retrievedEvent = await firestoreService.getEvent(testEvent.id);
      expect(retrievedEvent?.title, testEvent.title);
    });
  });

  group('Organization CRUD Operations', () {
    final testOrg = Organization(
      id: 'test_org_id',
      name: 'Test Organization',
      description: 'Test Description',
      email: 'org@example.com',
      phone: '123-456-7890',
      website: 'www.testorg.com',
      logoUrl: 'test_logo.jpg',
      address: '123 Test St',
      type: OrganizationType.nonprofit,
      causes: ['education', 'environment'],
      createdAt: now,
      updatedAt: now,
    );

    test('createOrganization should store organization data', () async {
      await firestoreService.createOrganization(testOrg);

      final snapshot = await mockFirestore.collection('organizations').doc(testOrg.id).get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data()?['name'], testOrg.name);
    });

    test('getOrganization should retrieve stored organization data', () async {
      await firestoreService.createOrganization(testOrg);

      final retrievedOrg = await firestoreService.getOrganization(testOrg.id);
      expect(retrievedOrg?.name, testOrg.name);
      expect(retrievedOrg?.causes, testOrg.causes);
    });
  });

  group('Advanced User Operations', () {
    test('Create, get, update, and delete user', () async {
      final testUid = 'test_${now.millisecondsSinceEpoch}';
      final user = User(
        uid: testUid,
        email: 'test@example.com',
        name: 'Test User',
        createdAt: now,
        lastActive: now,
      );

      await firestoreService.createUser(user.uid, user);
      final fetchedUser = await firestoreService.getUser(user.uid);
      expect(fetchedUser?.email, user.email);

      final updatedUser = user.copyWith(name: 'Updated Name');
      await firestoreService.updateUser(user.uid, updatedUser);

      final fetchedUpdatedUser = await firestoreService.getUser(user.uid);
      expect(fetchedUpdatedUser?.name, 'Updated Name');

      await firestoreService.deleteUser(user.uid);
      final deletedUser = await firestoreService.getUser(user.uid);
      expect(deletedUser, isNull);
    });
  });

  group('Event Filters and Registration', () {
    test('Register user to event and verify', () async {
      final testUserId = 'test_user_${now.millisecondsSinceEpoch}';
      final testEventId = 'event_${now.millisecondsSinceEpoch}';

      final user = User(
        uid: testUserId,
        email: 'test@example.com',
        name: 'Test User',
        createdAt: now,
        lastActive: now,
      );

      final event = Event(
        id: testEventId,
        title: 'Test Event',
        description: 'Test Desc',
        organizationId: 'test_org',
        location: 'Online',
        imageUrl: 'https://example.com/image.jpg',
        date: now,
        startTime: now,
        endTime: now.add(Duration(hours: 2)),
        maxParticipants: 20,
        createdAt: now,
        updatedAt: now,
      );

      await firestoreService.createUser(user.uid, user);
      await firestoreService.createEvent(event);
      await firestoreService.registerForEvent(event.id, user.uid);

      final updatedEvent = await firestoreService.getEvent(event.id);
      expect(updatedEvent?.registeredUsers, contains(user.uid));

      final updatedUser = await firestoreService.getUser(user.uid);
      expect(updatedUser?.eventsRegistered, contains(event.id));
    });
  });
}
