import 'dart:convert';

import 'package:http/http.dart' as http;

class PaymentLinkService {
  String costumerName;
  double valueOfPayment;
  double shippingPrice;
  String description;

  PaymentLinkService(this.costumerName, this.description, this.valueOfPayment,
      this.shippingPrice);

  static const API_KEY = "ak_test_kE5uZMhfqvcywrrF2K6bYFSkZGGdlf";

  Future<String> createRequest() async {

    int vp = int.parse(valueOfPayment.toStringAsFixed(2).replaceAll(new RegExp('\\.'),''));
    int sp = int.parse(shippingPrice.toStringAsFixed(2).replaceAll(new RegExp('\\.'),''));

    String paymentLink;
    var headers = {
      'content-type': 'application/json',
    };

    var data = jsonEncode({
      "api_key": API_KEY,
      "amount":  vp + sp,
      "items": [
        {
          "id": "1",
          "title": description,
          "unit_price": vp,
          "quantity": 1,
          "tangible": true
        },
        {
          "id": "2",
          "title": "Frete",
          "unit_price": sp,
          "quantity": 1,
          "tangible": true
        }
      ],
      "payment_config": {
        "boleto": {"enabled": true, "expires_in": 20},
        "credit_card": {
          "enabled": true,
          "free_installments": 4,
          "interest_rate": 25,
          "max_installments": 12
        },
        "default_payment_method": "boleto"
      },
      "postback_config": {
        "orders": "http://postback.url/orders",
        "transactions": "http://postback.url/transactions"
      },
      "max_orders": 1,
      "expires_in": 60
    });

    var res = await http.post('https://api.pagar.me/1/payment_links',
        headers: headers, body: data);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    Map<String, dynamic> result = jsonDecode(res.body);
    paymentLink = result["url"];
    
    return paymentLink;
  }
}
