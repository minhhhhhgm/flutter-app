abstract class AccountEvent {}

class GetCurrentUser extends AccountEvent{

}

class GetListUser extends AccountEvent{
    final int size;
    GetListUser({required this.size});
}