part of 'get_all_product_bloc.dart';

@immutable
sealed class GetAllProductEvent {}

class DoGetAllProductEvent extends GetAllProductEvent {
  //karena tidak butuh inputan pada saat ambil data, fungsi class in hanya mentriger saja berbeda saat melakukan create product ada data yang harus di input
}
