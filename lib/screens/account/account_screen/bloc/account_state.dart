
import 'package:flutter_application_1/screens/account/account_screen/model/account_model.dart';
import 'package:flutter_application_1/screens/account/account_screen/model/list_account.dart';

abstract class RootAccountState{}

class AccountState extends RootAccountState{
  AccountState({required this.accountModel});
  final AccountModel? accountModel;

}


class ListAccountState extends RootAccountState{
  ListAccountState({required this.listAccount});
  final ListAccount listAccount;

}