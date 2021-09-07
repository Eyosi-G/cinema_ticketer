import '../data_providers/data_provider.dart';
import '../models/ticket.dart';

class SearchTicketRepository {
  final SearchTicketDataProvider _searchTicketDataProvider;
  SearchTicketRepository(this._searchTicketDataProvider);
  Future<Ticket> searchTicket(String code) async {
    final Map<String, dynamic> json =
        await _searchTicketDataProvider.searchTicket(code);
    return Ticket.fromJson(json);
  }
}
