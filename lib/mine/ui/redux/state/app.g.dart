// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

abstract class $AppState {
  String get version;
  const $AppState();
  AppState copyWith({String version}) =>
      AppState(version: version ?? this.version);
  String toString() => "AppState(version: $version)";
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType && version == other.version;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + version.hashCode;
    return result;
  }
}

class AppState$ {
  static final version = Lens<AppState, String>(
      (s_) => s_.version, (s_, version) => s_.copyWith(version: version));
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    version: json['version'] as String,
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'version': instance.version,
    };
