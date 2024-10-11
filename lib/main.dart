import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Uygulamanın ana widget'ı. Tema ve başlangıç ekranı ayarlanıyor.
    return MaterialApp(
      title: 'Alışveriş Sepeti',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingCartScreen(),
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  // Ürünleri tutacak liste
  List<Product> products = [];

  double totalAmount = 0;
  // İndirim oranı
  double discount = 0;
  // Kullanıcının yaşı
  int age = 0;

  // Kullanıcıdan veri almak için TextEditingController nesneleri
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _ageController = TextEditingController();

  // Ürün ekleme fonksiyonu, ürün listesine ürün ekler ve toplam tutarı günceller
  void addProduct(String name, double price) {
    setState(() {
      products.add(Product(name: name, price: price));
      totalAmount += price;
    });
  }

  // Kullanıcının yaşına göre indirim oranını hesaplayan fonksiyon
  void calculateDiscount() {
    setState(() {
      if (age < 18) {
        discount = 0.10; // %10 indirim
      } else if (age >= 18 && age <= 60) {
        discount = 0.05; // %5 indirim
      } else if (age > 60) {
        discount = 0.15; // %15 indirim
      }
    });
  }

  // Bellek yönetimi için text controller'ları serbest bırakıyoruz
  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ana arayüz
    return Scaffold(
      appBar: AppBar(
        title: Text('Alışveriş Sepeti'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Yaş girişi için TextField
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Yaşınızı girin'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Yaşa göre indirim uygulayan buton
            ElevatedButton(
              onPressed: () {
                age = int.parse(_ageController.text); // Yaşı input'tan alıyoruz
                calculateDiscount(); // İndirim hesaplanıyor
              },
              child: const Text('İndirim Uygula'),
            ),
            SizedBox(height: 20),
            // Ürün adı girişi için TextField
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Ürün Adı'),
            ),
            // Ürün fiyatı girişi için TextField
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Ürün Fiyatı'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Ürün ekleme butonu
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                 double price = double.parse(_priceController.text);
                addProduct(name, price); // Ürünü sepete ekliyoruz
                _nameController.clear(); // Girdi alanlarını temizliyoruz
                _priceController.clear();
              },
              child: Text('Ürün EkLe'),
            ),
            SizedBox(height: 20),

             Text('Sepetinizdeki Ürünler:'),

            Expanded(
              child: ListView.builder(
                itemCount: products.length, // Ürün sayısı kadar döner
                itemBuilder: (context, index) {
                  // Her ürün için bir ListTile oluşturuyor
                  return ListTile(
                    title: Text('${products[index].name}'),
                     subtitle: Text('Fiyat: ${products[index].price.toStringAsFixed(2)} TL'),
                  );
                },
              ),
            ),

            Text('Toplam Tutar: ${totalAmount.toStringAsFixed(2)} TL'),

              Text('İndirimli Tutar: ${(totalAmount - totalAmount * discount).toStringAsFixed(2)} TL'),
          ],
        ),
      ),
    );
  }
}

// Ürün sınıfı
class Product {
  final String name; // Ürün adı
  final double price; // Ürün fiyatı

  Product({required this.name, required this.price});
}
