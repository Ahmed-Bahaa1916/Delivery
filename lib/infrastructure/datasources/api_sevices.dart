import 'package:dio/dio.dart';
import '../models/order_model.dart';

class OrderService {
  final Dio _dio = Dio();

  Future<List<OrderModel>> getOrders() async {
    const url =
        "http://mdev.yemensoft.net:8087/OnyxDeliveryService/Service.svc/GetDeliveryBillsItems";

    final body = {
      "Value": {
        "P_DLVRY_NO": "1010",
        "P_LANG_NO": "1",
        "P_BILL_SRL": "",
        "P_PRCSSD_FLG": "",
      },
    };

    try {
      final response = await _dio.post(url, data: body);

      print("==== API RESPONSE ====");
      print(response.data);

      final bills = response.data["Data"]?["DeliveryBills"];
      if (bills != null && bills is List) {
        return bills.map((e) => OrderModel.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  Future<bool> checkDeliveryLogin({
    required String userId,
    required String password,
    required int languageNo,
  }) async {
    const url =
        "http://mdev.yemensoft.net:8087/OnyxDeliveryService/Service.svc/CheckDeliveryLogin";

    final body = {
      "Value": {
        "P_DLVRY_NO": userId,
        "P_PSSWRD": password,
        "P_LANG_NO": languageNo.toString(),
      },
    };

    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("==== LOGIN RESPONSE ====");
      print(response.data);

      final errNo = response.data["Result"]?["ErrNo"];
      return errNo == 0;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }
}
