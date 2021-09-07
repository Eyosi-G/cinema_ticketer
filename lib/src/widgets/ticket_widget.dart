import 'package:cinema_ticketer/src/data_providers/data_provider.dart';
import 'package:cinema_ticketer/src/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import 'package:intl/intl.dart';
import '../bloc/bloc.dart';

class TicketWidget extends StatelessWidget {
  final ApproveTicketBloc approveTicketBloc =
      ApproveTicketBloc(ApproveTicketRepository(ApproveTicketDataProvider()));
  final Ticket ticket;
  TicketWidget(this.ticket);

  approveTicket() {
    approveTicketBloc.add(ApproveTicketEvent(ticket.id));
  }

  String convertSeatsToString(List<Seat> seats) {
    String text = "";
    int count = 0;
    seats.forEach((seat) {
      text += seat.seatName;
      if (count < seats.length - 1) {
        text += ", ";
      }
      count += 1;
    });
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Table(
          children: [
            TableRow(
              children: [
                Text(
                  '${ticket.movie.title} | ${ticket.screen}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('')
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Schedule',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '${DateFormat.yMMMd().add_jm().format(DateTime.parse(ticket.scheduleDateTime))}',
                ),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Seats',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text('${convertSeatsToString(ticket.seats)}'),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Cinema',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text('${ticket.cinemaHall}'),
              ],
            ),
            TableRow(
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text('${ticket.amountPaid} ETB'),
              ],
            ),
            TableRow(
              children: [
                Text(''),
                Text(''),
              ],
            ),
          ],
        ),
        ticket.approved
            ? ElevatedButton.icon(
                label: Text('Approved'),
                icon: Icon(Icons.check),
                onPressed: () {},
              )
            : BlocBuilder<ApproveTicketBloc, ApproveTicketState>(
                bloc: approveTicketBloc,
                builder: (ctx, state) {
                  if (state is ApproveTicketStarted) {
                    return ElevatedButton(
                      child: Text('loading ...'),
                      onPressed: () {},
                    );
                  }
                  if (state is ApproveTicketSuccess) {
                    return ElevatedButton.icon(
                      label: Text('Approved'),
                      icon: Icon(Icons.check),
                      onPressed: () {},
                    );
                  }
                  if (state is ApproveTicketFailure) {
                    return ElevatedButton.icon(
                      label: Text('Retry'),
                      icon: Icon(Icons.error),
                      onPressed: approveTicket,
                    );
                  }

                  return ElevatedButton(
                    child: Text('Approve'),
                    onPressed: approveTicket,
                  );
                },
              )
      ],
    );
  }
}
