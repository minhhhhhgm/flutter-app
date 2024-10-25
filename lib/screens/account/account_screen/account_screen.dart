import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/account/account_list/account_list_screen.dart';
import 'package:flutter_application_1/screens/account/account_screen/bloc/account_bloc.dart';
import 'package:flutter_application_1/screens/account/account_screen/bloc/account_event.dart';
import 'package:flutter_application_1/screens/account/account_screen/bloc/account_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final bloc = AccountBloc();

  @override
  void initState() {
    bloc.accountEvent.add(GetCurrentUser());
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Account Screen'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/03/anh-meme-hai-10.jpg.webp'),
                  ),
                ),
              ),
               Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Name : '), Text('account?.name')],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Email : '), Text('account?.name}')],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              StreamBuilder(
                  stream: bloc.accountState.stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<AccountState> snapshot) {
                    final account = snapshot.data?.accountModel;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Name : '),
                              Text('${account?.name}')
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Email : '),
                              Text('${account?.email}')
                            ],
                          )
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountListScreen()));
                  },
                  child: const Text('Get All Users'))
            ],
          ),
        ),
      ),
    );
  }
}
