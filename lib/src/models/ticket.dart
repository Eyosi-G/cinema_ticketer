import 'package:json_annotation/json_annotation.dart';

import './models.dart';
part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  String id;
  @JsonKey(name: 'schedule_date_time')
  final String scheduleDateTime;
  @JsonKey(name: 'cinema_hall_name')
  final String cinemaHall;
  @JsonKey(name: 'amount_paid')
  final double amountPaid;
  final Movie movie;
  final String screen;
  final List<Seat> seats;
  final bool approved;
  final String approvedBy;
  Ticket({
    this.amountPaid,
    this.approved,
    this.approvedBy,
    this.cinemaHall,
    this.movie,
    this.scheduleDateTime,
    this.screen,
    this.seats,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  Map<String, dynamic> toJson() => _$TicketToJson(this);
}
