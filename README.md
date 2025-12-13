# 🚀 Momentum: Kişisel Üretkenlik ve Alışkanlık Takip Asistanı

![Momentum Banner](https://via.placeholder.com/1200x300?text=MOMENTUM+APP)

> 🎯 **Momentum**, görev tamamlama oranınızı artırmayı hedefleyen, streak mantığı ve
> oyunlaştırma ile **disiplini alışkanlığa dönüştüren** bir mobil uygulamadır.

- ⏱ Günlük görevleri ertelemeden bitir
- 🔥 Streak zincirini koruyarak motivasyonu sürdür
- 🎮 Görsel ödüllerle dopamin döngüsünü doğru kullan

**Momentum**, kullanıcıların günlük görevlerini yönetmelerine, alışkanlık zincirleri (streak) oluşturmalarına ve oyunlaştırılmış (gamified) bir deneyimle motivasyonlarını korumalarına yardımcı olan, **Flutter** ile geliştirilmiş, **Offline-First** (Çevrimdışı Öncelikli) bir mobil uygulamadır.

Sıradan bir yapılacaklar listesi (To-Do List) uygulamasının ötesinde; Momentum, **görsel psikoloji** ve **ödül mekanizmalarını** kullanarak kullanıcıyı "akışta" (flow) tutmayı hedefler. 

## 👥 Kimler İçin Uygun?

- Günlük görevlerini sürekli erteleyenler
- Alışkanlık oluşturmakta zorlananlar
- Minimal ama motive edici uygulamaları sevenler
- Offline çalışmak isteyen kullanıcılar

## 🔄 Nasıl Çalışır?

1. Kullanıcı uygulamayı ilk kez açar ve ismini girer
2. Günlük görevlerini öncelik seviyeleriyle ekler
3. Görevler tamamlandıkça:
   - İlerleme çubuğu dolar
   - Streak artar
4. Gün tamamlanınca görsel ödül tetiklenir

## 🎨 Tasarım ve Psikoloji Yaklaşımı

Momentum, şu prensiplerle tasarlanmıştır:

- **Az ama net UI:** Karar yorgunluğunu azaltmak
- **Görsel geri bildirim:** Beynin ödül mekanizmasını tetiklemek
- **Offline-first:** Kullanıcıyı bağımlı değil, özgür kılmak

## 🌟 Temel Özellikler

### 1. 🧠 Akıllı Onboarding (Milat Sistemi)
* **İlk İzlenim:** Uygulama ilk kez açıldığında, kullanıcıyı motive edici bir manifesto ve isim giriş ekranı karşılar.
* **Kişiselleştirme:** Girilen isim yerel hafızaya kaydedilir ve uygulama boyunca kullanıcıya ismiyle hitap edilerek duygusal bağ kurulur.
* **Tek Seferlik Deneyim:** Kayıt sonrası bu ekran bir daha gösterilmez; yerini "Hoş Geldin" animasyonuna bırakır.

### 2. 🎮 Oyunlaştırma ve Motivasyon (Gamification)
* **Dinamik İlerleme Çubuğu:** Tamamlanan görev oranına göre renk ve mesaj değiştiren akıllı bar.
    * `%0-20`: Kırmızı (Harekete Geç)
    * `%40-60`: Sarı/Yeşil (Akıştasın)
    * `%100`: Cyan (Mükemmeliyet)
* **Konfeti Ödülü:** Günün tüm görevleri tamamlandığında (`confetti` paketi ile) görsel bir kutlama efekti tetiklenir.
* **Streak (Seri) Sayacı:** Kullanıcının uygulamayı her gün kullanma disiplini takip edilir. Zincir kırılırsa sayaç sıfırlanır.

### 3. ✅ Gelişmiş Görev Yönetimi
* **Öncelik Algoritması:** Görevler 3 farklı öncelik seviyesine göre (Acil, Orta, Rahat) eklenir ve liste otomatik olarak **Önem Derecesine** göre sıralanır.
* **Görsel Ayrıştırma:** Her görev, önem derecesine göre renkli bir yan şeritle (BorderSide) işaretlenir.

### 4. 📅 Dinamik Takvim Şeridi
* **Custom Scrollable Calendar:** Bulunulan ayın 1. gününden son gününe kadar dinamik olarak oluşturulan yatay tarih şeridi.
* **Geçmiş Takibi:** Geçmiş günlerin başarı oranlarına göre takvim kutucukları renklendirilir (Isı haritası mantığı).

### 5. 💾 Veri Kalıcılığı (Persistence)
* **SharedPreferences:** Tüm görevler, kullanıcı verileri ve streak bilgisi cihazın yerel hafızasında JSON formatında saklanır. İnternet bağlantısı gerektirmez.

---

## 🛠️ Teknik Altyapı ve Kullanılan Paketler

Bu proje, **Flutter** framework'ü ve **Dart** dili kullanılarak geliştirilmiştir.

| Paket | Sürüm | Kullanım Amacı |
| :--- | :--- | :--- |
| **Flutter SDK** | `3.x.x` | Ana geliştirme kiti. |
| **shared_preferences** | `^2.x.x` | Key-Value tabanlı yerel veri saklama (Local Storage). |
| **confetti** | `^0.x.x` | Başarı anlarında parçacık efektleri oluşturma. |
| **dart:convert** | *Built-in* | JSON serileştirme ve ayrıştırma işlemleri. |

### Uygulama Mimarisi
Proje, tek dosya yapısı (`main.dart`) üzerinde modüler bir yaklaşımla, **StatefulWidget** yaşam döngüleri (Lifecycle) kullanılarak inşa edilmiştir.

* **Veri Modeli:** Görevler `Map<String, dynamic>` yapısında tutulur.
* **State Management:** Flutter'ın yerel `setState` mekanizması ile anlık UI güncellemeleri sağlanır.
* **Renk Mantığı:** `_oranRenginiVer(double oran)` fonksiyonu, matematiksel başarı oranını UI renk paletine dönüştürür.

---
## 🚀 Kurulum ve Çalıştırma

Bu projeyi yerel makinenizde çalıştırmak için aşağıdaki adımları izleyin:

**1. Depoyu Klonlayın**

git clone [https://github.com/KULLANICI_ADINIZ/Momentum.git](https://github.com/KULLANICI_ADINIZ/Momentum.git)
cd Momentum

**2. Bağımlılıkları Yükleyin**

flutter pub get

**3. Uygulamayı Başlatın Cihazınızı veya emülatörü bağladıktan sonra:**


flutter run

**4. APK Oluşturma (Release) Arkadaşlarınızla paylaşmak için imzalı APK çıktısı almak isterseniz:**

flutter build apk --release
Çıktı Yolu: build/app/outputs/flutter-apk/app-release.apk


## 🔮 Gelecek Planları (Roadmap)

* [ ] **Bildirim Sistemi:** Günlük hatırlatıcılar ve motive edici push bildirimleri (Flutter Local Notifications).
* [ ] **Karanlık/Aydınlık Mod Geçişi:** Kullanıcı tercihine göre tema değişimi.
* [ ] **İstatistik Sayfası:** Haftalık ve aylık performans grafikleri.
* [ ] **Google/Apple Girişi:** Verilerin bulutta (Firebase) yedeklenmesi.

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen bir **Pull Request** açmadan önce bir **Issue** oluşturarak yapacağınız değişikliği tartışın.

1. Bu depoyu Fork'layın.
2. Yeni bir özellik dalı oluşturun (`git checkout -b feature/YeniOzellik`).
3. Değişikliklerinizi Commit'leyin (`git commit -m 'Yeni özellik eklendi'`).
4. Dalı Push'layın (`git push origin feature/YeniOzellik`).
5. Bir Pull Request oluşturun.

📄 Lisans
Bu proje MIT Lisansı altında lisanslanmıştır. Detaylar için LICENSE dosyasına bakınız.

**Geliştirici:** [İlker İpek]
**İletişim:** [ilkeripek0517@gmail.com]

*"Zinciri kırma. Seriyi koru."* 🚀
