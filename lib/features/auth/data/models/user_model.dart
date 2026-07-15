
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  final String? id;
  final String? name;
  final String? userEmail;
  final String? avatar;
  UserModel({this.id, this.name, this.userEmail, this.avatar}): super(
    id: id,
    email: userEmail,
    fullName: name,
    avatar: avatar
  );

  factory UserModel.fromSupabase(User? user){
    return UserModel(
      id: user?.id,
      name: user?.userMetadata?["fullName"],
      userEmail: user?.email,
      avatar: user?.userMetadata?["avatar"]
    );
  }
}