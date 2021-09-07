import '../../models/models.dart';

abstract class SearchTicketEvents {}

class SearchTicket extends SearchTicketEvents {
  final String code;
  SearchTicket(this.code);
}

class SetTicket extends SearchTicketEvents {
  final Ticket ticket;
  SetTicket(this.ticket);
}
