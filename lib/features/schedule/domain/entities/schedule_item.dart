import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_item.freezed.dart';
part 'schedule_item.g.dart';

@freezed
class ScheduleItem with _$ScheduleItem {
  const ScheduleItem._();
  const factory ScheduleItem({
    required String id,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
  }) = _ScheduleItem;

  factory ScheduleItem.fromJson(Map<String, dynamic> json) => _$ScheduleItemFromJson(json);

  @override
  // TODO: implement description
  String? get description => throw UnimplementedError();

  @override
  // TODO: implement endTime
  DateTime get endTime => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement startTime
  DateTime get startTime => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
} 