import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

@freezed
class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    required String type,
    required String title,
    required String message,
    String? priority,
    String? actionUrl,
    @Default(false) bool isRead,
    DateTime? readAt,
    NotificationSenderDto? sender,
    Map<String, dynamic>? data,
    DateTime? createdAt,
  }) = _NotificationDto;

  factory NotificationDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationDtoFromJson(json);
}

@freezed
class NotificationSenderDto with _$NotificationSenderDto {
  const factory NotificationSenderDto({
    required String id,
    String? firstName,
    String? lastName,
    String? avatar,
  }) = _NotificationSenderDto;

  factory NotificationSenderDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationSenderDtoFromJson(json);
}

@freezed
class UnreadCountDto with _$UnreadCountDto {
  const factory UnreadCountDto({
    required int unreadCount,
  }) = _UnreadCountDto;

  factory UnreadCountDto.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountDtoFromJson(json);
}
