// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    _NotificationDto(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      priority: json['priority'] as String?,
      actionUrl: json['actionUrl'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      sender: json['sender'] == null
          ? null
          : NotificationSenderDto.fromJson(
              json['sender'] as Map<String, dynamic>,
            ),
      data: json['data'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$NotificationDtoToJson(_NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'message': instance.message,
      'priority': instance.priority,
      'actionUrl': instance.actionUrl,
      'isRead': instance.isRead,
      'readAt': instance.readAt?.toIso8601String(),
      'sender': instance.sender,
      'data': instance.data,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_NotificationSenderDto _$NotificationSenderDtoFromJson(
  Map<String, dynamic> json,
) => _NotificationSenderDto(
  id: json['id'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$NotificationSenderDtoToJson(
  _NotificationSenderDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatar': instance.avatar,
};

_UnreadCountDto _$UnreadCountDtoFromJson(Map<String, dynamic> json) =>
    _UnreadCountDto(unreadCount: (json['unreadCount'] as num).toInt());

Map<String, dynamic> _$UnreadCountDtoToJson(_UnreadCountDto instance) =>
    <String, dynamic>{'unreadCount': instance.unreadCount};
