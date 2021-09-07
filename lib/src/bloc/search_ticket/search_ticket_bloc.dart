import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_ticket.dart';
import '../../repositories/repositories.dart';

class SearchTicketBloc extends Bloc<SearchTicketEvents, SearchTicketState> {
  final SearchTicketRepository _searchTicketRepository;
  SearchTicketBloc(this._searchTicketRepository)
      : super(SearchTicketInitialState());

  @override
  Stream<SearchTicketState> mapEventToState(SearchTicketEvents event) async* {
    if (event is SearchTicket) {
      try {
        print(event.code);
        yield SearchTicketStateLoading();
        final ticket = await _searchTicketRepository.searchTicket(event.code);
        yield SearchTicketStateSuccess(ticket);
      } catch (e) {
        yield SearchTicketStateFailure("ticket doesn't exist!");
      }
    }
  }
}
