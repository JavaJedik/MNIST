| id  | type        | date       | description                                                                              | result  |
|----:|------------:|------------|:-----------------------------------------------------------------------------------------|:--------|
| 1   | Adatbázis   | 2023-10-11 | Magyar és angol nyelv hozzáadása az ismert nyelvekhez                                    | Success |
| 2   | Adatbázis   | 2023-10-11 | Magyarország és Anglia hozzáadása az ismert nyelveken az országokhoz                     | Success |
| 3   | Adatbázis   | 2023-10-11 | Ismert országok nevének lekérdezése a saját nyelvükön, használt nyelvük kiírása magyarul | Success |
| 4   | Adatbázis   | 2023-10-11 | Svájc hozzáadása 3 hivatalos nyelvével (német, francia, olasz)                           | Success |
| 5   | Adatbázis   | 2023-10-11 | Ellenőrzés, hogy nem okoz gondot, ha 1 nyelv nevét csak 1 nyelven tárolom                | Success |
| 5   | Adatbázis   | 2023-10-11 | Ha a német nyelv megnevezés csak magyarul van tárolva, használhatok német szavakat       | Success |
| 6   | Adatbázis   | 2023-10-11 | 3. teszt ismétlése a többnyelvű Svájccal is                                              | Success |
| 7   | Adatbázis   | 2023-10-11 | Nem enged kamu nyelvazonosítóval beszúrni playert                                        | Success |
| 8   | Adatbázis   | 2023-10-11 | Nem enged kamu országazonosítóval beszúrni playert                                       | Success |
| 9   | Adatbázis   | 2023-10-11 | Nem enged kamu nemazonosítóval beszúrni playert                                          | Success |
| 10  | Adatbázis   | 2023-10-11 | Nem enged kamu e-mail domain-nel beszúrni playert                                        | Success |
| 11  | Adatbázis   | 2023-10-11 | Nem enged kamu e-mailt beszúrni a playerhez, ha nincs domain hozzá                       | Success |
| 12  | Adatbázis   | 2023-10-11 | Nem enged nem számokat használni telefonszámban                                          | Success |
| 13  | Adatbázis   | 2023-10-11 | Nem enged országhívó kód nélkül telefonszámot megadni                                    | Success |
| 14  | Adatbázis   | 2023-10-11 | Nem enged kamu országhívó kódot megadni                                                  | Success |
| 15  | Adatbázis   | 2023-10-11 | Nem enged hálózati-szolgáltató kód nélkül telefonszámot megadni                          | Success |
| 16  | Adatbázis   | 2023-10-11 | Nem enged nem telefonszám alapú telefonszámot megadni                                    | Success |
| 17  | Adatbázis   | 2023-10-11 | Nem enged nem adatbázisban előre letárolt jelszót használni                              | Success |
| 18  | Adatbázis   | 2023-10-11 | Adatbázisba olyan rekordok felvétele, amikkel már tud rendelkezni egy felhasználó        | Success |
| 19  | Adatbázis   | 2023-10-12 | Egy regisztrált játékos tényleges, teljes regisztrációja                                 | Success |
| 20  | Adatbázis   | 2023-10-12 | Egy kép beszűrása az adatbázisba                                                         | Success |
| 21  | Log         | 2023-10-13 | Egy player bejelentkezésének regisztrálása                                               | Success |
| 22  | Adatbázis   | 2023-10-13 | Egy képformátum regisztrálása az adatbázisba                                             | Success |
| 23  | Adatbázis   | 2023-10-13 | Egy kép fragmentálásának elhelyezése az adatbázisban                                     | Success |
| 24  | Merevlemez  | 2023-10-13 | Egy kép-fragment rekordja 255 - néhány byte, a hatékony keresés és tárolás miatt         | Success |
| 25  | Szerver     | 2023-10-17 | A szerver elindítása általános függőségmegadással                                        | Success |
| 26  | Szerver     | 2023-10-19 | A szerver és a client tud kommunikálni egymással publikus hálón keresztül                | Success |
| 27  | Szerver     | 2023-10-19 | Sikeres szerver oldali bejelentkezés fiktív adatokkal                                    | Success |
| 28  | Szerver-log | 2023-10-19 | Sikeres logolás a szerveren                                                              | Success |
| 29  | Szerver     | 2023-10-20 | Más magyarok, görögök, oroszok, lengyenek, csehek, németek, osztrákok elérik a szervert  | Success |
| 30  | Szerver-sec | 2023-10-23 | A szerver a logolás közben nem jeleníti meg a jelszót, ?-t hagy a helyén                 | Success |
| 31  | Szerver     | 2023-10-23 | A szerver kezeli a rosszul megadott e-mail címeket (ha a kliens nem venné észre)         | Success |
| 32  | Szerver     | 2023-10-23 | A szerver kezeli a rosszul megadott nemet (ha a kliens nem venné észre)                  | Success |
| 33  | Szerver     | 2023-10-23 | A szerver kezeli a rosszul megadott nyelvet (ha a kliens nem venné észre)                | Success |
| 34  | Szerver     | 2023-10-23 | Játékos regisztrációja jelszóval együtt szervernek küldött post kéréssel                 | Success |
| 35  | Szerver     | 2023-10-27 | Bejelentkezés helyes felhasználói adatokkal                                              | Success |
| 36  | Szerver     | 2023-10-27 | Bejelentkezés megtagadása helytelen jelszóval                                            | Success |
| 37  | Adatbázis   | 2023-10-27 | Nem tud regisztrálni 2 játékos ugyanazon névvel                                          | Success |
| 38  | Szerver     | 2023-10-28 | Bejelentkezés és userToken eltárolása ellenőrzésre                                       | Success |
| 39  | Szerver     | 2023-10-28 | A userToken ellenőriztetése a szerver segítségével http fejlécben                        | Success |
| 40  | Szerver     | 2023-10-28 | A hibás userToken ellenőriztetése a szerver segítségével http fejlécben                  | Success |
| 41  | Szerver     | 2023-10-28 | A userToken ellenőriztetése, amikor a http fejlécmezőt se küldöm el                      | Success |
| 42  | HTTP/2      | 2023-10-28 | A kommunikáció a http1.1 való átváltás után http2-t használt                             | Success |


## Egyszerűbb áttekinthetőségért csak a nehezebb lekérdezéseket írtam le, triviálisakat kevésbé.

(Pl.: Nem írom le, hogy hogyan szúrunk be a táblába egy sort, mert 1 perc google, és nem akarom, hogy 100 oldal legyen a dokumentum.)

### Test 1-6

![](../kepek/teszt/tomi/t1.png)

![](../kepek/teszt/tomi/t2.png)

(Bár Svájcban a rétoromán is hivatalos nyelv, háttérbe szorul, ezért nem vettem bele.
Hozzáadtam a 3 hivatalos nyelvén is az ország adatait.)

A nyelvek között most a németet, franciát és olaszt úgy tárolom el, hogy csak magyarul tárolom el a nevét, hogy mi az.
(Ugye ID-k vannak csak, ezért nem sérül meg az adatbázis és konzisztens marad.)
Így tudok német nyelvet használni úgy, hogy magát a nyelvet nem nevezem mondjuk Deutch-nak.

Most, hogy letároltam 5 nyelven Svájcot, így a 3. tesztben most 3-szor kéne szerepelnie Svájcnak, mert mindhárom hivatalos nyelv.
(A lekérdezés a 3. tesztben kimásolható.)

```sql
select country_name.name, language_name.name
from country_name
inner join language
    on country_name.language_id = language.id
inner join language_name
	on country_name.language_id = language.id and
	language_name.language_id = language.id
inner join country
	on country.id = country_name.country_id
inner join country_language
	on country_language.country_id = country.id and
	country_language.language_id = language.id
where
	language_name.name_language_id =
	(select id from language
		inner join language_name
			on language.id = language_name.language_id and
			language_name.name_language_id = language.id
		where
			language_name.language_id = language_name.name_language_id and
			language_name.name = "magyar");
```

![](../kepek/teszt/tomi/t3.png)

## Test 7-19

Itt a userre vonatkozó adatbázis integritását és sérthetetlenségét tesztelem, hogy minden információ, ami benne van, garantáltan valódi, ne lehessen hamis adatokat megadni. Az adatbázis a kulcsmegszorítások miatt minden ilyen kérést meg kell, hogy tagadjon akkor is, ha a fentebbi kódréteg ezt nem veszi észre, így többrétegű a biztonság is.
Ez nem azt jelenti, hogy eddig nem létező országgal nem szúrhatunk be soha semmilyen körülmények között új playert, de ehhez először az adott országot fel kell venni a nyílvántartásba automatikusan vagy manuálisan.

![](../kepek/teszt/tomi/t4.png)

```sql
select registered_player.name as name, gender_name.name as gender,
registered_player.email_prefix, email_type.domain, email_tld.tld,
country_calling_code.country_number, phone_network.network_number,
phone
from registered_player, gender, gender_name, email_type, email_tld,
country_calling_code, phone_network
	where
		registered_player.gender_id = gender.id and
		gender_name.gender_id = gender.id and
		email_type.tld_id = email_tld.id and
		registered_player.email_type_id = email_type.id and
		registered_player.country_calling_code_id = country_calling_code.id and
		registered_player.phone_network_id = phone_network.id and
		gender_name.language_id =
		(select id from language
			inner join language_name
				on language.id = language_name.language_id and
				language_name.name_language_id = language.id
			where
				language_name.language_id = language_name.name_language_id and
				language_name.name = "magyar");
```

## Teszt 27

A curl parancs az alábbi volt:

```bash
curl -X POST -H "Content-Type: application/json" -d '{"username": "felhasznalonev", "password": "jelszo"}' http://localhost:8814/login
curl -X POST -H "Content-Type: application/json" -d '{"username": "felhasznalonev", "password": "jelszo"}' https://mnist-server.serveo.net/login
```

## Teszt 28

Sikeresen teszteltem a logolást a szerveren bejelentkezésnél és indításnál:

![](../kepek/teszt/tomi/t5.png)

## Teszt 29

Sikeresen tesztelték a weboldal elérését különböző testereink.

![](../kepek/teszt/tomi/t6.png)


## Teszt 30-37

Curl kérés segítségével helytelen e-mail címe küldünk a szervernek, amit sikeresen elkapott, lekezelt, és választ küldött.

```bash
curl -X POST -H "Content-Type: application/json" -d '{
  "username": "Johny",
  "email": "tomigmail.com",
  "password": "YourPasswordHere",
  "language": "magyar",
  "gender": "Férfi"
}' http://localhost:8814/registrate
```

Válasz: Az adatok érvénytelenek

A szerver logolása:

```bash
2023-10-23T17:18:42.602+02:00  INFO 37880 --- [nio-8814-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 1 ms
2023-10-23T17:18:42.672+02:00  INFO 37880 --- [nio-8814-exec-1] j.m.restcontroller.RegistrateController  : Regisztrációs adatok megérkeztek:
username: Johny, email: tomigmail.com, password: ?, language: magyar, gender: Férfi
2023-10-23T17:18:42.674+02:00  INFO 37880 --- [nio-8814-exec-1] javajedik.main.sql.RegistratePlayerSQL   : Játékos regisztrálásának megkezdése az adatbázisban. Adatok:
username: Johny, email: tomigmail.com, password: ?, language: magyar, gender: Férfi
2023-10-23T17:18:42.674+02:00 ERROR 37880 --- [nio-8814-exec-1] javajedik.main.sql.RegistratePlayerSQL   : Hibás e-mail cím formátum
2023-10-23T17:18:42.674+02:00 ERROR 37880 --- [nio-8814-exec-1] j.main.service.RegistrateService         : Játékos regisztrálása sikertelen. Adatok:
username: Johny, email: tomigmail.com, password: ?, language: magyar, gender: Férfi
2023-10-23T17:18:42.674+02:00 ERROR 37880 --- [nio-8814-exec-1] j.m.restcontroller.RegistrateController  : Játékos regisztrálása sikertelen. Adatok:
username: Johny, email: tomigmail.com, password: ?, language: magyar, gender: Férfi
```

Miután helyes kérést indítottunk, a regisztráció sikeres volt, jelszó is belekerült a táblába bináris formában.

```bash
curl -X POST -H "Content-Type: application/json" -d '{
  "username": "Johny",
  "email": "tomi@gmail.com",
  "password": "YourPasswordHere",
  "language": "magyar",
  "gender": "Férfi"
}' http://localhost:8814/registrate
```

![](../kepek/teszt/tomi/t7.png)

Következő lépés pedig, hogy a szerver elfogadja a regisztrációnkat, és a helyes jelszóval engedjen be, de helytelen adatokkal ne engedjen be, két játékos ne tudjon regisztrálni ugyanazon nevekkel.

![](../kepek/teszt/tomi/t8.png)

## Teszt 38-41

A hitelesítést a http fejlécmezők segítségével végzem el.
Fontos volt tesztelni, hogy:
 - Elfogadja a helyes tokent
 - Ne fogadja el a helytelen tokent
 - Ne fogadja el a kérést, ha nincs is megfelelő fejlécmező

```bash
curl -X POST -H "Content-Type: application/json" -d '{"username": "Johny", "password": "YourPasswordHere"}' http://localhost:8814/login
```

```bash
curl -H "userToken: eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI2IiwiaWF0IjoxNjk4NDk3MDU4LCJleHAiOjE2OTg1ODcwNTh9.adR4IZYVXkrPHDNErjxORARgs7k9dLLT06OUM3ixLXaL9shxLXRI7um2lykzWOGXkKYq3j6HhnRMV_5EOvQBlw" http://localhost:8814/check/userToken
```

```bash
curl http://localhost:8814/check/userToken
```

![](../kepek/teszt/tomi/t11.png)


## Teszt 42

```bash
curl -I --http2 -H "userToken: eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI2IiwiaWF0IjoxNjk4NTAxNTI3LCJleHAiOjE2OTg1OTE1Mjd9.gERkd0kfAeoIMYtljP9FhQOr5MFFE-0buTiQKvCwtMSf52FGiVNJ2PuNzcoZS6x6TxXko5GtfOGCq_KrI4bOqA" http://localhost:8814/check/userToken
```

```yaml
HTTP/1.1 101 
Connection: Upgrade
Upgrade: h2c
Date: Sat, 28 Oct 2023 13:59:59 GMT

HTTP/2 200 
vary: Origin
vary: Access-Control-Request-Method
vary: Access-Control-Request-Headers
content-length: 0
date: Sat, 28 Oct 2023 13:59:59 GMT
```

Az előző kérés esetén egy cURL parancsot használtunk a HTTP kérések elküldésére egy szervernek. A parancs tartalmazott egy --http2 kapcsolót, ami azt jelezte, hogy HTTP/2 protokollt használjunk a kérés elküldésére. A kérés specifikációjában volt egy fejléc is, amely tartalmazott egy "userToken" nevű hitelesítési tokent. Ezt a tokent a /check/userToken végpontnak küldtük el a kérés során.

A szerver válasza két részből állt. Először egy "101 Switching Protocols" státuszkóddal indult, ami azt jelezte, hogy a szerver készen áll a protokoll váltásra. Ezt követően a válasz tartalmazta a "HTTP/2 200" státuszkódot, ami azt jelentette, hogy a kérés sikeres volt, és a szerver válaszolt egy 0 bájtos hosszúságú tartalommal. A fejlécek között megtalálhatók továbbá a "vary" fejlécek, amelyek a kérés változóit tükrözték vissza, és a "date" fejléc, ami azt mutatja, hogy a válasz melyik időpontban érkezett vissza.

Az összefoglalóban elmondható, hogy a kérés HTTP/2 protokollon keresztül történt, és a "userToken" fejléc is sikeresen elküldésre került a szervernek. A szerver válasza sikeres volt, és nem tartalmazott tartalmat a válasz testében.

A HTTP/2 sok előnnyel rendelkezik a HTTP/1.1-el szemben, például az egyetlen TCP kapcsolatokon keresztül több kérés és válasz kezelésének képessége, fejléc mezők tömörítése, prioritáskezelés és sok más hatékonyságot növelő funkció. Azonban a HTTP/2 fő célja a hatékonyság, és nem befolyásolja az alkalmazások által használt adatok típusát.
