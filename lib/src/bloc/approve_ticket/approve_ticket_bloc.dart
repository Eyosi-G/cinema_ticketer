import 'package:flutter_bloc/flutter_bloc.dart';

import 'approve_ticket.dart';
import '../../repositories/repositories.dart';

class ApproveTicketBloc extends Bloc<ApproveTicketEvent, ApproveTicketState> {
  ApproveTicketRepository _approveTicketRepository;
  ApproveTicketBloc(this._approveTicketRepository)
      : super(ApproveTicketInitialState());

  @override
  Stream<ApproveTicketState> mapEventToState(ApproveTicketEvent event) async* {
    try {
      yield ApproveTicketStarted();
      _approveTicketRepository.approveTicket(event.id);
      yield ApproveTicketSuccess();
    } catch (e) {
      yield ApproveTicketFailure("approving ticket failed!");
    }
  }
}
