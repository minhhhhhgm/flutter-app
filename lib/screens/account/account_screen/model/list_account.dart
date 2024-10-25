
import 'package:flutter_application_1/screens/account/account_screen/model/account_model.dart';

class ListAccount {
    ListAccount({
         this.totalUsers,
         this.totalPages,
         this.currentPage,
        required this.users,
    });

    final int? totalUsers;
    final int? totalPages;
    final int? currentPage;
    final List<AccountModel> users;

    factory ListAccount.fromJson(Map<String, dynamic> json){ 
        return ListAccount(
            totalUsers: json["totalUsers"],
            totalPages: json["totalPages"],
            currentPage: json["currentPage"],
            users: json["users"] == null ? [] : List<AccountModel>.from(json["users"]!.map((x) => AccountModel.fromJson(x))),
        );
    }

}