import 'package:equatable/equatable.dart';

import '../event_detail_model.dart';

class EventJoinResponseModel extends Equatable {
  const EventJoinResponseModel({
    this.message = '',
    required this.eventDetail,
  });

  final String message;
  final EventDetailModel eventDetail;
  EventJoinResponseModel copyWith({
    String? message,
    EventDetailModel? eventDetail,
  }) {
    return EventJoinResponseModel(
      message: message ?? this.message,
      eventDetail: eventDetail ?? this.eventDetail,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, eventDetail];
}
