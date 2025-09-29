import 'package:flutter_bloc/flutter_bloc.dart';
import '../infrastructure/datasources/api_sevices.dart';
import '../infrastructure/models/order_model.dart';
import 'cubit_model.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderService _orderService = OrderService();
  List<OrderModel> _allOrders = [];

  OrderCubit() : super(OrderInitial());

  void fetchOrders() async {
    emit(OrderLoading());
    try {
      _allOrders = await _orderService.getOrders();
      emit(OrderLoaded(_allOrders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  void filterOrders(String type) {
    if (_allOrders.isEmpty) return;

    List<OrderModel> filtered;

    if (type == "New") {
      filtered = _allOrders.where((order) => order.status == "0").toList();
    } else {
      filtered = _allOrders.where((order) => order.status != "0").toList();
    }

    emit(OrderLoaded(filtered));
  }
}
