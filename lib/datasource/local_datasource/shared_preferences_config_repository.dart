import 'package:organizzer/repositories/i_config_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConfigRepository implements IConfigRepository {
  final _key = 'Key@@Config-Nome';

  @override
  Future<String?> getNome() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  @override
  Future<void> setNome(String nome) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, nome);
  }
}
