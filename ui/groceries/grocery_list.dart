import 'package:flutter/material.dart';
import 'package:myapp/W12-Flutter-Theory/models/grocery.dart';
import 'package:myapp/W12-Flutter-Theory/ui/groceries/grocery_form.dart';

class GroceryList extends StatefulWidget {
  final List<Grocery> initializeGrocery;

  const GroceryList({super.key, required this.initializeGrocery});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<Grocery> get grocery => widget.initializeGrocery;


  void onCreate() async {
    final newGrocery = await Navigator.push(context, MaterialPageRoute(builder: (context) => const NewItem()));

    if (newGrocery != null) {
      setState(() {
        grocery.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (grocery.isNotEmpty) {
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
            onPressed: onCreate,
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
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListTile(
        leading: Container(width: 15, height: 15, color: grocery.category.color),
        title: Text(grocery.name, style: Theme.of(context).textTheme.bodyMedium),
        trailing: Text(grocery.quantity.toString()),
        onTap: () {},
      ),
    );
  }
}
