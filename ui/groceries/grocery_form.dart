import 'package:flutter/material.dart';

import '../../models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();

  // Default settings
  static const defautName = "New grocery";
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    _nameController.text = defautName;
    _quantityController.text = defaultQuantity.toString();

    setState(() {
      _selectedCategory = defaultCategory;
    });
  }

  void onAdd() {
    if (!_formKey.currentState!.validate()) return;

    String name = _nameController.text;
    int quantity = int.tryParse(_quantityController.text) ?? defaultQuantity;
    GroceryCategory category = _selectedCategory;

    final newGrocery = Grocery(name: name, quantity: quantity, category: category);

    Navigator.pop(context, newGrocery);
  }

  String? validateName(String? value) {
    bool isNameNotFilled = value == null || value.isEmpty;
    bool isWrongLength = value!.length < 10 || value.length > 50;

    if (isNameNotFilled) return 'The Name Need to be Filled!';
    if (isWrongLength) return 'Enter Name From 10 to 50 Characters!';

    return null;
  }

  String? validateQuantity(String? value) {
    bool isQuantityNotFilled = value == null || value.isEmpty;
    int? quantity = int.tryParse(value!);
    bool isQuantityNotInteger = quantity == null;
    bool isWrongValue = quantity! < 1 || quantity > 10;

    if (isQuantityNotFilled) return 'The Quantity Need to be Filled!';
    if (isQuantityNotInteger) return 'Quantity Need to be Integer!';
    if (isWrongValue) return 'Enter Quantity Value From 1 to 10!';
    
    return null;
  }

  String? validateCategory(GroceryCategory? value) {
    if (!value!.isEatable) return 'Category Should Be Something Eatable!';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new item')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: validateName,
                controller: _nameController,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: validateQuantity,
                      controller: _quantityController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: const InputDecoration(label: Text('Quantity')),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      validator: validateCategory,
                      initialValue: _selectedCategory,
                      items: GroceryCategory.values.map((category) => DropdownMenuItem<GroceryCategory>(
                        value: category, 
                        child: Row( 
                          children: [
                            Container(width: 15, height: 15, color: category.color),
                            SizedBox(width: 10),
                            Text(category.name.toUpperCase(), style: Theme.of(context).textTheme.bodyMedium),
                            ],
                          )
                        )
                      ).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: onReset, child: const Text('Reset')),
                  ElevatedButton(
                    onPressed: onAdd,
                    child: const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
