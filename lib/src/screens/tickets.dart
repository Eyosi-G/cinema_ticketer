import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';
import '../repositories/repositories.dart';
import '../data_providers/data_provider.dart';

class Tickets extends StatefulWidget {
  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  SearchTicketBloc _ticketBloc;
  TextEditingController _controller;
  _searchTicket(String code) {
    _ticketBloc.add(SearchTicket(code));
  }

  @override
  void initState() {
    setState(() {
      _ticketBloc =
          SearchTicketBloc(SearchTicketRepository(SearchTicketDataProvider()));
      _controller = TextEditingController();
    });
    super.initState();
  }

  @override
  void dispose() {
    _ticketBloc.close();
    super.dispose();
  }

  _scanCode() async {
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
        "#000000",
        "Cancel",
        true,
        ScanMode.QR,
      );
      if (result != "-1") _searchTicket(result);
    } catch (e) {
      print('here');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code_scanner),
        onPressed: _scanCode,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIcon: Icon(Icons.search),
                          labelText: "search",
                          border: OutlineInputBorder(),
                        ),
                        controller: _controller,
                      ),
                      ElevatedButton(
                        child: Text('SEARCH'),
                        onPressed: () {
                          _searchTicket(_controller.text);
                          _controller.text = "";
                        },
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              BlocConsumer(
                bloc: _ticketBloc,
                listener: (ctx, state) {
                  if (state is SearchTicketStateFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (ctx, state) {
                  if (state is SearchTicketStateSuccess) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TicketWidget(state.ticket),
                      ),
                      margin: EdgeInsets.all(5),
                    );
                  }
                  if (state is SearchTicketStateLoading)
                    return Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  return Text("");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
