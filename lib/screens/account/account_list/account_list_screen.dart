import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/account/account_screen/bloc/account_bloc.dart';
import 'package:flutter_application_1/screens/account/account_screen/bloc/account_event.dart';
import 'package:flutter_application_1/screens/account/account_screen/bloc/account_state.dart';

class AccountListScreen extends StatefulWidget {
  const AccountListScreen({super.key});

  @override
  State<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends State<AccountListScreen> {
  final bloc = AccountBloc();

  @override
  void initState() {
    bloc.accountEvent.add(GetListUser(size: 20));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account List Screen'),
      ),
      body: StreamBuilder(
        stream: bloc.accountListState.stream,
        builder:
            (BuildContext context, AsyncSnapshot<ListAccountState> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final accountList = snapshot.data?.listAccount.users;
          return ListView.separated(
              itemCount: accountList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final data = accountList?[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/03/anh-meme-hai-10.jpg.webp'),
                        ),
                      ),
                      const SizedBox(width: 25,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data!.email.toString()),
                          Text(data.name.toString()),
                  
                        ],
                      )
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) { 
                return const SizedBox(height: 15,);
               },);
        },
      ),
    );
  }
}
