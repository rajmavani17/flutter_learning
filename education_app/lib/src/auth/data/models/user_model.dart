import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.profilePic,
    super.bio,
    super.groupIds,
    super.enrolledCoursedIds,
    super.following,
    super.followers,
  });
  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
        );

  LocalUserModel.fromMap(Map<String, dynamic> map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          groupIds: List<String>.from(map['groupIds'] as List<dynamic>)
              .cast<String>(),
          enrolledCoursedIds:
              List<String>.from(map['enrolledCoursedIds'] as List<dynamic>)
                  .cast<String>(),
          following: List<String>.from(map['following'] as List<dynamic>)
              .cast<String>(),
          followers: List<String>.from(map['followers'] as List<dynamic>)
              .cast<String>(),
        );
  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'points': points,
      'fullName': fullName,
      'profilePic': profilePic,
      'bio': bio,
      'groupIds': groupIds,
      'enrolledCoursedIds': enrolledCoursedIds,
      'following': following,
      'followers': followers,
      
    };
  }
}
