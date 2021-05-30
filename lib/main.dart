import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/components/new_transaction.dart';
import 'package:test_app/models/transaction.model.dart';
import 'components/chart_transaction.dart';
import 'components/transaction_list.dart';

void main() {
  // how to stop rotation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ),
              ),
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transactions.where((tx) {
      return tx.dateAt.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        dateAt: date);
    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteNewTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _setShowChart(bool showChart) {
    setState(() {
      this._showChart = showChart;
    });
  }

  Widget _buildBody(context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (isLandscape) ...[
          Flexible(
            flex: 0,
            fit: FlexFit.loose,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Show Chart',
                    style: Theme.of(context).textTheme.headline6),
                Switch.adaptive(
                  activeColor: Theme.of(context).primaryColor,
                  value: _showChart,
                  onChanged: _setShowChart,
                ),
              ]),
            ),
          ),
          _showChart
              ? Flexible(
                  flex: 0,
                  fit: FlexFit.loose,
                  child: ChartTransaction(_recentTransaction))
              : Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: TransactionList(_transactions, _deleteNewTransaction)),
        ] else ...[
          Flexible(
              flex: 0,
              fit: FlexFit.loose,
              child: ChartTransaction(_recentTransaction)),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TransactionList(_transactions, _deleteNewTransaction)),
        ]
      ],
    );
  }

  Widget _buildAppBar(context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(widget.title),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () {
                  _startAddNewTransaction(context);
                },
              ),
            ]),
          )
        : AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _startAddNewTransaction(context);
                  }),
            ],
          );
  }

  @override
  Widget build(BuildContext buildContext) {
    final appBar = _buildAppBar(buildContext);
    final body = _buildBody(buildContext);
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar, child: SafeArea(child: body))
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(buildContext),
                  ),
          );
  }
}
