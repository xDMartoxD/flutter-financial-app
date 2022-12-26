import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) deleteTransactionHandler;
  const TransactionList(this.transactions, this.deleteTransactionHandler,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: ((p0, p1) => Column(
                    children: [
                      Text(
                        "No hay transacciones",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: p1.maxHeight * .6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  )),
            )
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                                child: Text("\$${transactions[index].amount}")),
                          ),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                        ),
                        trailing: MediaQuery.of(context).size.width > 360
                            ? TextButton.icon(
                                onPressed: () => deleteTransactionHandler(
                                  transactions[index].id,
                                ),
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                label: Text("Delete",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error)),
                              )
                            : IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => deleteTransactionHandler(
                                    transactions[index].id),
                                color: Theme.of(context).colorScheme.error,
                              )));
              }),
              itemCount: transactions.length,
            ),
    );
  }
}
