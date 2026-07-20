import 'package:plus_cart/core/services/supabase_service.dart';
import 'package:plus_cart/features/onboarding/data/data_source/remote/remote_app_startup_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteAppStartupDataSourceImp implements RemoteAppStartupDataSource {
  final SupabaseService supabaseService;

  RemoteAppStartupDataSourceImp({
    required this.supabaseService
  });
  
  @override
  Future<User?> getCurrentUser() async {
    return supabaseService.auth.currentUser;
  }
  
  @override
  Future<bool> isLoggedIn() async {
    return await supabaseService.isLoggedIn();
  }
  
  @override
  Future<bool> isLoggedOut() async {
    return await supabaseService.isLoggedOut();
  }
}
