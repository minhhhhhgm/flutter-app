import 'dart:async';

import 'package:flutter_application_1/screens/account/account_screen/bloc/account_event.dart';
import 'package:flutter_application_1/screens/account/account_screen/bloc/account_state.dart';
import 'package:flutter_application_1/screens/account/account_screen/model/account_model.dart';
import 'package:flutter_application_1/screens/account/account_screen/model/list_account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountBloc {
  var state = AccountState(accountModel: null);

  final accountEvent = StreamController<AccountEvent>();
  final accountState = StreamController<AccountState>();
  final accountListState = StreamController<ListAccountState>();

  AccountBloc() {
    accountEvent.stream.listen((event) async {
      if (event is GetCurrentUser) {
        try {
          final url =
              Uri.parse('http://10.22.20.8:4000/api/users/currentUser');
          final response = await http.get(url, headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDhjZmY3M2MwM2YwZDJiZmMwMDgxNyIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCR4Rnk5NWJoTkNFUjB3a01ZOG5DeHplZkplcmg0Q3hBZXAvM1ZvWmtVLnM5NWxFOXFTbS53UyIsImVtYWlsIjoib2MzQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbXSwiZm9sbG93aW5nIjpbXSwiY3JlYXRlZEF0IjoiMjAyNC0xMC0xMVQwNzoxMjo1NS42NTdaIiwidXBkYXRlZEF0IjoiMjAyNC0xMC0xMVQwOTo1NDo0NC4wODZaIiwiX192IjowfSwiaWF0IjoxNzMwNzA3ODYzLCJleHAiOjE3MzE1NzE4NjN9.QiBjBeGdnmjDF5y167MvNk0XUxUQFA1V9ywpb1QSwRQ"
          });

          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final accountRes = AccountModel.fromJson(data);
            state = AccountState(accountModel: accountRes);
            accountState.sink.add(state);
          }
        } catch (e) {
          print(e);
        }
      }
      if (event is GetListUser) {
        try {
          final url = Uri.http(
              '10.22.20.8:4000', '/api/users', {'size': '${event.size}'});
          final response = await http.get(
            url,
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDhjZmY3M2MwM2YwZDJiZmMwMDgxNyIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCR4Rnk5NWJoTkNFUjB3a01ZOG5DeHplZkplcmg0Q3hBZXAvM1ZvWmtVLnM5NWxFOXFTbS53UyIsImVtYWlsIjoib2MzQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbXSwiZm9sbG93aW5nIjpbXSwiY3JlYXRlZEF0IjoiMjAyNC0xMC0xMVQwNzoxMjo1NS42NTdaIiwidXBkYXRlZEF0IjoiMjAyNC0xMC0xMVQwOTo1NDo0NC4wODZaIiwiX192IjowfSwiaWF0IjoxNzMwNzA3ODYzLCJleHAiOjE3MzE1NzE4NjN9.QiBjBeGdnmjDF5y167MvNk0XUxUQFA1V9ywpb1QSwRQ"
            },
          );

          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final accountRes = ListAccount.fromJson(data);

            var stateListAccount = ListAccountState(listAccount: accountRes);
            accountListState.sink.add(stateListAccount);
          }
        } catch (e) {
          print('e $e');
        }
      }
    });
  }

  void dispose() {
    accountEvent.close();
    accountState.close();
    accountListState.close();
  }
}
