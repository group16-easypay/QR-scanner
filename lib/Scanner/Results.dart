import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sm/Master/Header.dart';

class Results extends StatefulWidget {
  final String data;
  const Results({Key? key, required this.data}) : super(key: key);

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  // double total = 100;
  @override
  Widget build(BuildContext context) {
    var result = json.decode(widget.data);
    var details = json.decode(result['details']);
    var user = json.decode(result['user']);
    double sum = 0;
    for (int i = 0; i < user.length; i++) {
      sum += json.decode(user[i]['price'].replaceFirst("Shs", ""));
    }
    var appText = Theme.of(context).textTheme.headline5;
    // ignore: unused_local_variable
    Size appSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Results"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Header(title: "User Details", appText: appText),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "Items",
                      style: appText!.copyWith(
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      "Price",
                      style: appText.copyWith(
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Expanded(
                  child: ListView(
                    children: List.generate(
                      user.length,
                      // ignore: prefer_const_constructors
                      (index) => ListTile(
                        title: Text("${user[index]['name']}"),
                        subtitle: Text("${user[index]['user']}"),
                        trailing: Text("${user[index]['price']}"),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Chip(
                        avatar: Icon(Icons.shopping_basket_rounded),
                        label: Text("Total")),
                    Chip(
                        avatar: const Icon(Icons.monetization_on_rounded),
                        label: Text("$sum")),
                  ],
                ),
              ),
              Header(title: "Payment Details", appText: appText),
              SizedBox(
                height: 250,
                child: Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        ListTile(
                          title: const Text("Tax Reference"),
                          trailing: Text("${details['tx_ref']}"),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Processor response"),
                          trailing: Text("${details['processor_response']}"),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Authentication Model"),
                          trailing: Text("${details['auth_model']}"),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Currency"),
                          trailing: Text("${details['currency']}"),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("User email"),
                          trailing: Text("${details['customer']['email']}"),
                        ),
                        ListTile(
                          title: const Text("Phone number"),
                          trailing:
                              Text("${details['customer']['phone_number']}"),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Amount Paid"),
                          trailing: Text("${details['amount']}"),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Transaction Made"),
                          trailing:
                              Text("${details['customer']['created_at']}"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "End of summary",
                      style: appText.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Back to scanner"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
