import 'package:cinema_ticketer/src/models/models.dart';

abstract class SearchTicketState {}

class SearchTicketInitialState extends SearchTicketState {}

class SearchTicketStateLoading extends SearchTicketState {}

class SearchTicketStateSuccess extends SearchTicketState {
  final Ticket ticket;
  SearchTicketStateSuccess(this.ticket);
}

class SearchTicketStateFailure extends SearchTicketState {
  final String message;
  SearchTicketStateFailure(this.message);
}
