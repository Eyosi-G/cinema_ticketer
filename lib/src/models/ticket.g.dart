// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return Ticket(
    amountPaid: (json['amount_paid'] as num)?.toDouble(),
    approved: json['approved'] as bool,
    approvedBy: json['approvedBy'] as String,
    cinemaHall: json['cinema_hall_name'] as String,
    movie: json['movie'] == null
        ? null
        : Movie.fromJson(json['movie'] as Map<String, dynamic>),
    scheduleDateTime: json['schedule_date_time'] as String,
    screen: json['screen'] as String,
    seats: (json['seats'] as List)
        ?.map(
            (e) => e == null ? null : Seat.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..id = json['id'] as String;
}

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'schedule_date_time': instance.scheduleDateTime,
      'cinema_hall_name': instance.cinemaHall,
      'amount_paid': instance.amountPaid,
      'movie': instance.movie,
      'screen': instance.screen,
      'seats': instance.seats,
      'approved': instance.approved,
      'approvedBy': instance.approvedBy,
    };
