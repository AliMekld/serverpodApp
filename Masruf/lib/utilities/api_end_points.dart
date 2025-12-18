import '../models/app_setting_model.dart';
import 'git_it.dart';

class ApiEndPoint {
  static final AppSettings _appSettings = GitIt.appSettingsGit;
  static String get _baseUrl => _appSettings.baseUrl;
  static String get products => '$_baseUrl/products';

  static Uri uri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      Uri(
        host: GitIt.appSettingsGit.host,
        scheme: GitIt.appSettingsGit.schema,
        path: path,
        queryParameters: queryParameters,
      );
}
