import 'package:flutter/material.dart';
import 'package:izmirnobetcieczane/models/pharmacy.dart';
import 'package:izmirnobetcieczane/services/remote_service.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pharmacy>? pharmacies;
  List<Pharmacy>? filteredPharmacies;

  //Fetch data from API
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> callNumber(String phoneNum) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNum);
    await launchUrl(launchUri);
  }

  /* This is for direct phone call !!
  void callNumber(String phoneNum) async {
    String number = 'tel:' + phoneNum;
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      throw 'Could not launch $number';
    }
    await FlutterPhoneDirectCaller.callNumber(number);
  }*/

  getData() async {
    pharmacies = await RemoteService().getPharmacies();
    if (pharmacies != null) {
      setState(() {
        filteredPharmacies = pharmacies;
      });
    }
  }

  onSearch(String search) {
    setState(() {
      filteredPharmacies = pharmacies
          ?.where((element) => element.bolge.toLowerCase().contains(search))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFFF0040,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                "İZMİR NÖBETÇİ ECZANE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => onSearch(value.toLowerCase()),
                style: const TextStyle(
                  color: Color(0xFFFF0040),
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Bölgeye göre ara...",
                  isDense: false,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFFFF0040),
                  ),
                  prefixIconColor: const Color(0xFFFF0040),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
              Expanded(
                child: (filteredPharmacies == null)
                    ? const Center(
                        child: Text(
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          "Nöbetçi Eczaneler Listeleniyor...",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredPharmacies?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4.0,
                            color: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 8, 0, 8)),
                                      Text(
                                        filteredPharmacies![index].adi,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFFFF0040),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        filteredPharmacies![index].adres,
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        filteredPharmacies![index].bolge,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        filteredPharmacies![index]
                                            .tarih
                                            .toString(),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        filteredPharmacies![index].telefon,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        filteredPharmacies![index]
                                            .bolgeAciklama,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          OutlinedButton.icon(
                                            icon: const Text('Hemen Ara'),
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xFFFF0040),
                                                onPrimary: Colors.white),
                                            label: const Icon(Icons.phone),
                                            onPressed: () async {
                                              callNumber(
                                                  filteredPharmacies![index]
                                                      .telefon
                                                      .toString());
                                            },
                                          ),
                                          OutlinedButton.icon(
                                            icon: const Text('Yol Tarifi Al'),
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xFF0097E9),
                                                onPrimary: Colors.white),
                                            label:
                                                const Icon(Icons.location_on),
                                            onPressed: () async {
                                              MapsLauncher.launchQuery(
                                                "${filteredPharmacies![index].adi} ${filteredPharmacies![index].lokasyonX},${filteredPharmacies![index].lokasyonY}}" /*"${filteredPharmacies![index].adi} ${filteredPharmacies![index].adres}"*/,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
