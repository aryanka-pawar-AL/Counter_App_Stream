import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
part 'message.freezed.dart';

@freezed
abstract class Message with _$Message {
  const factory Message(
      {required String className,
      required String objectId,
      required DateTime createdAt,
      required DateTime updatedAt,
      required String message}) = _Message;

  static const String classNameKey = 'className';
  static const String objectIdKey = 'objectId';
  static const String createdAtKey = 'createdAt';
  static const String updatedAtKey = 'updatedAt';
  static const String messageKey = 'message';

  static Message fromParse(ParseObject parseObject) {
    return Message(
      className: parseObject.get<String>(classNameKey) ?? "NULL",
      objectId: parseObject.get<String>(objectIdKey)!,
      createdAt: parseObject.get<DateTime>(createdAtKey)!,
      updatedAt: parseObject.get<DateTime>(updatedAtKey)!,
      message: parseObject.get<String>(messageKey)!,
    );
  }
}
