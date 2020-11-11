import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上に表示される"debug"ラベルを消す
      debugShowCheckedModeBanner: false,
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

// TODOリスト画面用Widget
class TodoListPage extends StatelessWidget {

  // 作成したドキュメント一覧
  List<DocumentSnapshot> documentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOリスト'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('ドキュメント一覧取得'),
              onPressed: () {},
            ),
            Column(
              children: documentList.map((document) {
                return ListTile(
                  title: Text('${document['title']}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return TodoAddPage();
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// TODO追加画面用Widget
class TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO追加'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('タップで戻る'),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getTodoListRealtime(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('TODOアプリ'),
          ),
          backgroundColor: Colors.white,
          body: Consumer<MainModel>(builder: (context, model, child) {
            final todoList = model.todoList;
            return ListView(
              children: todoList
                  .map(
                      (todo) => ListTile(
                        title: Text(todo.title),
                      ),
                  )
                  .toList(),
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          drawer: Drawer(
            child: Center(
              child: Text('Drawer'),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Like'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                title: Text('Add'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.thumb_up),
                title: Text('Good'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
