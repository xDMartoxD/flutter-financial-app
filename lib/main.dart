import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorials/utils/availableSize.dart';
import 'package:tutorials/widgets/chart.dart';
import 'package:tutorials/widgets/new_transaction.dart';
import 'Models/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        backgroundColor: Colors.black87,
        primarySwatch: Colors.purple,
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
        colorScheme: const ColorScheme(
          primary: Colors.purple,
          brightness: Brightness.dark,
          onPrimary: Colors.white,
          secondary: Colors.pink,
          onSecondary: Colors.white,
          background: Colors.black87,
          error: Colors.red,
          onError: Colors.white,
          onBackground: Colors.white,
          surface: Color.fromRGBO(33, 33, 33, 1),
          onSurface: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          titleTextStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'Nuevos Zapatos', amount: 90, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Mercado', amount: 030, date: DateTime.now())
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLS = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Hola"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text("Home"),
            actions: [
              IconButton(
                  onPressed: () => _startNewTransaction(context),
                  icon: Icon(Icons.add))
            ],
          ) as PreferredSizeWidget;
    final tsList = SizedBox(
      height: AvailableSize.height(context, appBar) * 0.75,
      child: TransactionList(
          _userTransactions.reversed.toList(), _deleteTransaction),
    );
    final body = SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLS)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Mostrar grafica"),
                Switch.adaptive(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  value: _showChart,
                  onChanged: (value) {
                    setState(
                      () {
                        _showChart = value;
                      },
                    );
                  },
                ),
              ],
            ),
          if (!isLS)
            SizedBox(
              height: AvailableSize.height(context, appBar) * 0.25,
              child: Chart(_recentTransactions),
            ),
          if (!isLS) tsList,
          if (isLS)
            _showChart
                ? SizedBox(
                    height: AvailableSize.height(context, appBar) * 0.7,
                    child: Chart(_recentTransactions),
                  )
                : tsList,
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: body,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _startNewTransaction(context),
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation: Platform.isAndroid
                ? FloatingActionButtonLocation.centerFloat
                : null,
          );
  }
}
