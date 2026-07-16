
import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends UserEntity {
  final String? cId;
  final String? name;
  final String? userEmail;
  final String? cAvatar;
  UserModel({this.cId, this.name, this.userEmail, this.cAvatar}): super(
    id: cId,
    email: userEmail,
    fullName: name,
    avatar: cAvatar
  );

  factory UserModel.fromSupabase(User? user){
    return UserModel(
      cId: user?.id,
      name: user?.userMetadata?["fullName"],
      userEmail: user?.email,
      cAvatar: user?.userMetadata?["avatar"]
    );
  }
}