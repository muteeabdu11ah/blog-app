import 'package:fyp/core/common/entities/user.dart';

class UserModel extends UserData {
  UserModel({
    required super.name,
   required super.email,
    required super.id
    });

    factory UserModel.fromJson(Map<String,dynamic> map){
      return UserModel(name: map['name'] ?? '', email: map['email'] ??'', id: map['id']??'');
    }

    UserModel copyWith({
    String? name,
    String? email,
    String? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }
}
