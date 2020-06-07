import 'package:http/http.dart' as http;

void main() async {
  var headers = {
    'content-type': 'application/json',
  };

  var data = {
  "api_key": "SUA_API_KEY",
  "amount": 1000,
  "items": [
    {
      "id": "1",
      "title": "Bola de futebol",
      "unit_price": 400,
      "quantity": 1,
      "tangible": true
    },
    {
      "id": "a123",
      "title": "Caderno do Goku",
      "unit_price": 600,
      "quantity": 1,
      "tangible": true
    }
  ],
  "payment_config": {
    "boleto": {
      "enabled": true,
      "expires_in": 20
    },
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
   "customer_config":{  
      "customer":{  
         "external_id":"#123456789",
         "name":"Fulano",
         "type":"individual",
         "country":"br",
         "email":"fulano@email.com",
         "documents":[  
            {  
               "type":"cpf",
               "number":"71404665560"
            }
         ],
         "phone_numbers":[  
            "+5511999998888",
            "+5511888889999"
         ],
         "birthday":"1985-01-01"
      },
      "billing":{  
         "name":"Ciclano de Tal",
         "address":{  
            "country":"br",
            "state":"SP",
            "city":"São Paulo",
            "neighborhood":"Fulanos bairro",
            "street":"Rua dos fulanos",
            "street_number":"123",
            "zipcode":"05170060"
         }
      },
      "shipping":{  
         "name":"Ciclano de Tal",
         "fee":12345,
         "delivery_date":"2017-12-25",
         "expedited":true,
         "address":{  
            "country":"br",
            "state":"SP",
            "city":"São Paulo",
            "neighborhood":"Fulanos bairro",
            "street":"Rua dos fulanos",
            "street_number":"123",
            "zipcode":"05170060"
         }
      }
   },
  "max_orders": 1,

  "expires_in": 60
};

  var res = await http.post('https://api.pagar.me/1/payment_links', headers: headers, body: data);
  if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
  print(res.body);
}
