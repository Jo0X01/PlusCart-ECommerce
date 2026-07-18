

import 'package:plus_cart/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

UserEntity userToEntityMapper(User user){
  final metadata = user.userMetadata ?? {};
  return UserEntity(
    id: user.id,
    email: user.email ?? metadata['email'] ?? '',
    fullName: metadata['full_name'] ?? metadata['name'],
    avatar: metadata['avatar_url'] ?? metadata['picture'],
    phone: user.phone,
    emailVerified: user.emailConfirmedAt != null,
    phoneVerified: user.phoneConfirmedAt != null,
    providers: (user.appMetadata['providers'] as List?)?.cast<String>() ?? [],
  );
}