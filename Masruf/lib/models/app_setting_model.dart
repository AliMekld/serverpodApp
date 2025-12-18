import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_setting_model.g.dart';

@CopyWith()
@JsonSerializable()
class AppSettings {
  final String? appName;
  final String? schema;
  final String? host;
  final String? path;
 const AppSettings({
    this.appName,
    this.path,
    this.host,
    this.schema,
  });
  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);

  ///
  String get baseUrl => Uri(
        host: host,
        scheme: schema,
        path: path,
      ).toString();
}
