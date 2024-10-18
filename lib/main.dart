// Ata sınıf: Insan
class Insan {
      String isim;

  // Constructor
  Insan(this.isim);

  //   verloaded Method (Aşırı Yükleme)
  void ekle(String eleman) {
    print('$isim $eleman ekledi.');
  }

  void ekle(String eleman, String kime) {
    print('$isim $kime için $eleman ekledi.');
  }
}

// Öğrenci sınıfı, Insan'dan türetilmiştir (Inheritance)
class Ogrenci extends Insan {
  String bolum;

  Ogrenci(String isim, this.bolum) : super(isim);

  // Ders çalışma fonksiyonu
  void dersCalis() {
    print('$isim ders çalışıyor.');
  }

    // Sınava girme fonksiyonu
  void sinavaGir() {
    print('$isim sınava giriyor.');
  }

  // Overriding 
  @override
  void ekle(String ders) {
    print('$isim $ders dersini seçti.');
  }
}

// Hoca sınıfı, insadan türetilmiştir (Inheritance)
class Hoca extends Insan {
   String brans;

    Hoca(String isim, this.brans) : super(isim);

  // Ders anlatma fonksiyonu
  void dersAnlat() {
    print('$isim ($brans) ders anlatıyor.');
  }

  // Sınav yapma fonksiyonu
  void sinavYap() {
    print('$isim sınav yapıyor.');
  }

  // Method Overriding (Metot Ezme)
  @override
   void ekle(String ogrenciIsmi) {
     print('$isim $ogrenciIsmi adlı öğrencinin danışmanı olduğu dersi onayladı.');
  }
}

// Sekreter sınıfı, Insan'dan türetilmiştir (Inheritance)
class Sekreter extends Insan {
  Sekreter(String isim) : super(isim);

  // Hoca ekleme fonksiyonu
  void hocaEkle(Hoca hoca) {
    print('${hoca.isim} adlı hoca eklendi.');
  }

  // Öğrenci ekleme fonksiyonu
  void ogrenciEkle(Ogrenci ogrenci) {
    print('${ogrenci.isim} adlı öğrenci eklendi.');
  }

  // Method Overriding (Metot Ezme)
  @override
  void ekle(String ders, String ogrenciIsmi) {
    print('$isim $ogrenciIsmi için $ders dersini ekledi.');
  }
}

// Main fonksiyonu
void main() {
  // Sekreter, Hoca ve Öğrenci nesneleri oluşturuluyor
  Sekreter sekreter = Sekreter('Ayşe Sekreter');
    Hoca hoca = Hoca('Mehmet Hoca', 'Matematik');
     Ogrenci ogrenci = Ogrenci('Ali Öğrenci', 'Bilgisayar Mühendisliği');

   // Hoca ve Öğrenci ekleniyor
      sekreter.hocaEkle(hoca);
      sekreter.ogrenciEkle(ogrenci);

  // Hoca ve öğrenci ders çalışma ve sınav işlemleri
  hoca.dersAnlat();
  ogrenci.dersCalis();

  hoca.sinavYap();
  ogrenci.sinavaGir();

  // Encapsulation: Hoca ders ekleyip, öğrenciye danışmanlık yapıyor
  hoca.ekle(ogrenci.isim);

  // Encapsulation: Sekreter ders ekliyor
  sekreter.ekle('Fizik', ogrenci.isim);
}
