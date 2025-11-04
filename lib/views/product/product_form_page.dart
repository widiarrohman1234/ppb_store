import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../viewmodels/category_viewmodel.dart';
import '../../viewmodels/product_viewmodel.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;

  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _stockCtrl = TextEditingController();
  bool _available = true;
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();

    // initialisasi provider untuk category
    final categoryVM = Provider.of<CategoryViewModel>(context, listen: false);
    categoryVM.fetchCategories(); // ambil data kategori


    if (widget.product != null) {
      _nameCtrl.text = widget.product!.name;
      _descCtrl.text = widget.product!.description ?? '';
      _stockCtrl.text = widget.product!.stock.toString();
      _available = widget.product!.available;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productVM = context.read<ProductViewModel>();
    final catVM = context.watch<CategoryViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi (opsional)',
                ),
                maxLines: 3,
              ),
              TextFormField(
                controller: _stockCtrl,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null
                    ? 'Masukkan angka'
                    : null,
              ),
              SwitchListTile(
                title: const Text('Tersedia'),
                value: _available,
                onChanged: (val) => setState(() => _available = val),
              ),
              const SizedBox(height: 16),
              // Dropdown untuk kategori
              catVM.loading
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<Category>(
                      value: _selectedCategory,
                      items: catVM.categories
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(cat.name),
                            ),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Pilih Kategori',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (cat) {
                        setState(() {
                          _selectedCategory = cat;
                        });
                      },
                      validator: (v) =>
                          v == null ? 'Pilih kategori terlebih dahulu' : null,
                    ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      id: widget.product?.id ?? 0,
                      documentId: widget.product?.documentId ?? '',
                      name: _nameCtrl.text,
                      description: _descCtrl.text,
                      available: _available,
                      stock: int.parse(_stockCtrl.text),
                    );
                    if (widget.product == null) {
                      await productVM.addProduct(product);
                    } else {
                      await productVM.updateProduct(
                        widget.product!.documentId.toString(),
                        product,
                      );
                    }
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
