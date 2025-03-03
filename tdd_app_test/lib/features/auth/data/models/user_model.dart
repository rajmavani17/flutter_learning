import 'dart:convert';

import 'package:tdd_app_test/core/utils/typedef.dart';
import 'package:tdd_app_test/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar,
  });

  UserModel.fromMap(StringMap map)
      : this(
          avatar: map['avatar'] as String,
          id: map['id'] as String,
          name: map['name'] as String,
          createdAt: map['createdAt'] as String,
        );

  factory UserModel.fromJson(String src) =>
      UserModel.fromMap(jsonDecode(src) as StringMap);

  UserModel copyWith({
    String? name,
    String? avatar,
    String? id,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id ,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      avatar: avatar ?? this.avatar,
    );
  }

  StringMap toMap() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'avatar': avatar,
      };

  String toJson() => json.encode(toMap());
}
