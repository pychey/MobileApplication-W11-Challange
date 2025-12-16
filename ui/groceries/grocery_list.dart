import 'package:flutter/material.dart';
import 'package:myapp/W12-Flutter-Theory/models/grocery.dart';

class GroceryList extends StatefulWidget {
  final List<Grocery> initializeGrocery;

  const GroceryList({super.key, required this.initializeGrocery});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<Grocery> get grocery => widget.initializeGrocery;


  void onCreate() {
    // TODO-4 - Navigate to the form screen using the Navigator push 
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (grocery.isNotEmpty) {

       // TODO-1 - Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount:grocery.length, 
        itemBuilder: (BuildContext cotntext, int index) {
          return GroceryTile(grocery: grocery[index]);
        }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
      // TODO-2 - Display groceries with an Item builder and  LIst Tile
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListTile(
        leading: Container(width: 30, height: 30, color: grocery.category.color),
        title: Text(grocery.name),
        trailing: Text(grocery.quantity.toString()),
      ),
    );
  }
}
