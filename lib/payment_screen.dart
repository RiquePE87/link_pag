import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:share/share.dart';
import 'payment_link_service.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    MoneyMaskedTextController valueController = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$ ');
    MoneyMaskedTextController shippingController = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$ ');
    TextEditingController paymentLinkController = TextEditingController();

    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Nome do Cliente"),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: "Descrição do Pedido"),
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: valueController,
            decoration: InputDecoration(hintText: "Valor do Pedido"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: shippingController,
            decoration: InputDecoration(hintText: "Frete"),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: paymentLinkController,
            decoration: InputDecoration(hintText: paymentLinkController.text),
            readOnly: true,
          ),
          SizedBox(
            height: 10.0,
          ),
          FlatButton(
            child: Text(
              "Gerar Link de Pagamento",
              style: TextStyle(fontSize: 16.0),
            ),
            onPressed: () {
              var teste = PaymentLinkService(
                  nameController.text,
                  descriptionController.text,
                  valueController.numberValue,
                  shippingController.numberValue);
              teste
                  .createRequest()
                  .then((value) => paymentLinkController.text = value);
            },
          ),
          FlatButton(
            child: Text("Compartilhar Link", style: TextStyle(fontSize: 16.0)),
            onPressed: () {
              Share?.share(paymentLinkController.text);
            },
          )
        ],
      ),
    );
  }
}
