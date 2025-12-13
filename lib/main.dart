import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MomentumApp());
}

class MomentumApp extends StatelessWidget {
  const MomentumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.cyanAccent,
          secondary: Colors.blueAccent,
          surface: Color(0xFF1E1E1E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.cyanAccent,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.cyanAccent,
          foregroundColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const BaslangicKontrol(),
    );
  }
}

// ---------------------------------------------------------
// 1. BAŞLANGIÇ KONTROLÜ (BEKÇİ)
// ---------------------------------------------------------
class BaslangicKontrol extends StatefulWidget {
  const BaslangicKontrol({super.key});

  @override
  State<BaslangicKontrol> createState() => _BaslangicKontrolState();
}

class _BaslangicKontrolState extends State<BaslangicKontrol> {
  String? _kayitliIsim;
  String _gununSozu = ""; 

  final List<String> _sozler = [
    "Mazeret yok. Sadece sonuçlar var.",
    "Dünü değiştiremezsin ama bugünü kazanabilirsin.",
    "Disiplin, canın istemediğinde bile yapmaktır.",
    "Küçük adımlar, büyük zaferlerin mimarıdır.",
    "En iyi zaman, şu an.",
    "Yorgunluk geçer, pişmanlık kalıcıdır.",
    "Zinciri kırma. Seriyi koru.",
    "Geleceğin, bugün yaptıklarında gizli.",
    "Momentum kaybedilirse, geri kazanmak zordur.",
    "Kazanmak bir alışkanlıktır.",
    "Başlamak için mükemmel olmak zorunda değilsin.",
    "Bugün ektiğini, yarın biçeceksin."
  ];

  @override
  void initState() {
    super.initState();
    _gununSozuSec();
    _kontrolEt();
  }

  void _gununSozuSec() {
    setState(() {
      _gununSozu = _sozler[Random().nextInt(_sozler.length)];
    });
  }

  void _kontrolEt() async {
    final prefs = await SharedPreferences.getInstance();
    final isim = prefs.getString('kullanici_adi');

    if (isim != null && isim.isNotEmpty) {
      setState(() {
        _kayitliIsim = isim;
      });
      await Future.delayed(const Duration(milliseconds: 2500));
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const GorevListesiEkrani(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const KarsilamaEkrani()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: _kayitliIsim != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Tekrar Hoş Geldin,",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _kayitliIsim!,
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white12, width: 1),
                          bottom: BorderSide(color: Colors.white12, width: 1),
                        )
                      ),
                      child: Text(
                        '"$_gununSozu"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(color: Colors.cyanAccent),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. KARŞILAMA EKRANI (MİLAT)
// ---------------------------------------------------------
class KarsilamaEkrani extends StatefulWidget {
  const KarsilamaEkrani({super.key});

  @override
  State<KarsilamaEkrani> createState() => _KarsilamaEkraniState();
}

class _KarsilamaEkraniState extends State<KarsilamaEkrani> {
  final TextEditingController _isimController = TextEditingController();

  void _kaydetVeBasla() async {
    String isim = _isimController.text.trim();
    if (isim.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('kullanici_adi', isim);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const GorevListesiEkrani(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(seconds: 1),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "KİM BAŞLIYOR?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _isimController,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, color: Colors.cyanAccent),
              decoration: const InputDecoration(
                hintText: 'İsmini gir...',
                hintStyle: TextStyle(color: Colors.white24),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Takvimdeki yaprakların önemi yok. Asıl takvim şimdi işliyor. Geçmiş geride kaldı, senin 1. günün bugün başlıyor. Hazır mısın?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: _kaydetVeBasla,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                "MİLADI BAŞLAT",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. MOMENTUM ANA EKRAN
// ---------------------------------------------------------
class GorevListesiEkrani extends StatefulWidget {
  const GorevListesiEkrani({super.key});

  @override
  State<GorevListesiEkrani> createState() => _GorevListesiEkraniState();
}

class _GorevListesiEkraniState extends State<GorevListesiEkrani> {
  List<Map<String, dynamic>> _tumGorevler = [];
  DateTime _secilenTarih = DateTime.now();
  String _kullaniciAdi = "";
  
  int _seriSayaci = 0;
  String? _sonIslemTarihi; 

  late ConfettiController _confettiController;
  final TextEditingController _textController = TextEditingController();
  int _secilenOncelik = 2; 

  // Takvimi bugün seçili başlatsak da şeridin nerede duracağını belirlemek için
  // ScrollController kullanabiliriz ama basitlik adına şimdilik listenin başına (ayın 1'ine) dönecek.
  // Kullanıcı kaydırıp bugünü bulacak.
  
  @override
  void initState() {
    super.initState();
    _verileriYukle(); 
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  bool _ayniGunMu(DateTime tarih1, DateTime tarih2) {
    return tarih1.year == tarih2.year && 
           tarih1.month == tarih2.month && 
           tarih1.day == tarih2.day;
  }

  Color _oranRenginiVer(double oran) {
    if (oran == 1.0) return Colors.cyanAccent;
    if (oran >= 0.60) return Colors.greenAccent;
    if (oran >= 0.40) return Colors.yellowAccent;
    if (oran > 0.20) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  List<Map<String, dynamic>> get _ekrandakiGorevler {
    return _tumGorevler.where((gorev) {
      if (gorev['tarih'] == null) return _ayniGunMu(DateTime.now(), _secilenTarih);
      DateTime gorevTarihi = DateTime.parse(gorev['tarih']);
      return _ayniGunMu(gorevTarihi, _secilenTarih);
    }).toList();
  }

  List<Map<String, dynamic>> _tarihinGorevleri(DateTime tarih) {
    return _tumGorevler.where((gorev) {
      if (gorev['tarih'] == null) return false;
      DateTime gorevTarihi = DateTime.parse(gorev['tarih']);
      return _ayniGunMu(gorevTarihi, tarih);
    }).toList();
  }

  double _tarihinBasarisi(DateTime tarih) {
    var gorevler = _tarihinGorevleri(tarih);
    if (gorevler.isEmpty) return 0.0;
    int yapilanlar = gorevler.where((g) => g['yapildi'] == true).length;
    return yapilanlar / gorevler.length;
  }

  Color _takvimKutusuRengi(DateTime tarih, bool seciliMi) {
    var gorevler = _tarihinGorevleri(tarih);
    if (seciliMi && gorevler.isEmpty) return Colors.cyanAccent.withOpacity(0.3);
    if (gorevler.isEmpty) return const Color(0xFF1E1E1E); 
    double oran = _tarihinBasarisi(tarih);
    Color renk = _oranRenginiVer(oran);
    return renk.withOpacity(0.8);
  }

  double get _ilerlemeOrani {
    if (_ekrandakiGorevler.isEmpty) return 0.0;
    int yapilanlar = _ekrandakiGorevler.where((g) => g['yapildi'] == true).length;
    return yapilanlar / _ekrandakiGorevler.length;
  }

  Color get _durumRengi {
    return _oranRenginiVer(_ilerlemeOrani);
  }

  String get _durumMesaji {
    double oran = _ilerlemeOrani;
    String hitap = _kullaniciAdi.isNotEmpty ? " $_kullaniciAdi" : "";
    
    if (_ekrandakiGorevler.isEmpty) return "Planın ne$hitap?";
    if (oran == 1.0) return "MOMENTUM ZİRVEDE$hitap! 🚀";
    if (oran >= 0.60) return "Harika gidiyorsun$hitap! ⚡";
    if (oran >= 0.40) return "Yarıyı geçtin$hitap! 🔥";
    if (oran > 0.20) return "Motor ısındı$hitap! ⚙️";
    return "Hadi, başlama vakti$hitap! ⏰";
  }

  void _seriyiGuncelle() {
    DateTime bugun = DateTime.now();
    String bugunStr = "${bugun.year}-${bugun.month}-${bugun.day}";

    if (_sonIslemTarihi == bugunStr) return;

    DateTime? sonTarih = _sonIslemTarihi != null ? DateTime.parse(_sonIslemTarihi!) : null;

    setState(() {
      if (sonTarih != null) {
        final dun = bugun.subtract(const Duration(days: 1));
        bool dunYapildi = _ayniGunMu(sonTarih, dun);
        if (dunYapildi) {
          _seriSayaci++; 
        } else {
          _seriSayaci = 1; 
        }
      } else {
        _seriSayaci = 1; 
      }
      _sonIslemTarihi = bugunStr; 
    });
    _verileriKaydet();
  }

  void _verileriKaydet() async {
    final prefs = await SharedPreferences.getInstance();
    String veri = jsonEncode(_tumGorevler);
    await prefs.setString('gorev_listesi', veri);
    await prefs.setInt('seri_sayaci', _seriSayaci);
    if (_sonIslemTarihi != null) {
      await prefs.setString('son_islem_tarihi', _sonIslemTarihi!);
    }
  }

  void _verileriYukle() async {
    final prefs = await SharedPreferences.getInstance();
    
    setState(() {
      _kullaniciAdi = prefs.getString('kullanici_adi') ?? "";
    });

    String? veri = prefs.getString('gorev_listesi');
    int? kayitliSeri = prefs.getInt('seri_sayaci');
    String? kayitliTarih = prefs.getString('son_islem_tarihi');

    if (kayitliTarih != null) {
        DateTime son = DateTime.parse(kayitliTarih); 
        DateTime sonGun = DateTime(son.year, son.month, son.day);
        DateTime bugun = DateTime.now();
        DateTime bugunGun = DateTime(bugun.year, bugun.month, bugun.day);
        if (bugunGun.difference(sonGun).inDays > 1) {
            kayitliSeri = 0; 
        }
    }

    if (veri != null) {
      setState(() {
        _tumGorevler = List<Map<String, dynamic>>.from(jsonDecode(veri));
        for (var gorev in _tumGorevler) {
          if (gorev['tarih'] == null) {
            gorev['tarih'] = DateTime.now().toIso8601String();
          }
        }
        _seriSayaci = kayitliSeri ?? 0;
        _sonIslemTarihi = kayitliTarih;
      });
    } else {
      // Varsayılan görevler
      setState(() {
        _tumGorevler = [
          {
            'isim': 'Güne 1 bardak su ile başla 💧', 
            'yapildi': false,
            'oncelik': 3, 
            'tarih': DateTime.now().toIso8601String(),
          },
          {
            'isim': 'Yatağını topla (İlk zafer) 🛏️', 
            'yapildi': false,
            'oncelik': 2, 
            'tarih': DateTime.now().toIso8601String(),
          },
          {
            'isim': '10 sayfa kitap oku 📚', 
            'yapildi': false,
            'oncelik': 1, 
            'tarih': DateTime.now().toIso8601String(),
          },
        ];
        _verileriKaydet();
      });
    }
  }

  void _gorevEkle(String gorevAdi) {
    if (gorevAdi.isNotEmpty) {
      setState(() {
        _tumGorevler.add({
          'isim': gorevAdi, 
          'yapildi': false,
          'oncelik': _secilenOncelik,
          'tarih': _secilenTarih.toIso8601String(),
        });
        _tumGorevler.sort((a, b) => b['oncelik'].compareTo(a['oncelik']));
      });
      _verileriKaydet();
      _textController.clear();
      Navigator.of(context).pop();
    }
  }

  void _gorevSil(Map<String, dynamic> gorev) {
    setState(() {
      _tumGorevler.remove(gorev);
    });
    _verileriKaydet();
  }

  void _durumDegistir(Map<String, dynamic> gorev) {
    setState(() {
      gorev['yapildi'] = !gorev['yapildi'];
    });
    _verileriKaydet();

    if (gorev['yapildi'] && _ayniGunMu(DateTime.now(), DateTime.parse(gorev['tarih']))) {
      _seriyiGuncelle();
    }

    if (_ilerlemeOrani == 1.0) {
      _confettiController.play();
    }
  }

  Color _oncelikRengiVer(int oncelik) {
    switch (oncelik) {
      case 3: return Colors.redAccent;
      case 2: return Colors.orangeAccent;
      case 1: return Colors.blueAccent;
      default: return Colors.grey;
    }
  }

  Future<void> _takvimdenSec() async {
    final DateTime? secilen = await showDatePicker(
      context: context,
      initialDate: _secilenTarih,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.cyanAccent,
              onPrimary: Colors.black,
              surface: Color(0xFF1E1E1E),
            ),
          ),
          child: child!,
        );
      },
    );
    if (secilen != null) {
      setState(() {
        _secilenTarih = secilen;
      });
    }
  }

  void _eklemePenceresiniAc() {
    _secilenOncelik = 2; 
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E1E),
              title: Text(
                "${_secilenTarih.day}.${_secilenTarih.month}.${_secilenTarih.year}", 
                style: const TextStyle(color: Colors.cyanAccent, fontSize: 18)
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _textController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.cyanAccent,
                    decoration: const InputDecoration(
                      hintText: 'Hedefin ne?',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Öncelik: ", style: TextStyle(color: Colors.white70)),
                      DropdownButton<int>(
                        value: _secilenOncelik,
                        dropdownColor: const Color(0xFF2C2C2C),
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.cyanAccent),
                        style: const TextStyle(color: Colors.white),
                        items: const [
                          DropdownMenuItem(value: 3, child: Text("🔴 Acil")),
                          DropdownMenuItem(value: 2, child: Text("🟠 Orta")),
                          DropdownMenuItem(value: 1, child: Text("🔵 Rahat")),
                        ],
                        onChanged: (deger) {
                          setStateDialog(() { _secilenOncelik = deger!; });
                        },
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('İptal', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
                  onPressed: () => _gorevEkle(_textController.text),
                  child: const Text('KAYDET', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final liste = _ekrandakiGorevler;
    
    // 🔥 YENİ MANTIK: O ANKİ AYIN GÜN SAYISINI HESAPLA
    // Başlangıç: Ayın 1'i
    DateTime simdi = DateTime.now();
    DateTime ayinIlkGunu = DateTime(simdi.year, simdi.month, 1);
    
    // Bitiş: Gelecek ayın 0. günü (yani bu ayın son günü)
    int aydakiGunSayisi = DateTime(simdi.year, simdi.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80, 
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Icon(Icons.local_fire_department, color: Colors.orangeAccent, size: 28),
              const SizedBox(width: 4),
              Text(
                "$_seriSayaci", 
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
              ),
            ],
          ),
        ),
        title: const Text('MOMENTUM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.cyanAccent),
            onPressed: _takvimdenSec,
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 85,
                color: const Color(0xFF121212),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: aydakiGunSayisi, // 🔥 Sadece o ayın gün sayısı kadar
                  itemBuilder: (context, index) {
                    
                    // 🔥 Ayın 1'inden başlayarak üzerine gün ekliyoruz
                    DateTime tarih = ayinIlkGunu.add(Duration(days: index)); 
                    
                    bool seciliMi = _ayniGunMu(tarih, _secilenTarih);
                    Color kutuRengi = _takvimKutusuRengi(tarih, seciliMi);
                    Color yaziRengi = (kutuRengi == const Color(0xFF1E1E1E) && !seciliMi) 
                        ? Colors.grey 
                        : Colors.black;
                    if (seciliMi && kutuRengi.opacity < 0.5) {
                        yaziRengi = Colors.white; 
                    }
                    return GestureDetector(
                      onTap: () {
                        setState(() { _secilenTarih = tarih; });
                      },
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                        decoration: BoxDecoration(
                          color: kutuRengi,
                          borderRadius: BorderRadius.circular(12),
                          border: seciliMi ? Border.all(color: Colors.white, width: 2) : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${tarih.day}",
                              style: TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold,
                                color: yaziRengi
                              ),
                            ),
                            Text(
                              ["Ocak","Şub","Mart","Nis","May","Haz","Tem","Ağus","Eylül","Ekim","Kas","Ara"][tarih.month-1],
                              style: TextStyle(
                                fontSize: 12,
                                color: yaziRengi
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (liste.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              _durumMesaji,
                              style: TextStyle(color: _durumRengi, fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "%${(_ilerlemeOrani * 100).toInt()}",
                            style: TextStyle(
                              color: _durumRengi, 
                              fontWeight: FontWeight.bold, 
                              fontSize: 22 
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _ilerlemeOrani,
                          minHeight: 20,
                          backgroundColor: Colors.grey[800],
                          valueColor: AlwaysStoppedAnimation<Color>(_durumRengi),
                        ),
                      ),
                    ],
                  ),
                ),

              Expanded(
                child: liste.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event_note, size: 70, color: Colors.grey[800]),
                          const SizedBox(height: 15),
                          Text(
                            'Görev yok, dert yok.\nYa da bir şeyler mi eklesek?',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: liste.length,
                      itemBuilder: (context, index) {
                        final gorev = liste[index];
                        final oncelikRengi = _oncelikRengiVer(gorev['oncelik']);

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(left: BorderSide(color: oncelikRengi, width: 6)),
                              color: const Color(0xFF252525),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: gorev['yapildi'],
                                onChanged: (value) => _durumDegistir(gorev),
                                activeColor: oncelikRengi,
                                checkColor: Colors.black,
                                side: const BorderSide(color: Colors.grey),
                              ),
                              title: Text(
                                gorev['isim'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: gorev['yapildi'] ? Colors.grey : Colors.white,
                                  decoration: gorev['yapildi']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                                onPressed: () => _gorevSil(gorev),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ),
            ],
          ),
          
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false, 
              colors: const [Colors.cyanAccent, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _eklemePenceresiniAc,
        child: const Icon(Icons.add),
      ),
    );
  }
}