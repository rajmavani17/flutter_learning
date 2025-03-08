// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.points,
    this.profilePic,
    this.bio,
    this.groupIds = const [],
    this.enrolledCoursedIds = const [],
    this.following = const [],
    this.followers = const [],
  });

  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          profilePic: '',
          bio: '',
          points: 0,
          fullName: '',
          groupIds: const [],
          enrolledCoursedIds: const [],
          followers: const [],
          following: const [],
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCoursedIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email,'
        ' bio: $bio, points: $points, fullName: $fullName';
  }
}
