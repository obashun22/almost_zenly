import 'package:almost_zenly/types/image_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String blankImage =
    'https://firebasestorage.googleapis.com/v0/b/gs-expansion-test.appspot.com/o/unknown_person.png?alt=media';

class AppUser {
  AppUser({
    this.id,
    this.name = '',
    this.profile = '',
    this.imageUrl = blankImage,
    this.location,
  });

  final String? id;
  final String name;
  final String profile;
  final String imageUrl;
  final GeoPoint? location;

  factory AppUser.fromDoc(String id, Map<String, dynamic> doc) => AppUser(
        id: id,
        name: doc['name'],
        profile: doc['profile'],
        imageUrl: doc['image_url'] ?? blankImage,
        location: doc['location'],
      );
}
