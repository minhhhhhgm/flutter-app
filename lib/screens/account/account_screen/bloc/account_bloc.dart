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
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDY0MTkxN2Y4OTAwMTUxODcyMTc3ZSIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCQxQmlJV21LOUZhMGZxWmVIeFgzN3Uubmxyb245dEU3REhMRk1pQ3F6QkU4RmJOZ1pTMnNCVyIsImVtYWlsIjoib2MxQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbIjY3MDY1N2ZhN2Y4OTAwMTUxODcyMTc5OCJdLCJmb2xsb3dpbmciOltdLCJjcmVhdGVkQXQiOiIyMDI0LTEwLTA5VDA4OjQwOjQ5LjgyMloiLCJ1cGRhdGVkQXQiOiIyMDI0LTEwLTExVDEwOjA2OjIyLjY0OVoiLCJfX3YiOjB9LCJpYXQiOjE3Mjk0OTE1MjQsImV4cCI6MTczMDM1NTUyNH0.Vuaovk9qV8fDgS3aVly6agUCb1HIy7wUCcFJrDSHHZE"
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
                  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Il9pZCI6IjY3MDY0MTkxN2Y4OTAwMTUxODcyMTc3ZSIsIm5hbWUiOiJvYyBjaMOzIDIiLCJwYXNzd29yZCI6IiQyYiQxMCQxQmlJV21LOUZhMGZxWmVIeFgzN3Uubmxyb245dEU3REhMRk1pQ3F6QkU4RmJOZ1pTMnNCVyIsImVtYWlsIjoib2MxQGV4YW1wbGUuY29tIiwiZGV2aWNlc1Rva2VuIjpbXSwiZm9sbG93ZXJzIjpbIjY3MDY1N2ZhN2Y4OTAwMTUxODcyMTc5OCJdLCJmb2xsb3dpbmciOltdLCJjcmVhdGVkQXQiOiIyMDI0LTEwLTA5VDA4OjQwOjQ5LjgyMloiLCJ1cGRhdGVkQXQiOiIyMDI0LTEwLTExVDEwOjA2OjIyLjY0OVoiLCJfX3YiOjB9LCJpYXQiOjE3Mjk0OTE1MjQsImV4cCI6MTczMDM1NTUyNH0.Vuaovk9qV8fDgS3aVly6agUCb1HIy7wUCcFJrDSHHZE"
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
