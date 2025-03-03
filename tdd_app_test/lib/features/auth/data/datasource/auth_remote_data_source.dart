import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tdd_app_test/core/errors/exceptions.dart';

import 'package:tdd_app_test/core/utils/constants.dart';
import 'package:tdd_app_test/core/utils/typedef.dart';
import 'package:tdd_app_test/features/auth/data/models/user_model.dart';

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/users';

abstract class AuthRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  Future<List<UserModel>> getUsers();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  }) async {
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode(
          {
            'name': name,
            'createdAt': createdAt,
          },
        ),
        headers: {
          'Content-Type': 'Application/json',
        },
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(response.body, response.statusCode);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString(), 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await http.get(Uri.https(kBaseUrl, kGetUsersEndpoint));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(response.body, response.statusCode);
      }
      return List<StringMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(e.toString(), 505);
    }
  }
}
