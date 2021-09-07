import '../data_providers/data_provider.dart';

class ApproveTicketRepository {
  final ApproveTicketDataProvider _approveTicketDataProvider;
  ApproveTicketRepository(this._approveTicketDataProvider);

  Future approveTicket(String id) {
    return _approveTicketDataProvider.approveTicket(id);
  }
}
