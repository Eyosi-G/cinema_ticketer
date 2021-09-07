abstract class ApproveTicketState {}

class ApproveTicketSuccess extends ApproveTicketState {}

class ApproveTicketFailure extends ApproveTicketState {
  final String message;
  ApproveTicketFailure(this.message);
}

class ApproveTicketStarted extends ApproveTicketState {}

class ApproveTicketInitialState extends ApproveTicketState {}
