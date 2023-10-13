# Viktor tesztjei

## 1. teszt - tesztképek

| Méret<br/>(pixel*pixel) |   Pixelek | Méret<br/>(bájt) | Bájt/pixel |
|------------------------:|----------:|-----------------:|-----------:|
|                      28 |       784 |            2.207 |     ~2,815 |
|                      50 |     2.500 |            5.329 |     ~2,132 |
|                     100 |    10.000 |           1.7130 |     ~1,713 |
|                     480 |   230.400 |          4.49753 |     ~1,952 |
|                     720 |   518.400 |          9.24216 |     ~1,783 |
|                    1080 | 1.166.400 |        1.628.245 |     ~1,396 |

Átlag bájt/pixel: ~1,355

### Fontos tudnivalók:

- A képek egy nagyobb képből lettek kivágva
- A bájt/pixel értékei három tizedesre lettek kerekítve
  - Ezek a számok a _~_ jellel vannak ellátva
- Tesztelt eszköz operációs rendszere: Windows 11
- A méret meghatározására és számolásokra a fájlok bájtszáma lett használva.
- A _forrasok.md_ állományban megtalálható a képek forrása

