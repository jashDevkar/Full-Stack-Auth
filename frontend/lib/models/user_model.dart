// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? name;
  final String? email;
  final String? password;
  final String? token;
  final String? id;

  UserModel({ this.name,  this.email,  this.password,  this.token,  this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      token: map['token'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? token,
    String? id,
  }) {
    return UserModel(
      name: this.name!.isEmpty?name:'',
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      id: id ?? this.id,
    );
  }
}
