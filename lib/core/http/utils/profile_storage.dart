import 'package:get_storage/get_storage.dart';
import 'package:tcc_le_app/core/domain/user_profile.dart';

class ProfileStorage {
  final GetStorage _storage = GetStorage("user");
  final key = 'profile';

  void clear() async {
    await _storage.erase();
  }

  UserProfile? fetch() {
    var json = _storage.read(key);

    if (json == null || json == "") {
      return null;
    }

    return UserProfile.fromJson(json);
  }

  UserProfile save(UserProfile data) {
    _storage.write(key, data.toJson());
    return data;
  }
}
