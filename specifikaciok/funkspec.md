# Funkcionális specifikáció

## 1. Áttekintés



## 2. Jelenlegi helyzet

Egy kutatócsoport felkérte cégünket, hogy készítsünk nekik egy webalkalmazást, amit az egyik kutatásukhoz szeretnének használni. Az a helyzet, hogy már vannak alkalmazások arra, hogy a mesterséges intelligencia felismerjen (írott vagy nem írott) számokat a képernyőn vagy fájlból beolvasva. Sajnos nincs olyan alkalmazás, ami az emberi oldalt vizsgálná meg, hogy az ember, hogy ismeri fel ezeket a számokat. A tesztkitöltők a hallgatók lennének, akik idő függvényében egy-egy előadás végén pár számról megmondanák, hogy szerintük mi az, de akár interneten keresztül másokat is elérhetnénk vele vagy akár más karokat is az egyetemen. Ez az adatgyűjtés és összehasonlítás szolgálna a mesterséges intelligencia fejlesztéséhez.

## 3. Követelménylista



## 4. Jelenlegi üzleti folyamatok modellje



## 5. Igényelt üzleti folyamatok modellje



## 6. Használati esetek

Elérhető legyen magyar, illetve angol nyelven, a következő platformokon:
- Linux (lehető legtöbb distro)
- MacOS
- Windows
- Mobil (Android / iOS)

## 7. Képernyő tervek

### 7.1. Számítógépes megjelenés

![](kepek/MNIST-pc.png)

### 7.2. Mobilos megjelenés

![](kepek/MNIST-mobil.png)

## 8. Forgatókönyv



## 9. Funkció - követelmény megfeleltetés



## 10. Fogalomszótár
- AI - Mesterséges Intelligencia
- OCR - Szöveg felismerésére "szakosodott" AI. Ezekkel szokták pl.: a dokumentumokat PDF formátumba alakítani, bescannelni.
- Az MNIST (Módosított Nemzeti Szabványügyi és Technológiai Intézet, angolul: Modified National Institute of Standards and Technology)
egy nagy adatbázis kézzel írt számjegyekből, amelyet általában különféle képfeldolgozó rendszerek betanítására használnak.
Az adatbázist széles körben használják képzésre és tesztelésre is a gépi tanulás területén.
- MVC modell - Modell - Viev - Controller lényege, hogy a grafikus felülettől független környezetet tudunk kialakítani:
- Összetett, sok adatot a felhasználó elé táró számítógépes alkalmazásokban gyakori fejlesztői kívánalom az adathoz (modell) és a felhasználói felülethez (nézet) tartozó dolgok szétválasztása, hogy a felhasználói felület ne befolyásolja az adatkezelést, és az adatok átszervezhetők legyenek a felhasználói felület változtatása nélkül. A modell-nézet-vezérlő ezt úgy éri el, hogy elkülöníti az adatok elérését és az üzleti logikát az adatok megjelenítésétől és a felhasználói interakciótól egy közbülső összetevő, a vezérlő bevezetésével.
  - Az adatbázis tud kommunikálni a szerverrel, önállóan
  - A szerver tud adatot küldeni a kliensnek és kinyerni adatokat az adatbázisból API-kon keresztül
  - A kliens vagy a View modell csak egy megjelenítő, a felhasználó interakciókat továbbítja a modellnek, általában http protokolokon keresztül
