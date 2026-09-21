import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API configuration loaded from a local `.env` file at runtime.
///
/// `.env` is listed in `.gitignore` — it never reaches GitHub, so this is
/// safe for a source-only portfolio repo. The residual risk (a real,
/// published APK/IPA can be unzipped and the bundled .env read directly)
/// only matters once you actually distribute a built app to end users,
/// which isn't this project's situation.
class AppConfig {
  static String get newsApiBaseUrl => dotenv.env['API_URL'] ?? '';

  static String get newsApiKey => dotenv.env['API_KEY'] ?? '';
}
