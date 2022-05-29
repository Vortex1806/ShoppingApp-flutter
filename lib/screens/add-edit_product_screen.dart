import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/Product.dart';

class EditProductsScreen extends StatefulWidget {
  static const namedRoute = '/edit-products';
  const EditProductsScreen({Key key}) : super(key: key);

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageurlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  // for showing the image before uploading we need to get access to input before submitting
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageurlFocusNode.addListener(_updateimageurl);
    super.initState();
  }

  void _updateimageurl() {
    if (!_imageurlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isvalid = _form.currentState.validate();
    if (isvalid) {
      _form.currentState.save();
      print(_editedProduct.title);
      print(_editedProduct.price);
      print(_editedProduct.imageUrl);
      print(_editedProduct.description);
    }
    return;
  }

  @override
  void dispose() {
    // TODO: clear up the memory
    _imageurlFocusNode.removeListener(_updateimageurl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageurlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter a Title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: value,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value),
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) {
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter Url')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        focusNode: _imageurlFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value);
                        },
                        onFieldSubmitted: (_) => _saveForm,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(onPressed: _saveForm, child: Text('Submit'))
              ],
            ),
          )),
    );
  }
}
