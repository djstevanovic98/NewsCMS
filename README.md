# NewsCMS
Client management system - JAX-RS + JQuery + SQL

RAF News
Projekat
1.	Pregled zadatka
Zadatak je napraviti online platformu za objavljivanje i pregled vesti. Aplikacija se sastoji iz dva dela: 
1) Sistem za upravljanje sadržajem (CMS). Za pristup ovom sistemu, neophodna je autentifikacija. Trenutno postoje dva tipa korisnika, content creator i admin. Uloga content creatora je pisanje novih vesti, pregled već postojećih, njihova izmena i brisanje. Admin ima sve mogućnosti koje ima i content creator, uz funkcionalnost upravljanja korisnicima: dodavanje novih korisnika i definisanje njihovih tipova, pregled svih korisnika i njihova izmena.
2) Javna platforma za čitanje vesti. Platforma koja omogućava pregled svih objavljenih vesti, pregled po kategorijama, pregled najčitanijih vesti, filtriranje vesti na osnovu tagova, komentarisanje vesti i pregled komentara.

2.	Entiteti
Korisnik - Entitet koji sadrži jedinstveni email, ime i prezime, tip korisnika (content creator ili admin), status (aktivan/neaktivan) i lozinku. Entitet uz pomoć kog se pristupa CMS-u i koji može biti autor vesti. Na osnovu statusa je moguće zabraniti pristup CMS-u. Lozinke se čuvaju isključivo kao heš vrednosti.
Kategorija - Sistem se sastoji od vesti koje pripadaju određenoj kategoriji (vesti su grupisane u kategorije). Kategorija ima jedinstveno ime i opis. 
Vest - Entitet koji sadrži naslov, tekst, vreme kreiranja, broj poseta, autora (korisnika koji je kreirao vest), komentare čitalaca, kao i tagove na osnovu kojih će se raditi pretraga srodnih vesti. Vest pripada jednoj kategoriji.
Tag - Ključna reč ili više reči koje usko opisuju vest. Vest može imati više tagova i jedan tag može pripadati više vesti.
Komentar - Entitet koji sadrži ime autora komentara (unosi se pri pisanju komentara), tekst komentara i datum kreiranja. Pripada jednoj vesti.
Navedena polja u entitetima ne smeju biti null, a ni empty stringovi - obavezna su.
Pored navedenog, dozvoljeno je dodavanje pomoćnih tabela i ostalih polja potrebnih za dalji razvoj rešenja. 

3.	CMS
Autentifikacija i autorizacija
Pristup CMS-u zahteva autentifikaciju. Funkcionalnost za dodavanje korisnika ima admin i njega na početku treba kreirati ručno u bazi podataka. Stranica za prijavu ima polja za email, lozinku i dugme za prijavu. Obrada zahveta za prijavu proverava da li u bazi postoji korisnik sa tom email adresom i istom vrednošću heša prosleđene lozinke. Heš funkciju koristite po izboru, na primer, sha256. Takođe, pristup CMS-u podrazumeva i proveru statusa, samo aktivni korisnici imaju pristup.
Ukoliko postoji aktivan korisnik sa takvim kredencijalima, potrebno je proslediti ga na glavnu stranicu (stranicu sa kategorijama). U suprotnom ostati na stranici za prijavu uz poruku o grešci.
Autentifikaciju implementirati na proizvoljan način: pomoću cookie-a ili JWT-a. Sesija ili token mogu trajati beskonačno dugo i nije potrebno implementirati rok trajanja.
U zavisnosti od tipa prijavljenog korisnika, prikazuju se dostupne funkcionalnosti. Pored toga, neophodno je uraditi i autorizaciju zahteva na samom backendu, tj. proveriti da li korisnik ima dozvolu za određenu akciju. Na primer, content creator ne sme imati mogućnost za kreiranja, listanje i izmenu korisnika.
Funkcionalnosti po tipu korisnika
Content creator vidi navigacioni meni koji sadrži 3 stavke: kategorije, vesti i i polje za pretragu vesti.
-	Kategorije: Da bi content creator mogao da kreira novu vest, pre svega mora postojati spisak dostupnih kategorija. Kategorija ima ime i kratki opis. Potrebno je obezbediti stranicu sa tabelom postojećih kategorija. Pored tabele kategorija, potrebno je postaviti dugme koje vodi na formu za dodavanje nove kategorije - forma sa imenom kategorije i opisom. Nije dozvoljeno kreirati kategoriju sa već postojećim imenom. Svaka stavka tabele sadrži ime kategorije, kratak opis i akcije za izmenu i brisanje. 
-	Ime kategorije vodi na tabelu svih vesti (naredni paragraf) u kojoj će se nalaziti samo vesti iz odabrane kategorije - filtriranje po kategoriji.
-	Akcija za izmenu vodi na formu za izmenu kategorije, koja sadrži polja za ime i opis (kao i forma za kreiranje), uz prikaz trenutnih vrednosti odabrane kategorije. 
-	Brisanje kategorije nije dozvoljeno sve dok postoji makar i jedna vest u toj kategoriji. 
-	Vesti: Stranica na kojoj je prikazana tabela svih vesti, sortirana po datumu kreiranja. Pored tabele, potrebno je postaviti dugme koje vodi na formu za dodavanje nove vesti - forma sa naslovom vesti, kategorijom kojoj vest pripada (odabir jedne od postojećih), tekstom i listom tagova. Tagovi se dodaju kroz jedno tekstualno polje i proizvoljni su. Svaka stavka tabele sa vestima sadrži naslov vesti, ime autora, datum kreiranja i akcije za izmenu i brisanje. 
-	Naslov vesti vodi na vest na platformi za čitanje, u novom tabu.
-	Akcija za izmenu vodi na formu za izmenu vesti, koja sadrži polja kao i kod kreiranja vesti, uz prikaz njihovih trenutnih vrednosti.
-	Akcija za brisanje iz baze briše vest i sve njene komentare.
-	Pretraga vesti: Daje ulogovanom korisniku mogućnost da pretražuje vesti u CMS-u po tekstu. Pretraga radi po principu provere da li se uneti tekst nalazi u naslovu vesti ili u tekstu same vesti. Na primer, ako korisnik u polje unese "Novak Đoković" potrebno je vratiti sve vesti (uz ispoštovanu paginaciju) koje u naslovu ili u tekstu vesti sadrže "Novak Đoković". Rezultat prikazati u tabeli kao što je definisano i za prikaz svih vesti.
Admin, pored navedenih funkcionalnosti koje ima content creator, admin ima i mogućnost upravljanjem korisnicima. U navigacionom meniju, pored već postojećih stavki, dodati još jednu, korisnici.
-	Korisnici: Tabela svih postojećih korisnika. Pored tabele korisnika, potrebno je postaviti dugme koje vodi na formu za dodavanje novog korisnika - forma sa imenom i prezimenom korisnika, email adresom, tipom (admin ili content creator) i lozinkom korisnika (lozinka zahteva dodatno polje za potvrdu lozinke). Tabela korisnika sadrži kolone ime i prezime, email, tip korisnika i akcije za izmenu i aktivaciju/deaktivaciju korisnika. 
-	Akcija za izmenu vodi na formu za izmenu korisnika, koja sadrži polja ime i prezime korisnika, email adresu i tip (admin ili content creator) uz prikaz njihovih trenutnih vrednosti.
-	Akcija za aktivaciju/deaktivaciju postoji samo uz korisnike tipa content creator. (admin se podrazumeva da je aktivan). Ova akcija menja status iz aktivan u neaktivan i obrnuto. Content creator sa neaktivnim statusom više neće imati pristup CMS-u.
Za oba tipa korisnika, u navigacionom meniju prikazati ime korisnika i dugme za logout.

4.	Platforma za čitanje vesti
Sajt za online čitanje vesti. U navigacionom meniju treba prikazati sledeće stavke: “home page”, “najčitanije”, sve dostupne kategorije i polje za pretragu vesti. 
-	Home page: Stranica koja sadrži listu 10 najnovijih vesti, sortiranih po datumu kreiranja, opadajuće. Svaka stavka u listi ima naslov, limitiran deo teksta, kojoj kategoriji pripada i datum objave.
-	Najčitanije: Prikazuje 10 najčitanijih vesti kreiranih u proteklih 30 dana.
-	Svaka stavka kategorije: Prikazuje listu svih vesti koje pripadaju odabranoj kategoriji. Svaka stavka u listi ima naslov, limitiran deo teksta i datum objave.
-	Pretraga vesti: Daje korisniku mogućnost da pretražuje vesti na platformi po tekstu. Pretraga radi po principu provere da li se uneti tekst nalazi u naslovu vesti ili u tekstu same vesti. Na primer ako korisnik u polje unese "Novak Đoković" potrebno je vratiti sve vesti (uz ispoštovanu paginaciju) koje u naslovu ili u tekstu vesti sadrže "Novak Đoković".
Klikom na vest, sa bilo kog od navedenih izvora, potrebno je prikazati čitavu vest, tj. naslov, tekst, datum kreiranja, ime autora, tagove koji su dodeljeni toj vesti i sve komentare koji pripadaju toj vesti, sortirane po datumu kreiranja, opadajuće. Uz svaki komentar prikazati i ime autora komentara i datum kreiranja. Iznad liste sa postojećim komentarima, potrebno je implementirati formu i funckionalnost za dodavanje novog komentara. Forma za dodavanje komentara sadrži ime čitalaca i tekst samog komentara, polja koja su obavezna.
Komentar ima opciju like i dislike. Korisnik može dati samo jedan like/dislike, ne i oba, na istom komentaru. Neophodno je identifikovati korisnika koji dolazi sa jednog računara ili sa jedne sesije, kako bi mu zabranili mogućnost za like i dislike na komentaru koji je on već like-ovao ili dislike-ovao. Pored komentara potrebno je prikazati i trenutni broj like-ova i dislike-ova. Ovo ne znači da korisnik mora biti ulogovan da bi mogao da ostavi like ili dislike na komentaru.
Otvaranjem jedne vesti se inkrementira broj poseta toj vesti. Neophodno je identifikovati korisnika koji dolazi sa jednog računara ili sa jedne sesije, tako da se broj pregleda ne povećava ako taj korisnik ponovo otvori istu vest (ovo ne znači da korisnik mora biti ulogovan da bi pročitao vest sa platforme za čitanje). 
Vest takođe ima opciju like i dislike. Korisnik može dati samo jedan lajk/dislike, ne i oba, na istoj vesti. Neophodno je identifikovati korisnika koji dolazi sa jednog računara ili sa jedne sesije, kako bi mu zabranili mogućnost za like i dislike vesti koju je on već like-ovao ili dislike-ovao. Ispod naslova vesti prikazati i trenutni broj like-ova i dislike-ova. Ovo ne znači da korisnik mora biti ulogovan da bi mogao da ostavi like ili dislike.
Tag je link. Klikom na tag, korisniku se otvara stranica sa listom svih vesti koje sadrže taj tag. Svaka stavka u listi ima naslov, limitiran deo teksta, kojoj kategoriji pripada i datum objave. Klikom na stavku otvara se stranica koja prikazuje sadržaj vesti, kao što je već navedeno.
Na svakoj stranici koja pripada platformi za čitanje vesti, u uglu, treba prikazati i sekciju sa 3 naslova koji imaju najviše reakcija (suma like-ova i dislike-ova), sortirano opadajuće. Naslov je link koji vodi na samu vest.
Na stranici gde se prikazuje sadržaj vesti napraviti sekciju "pročitaj još...". U ovoj sekciji se nalazi do 3 različitih naslova vesti koje sadrže bar jedan od tagova kao i vest na čijoj se stranici nalazimo. Naslov je link koji vodi na samu vest.

5.	Dodatni zahtevi
Skladištenje podataka
Sve entitete i trenutno stanje sistema čuvati u relacionoj bazi podataka.
Umesto baze podataka, moguće je čuvanje trenutnog stanja u memoriji aplikacije. Ovaj pristup uzrokuje oduzimanje 15 poena .
Kao backup, uz -15 poena, moguće je čuvanje trenutnog stanja u memoriji aplikacije.
Upravljanje greškama
Upravljanje greškama i validacija su obavezni i svaka funkcija mora da prijavi grešku ukoliko ulazni parametri ili interno stanje ne dozvoljavaju izvršenje operacije. 
-	Validacija na backendu je obavezna!
-	Voditi računa kod unosa koji su prazne vrednosti. 
-	Korisnika obavestiti kad god napravi grešku.
-	Ne sme se desiti registracija korisnika sa email-om koji već postoji. (slično i za druge entitete koji moraju imati jedinstvena polja).
Paginacija
Sve tabele i liste moraju imati paginaciju. 
Paginacija je funkcionalnost gde ne prikazujemo sve rezultate na jednom mestu, već ih rasporedjujemo po “stranicama”. Kroz stranice se prolazi sa dugmetom za prethodnu ili za sledeću stranu (ako postoje). Recimo da je limit 10 prikazanih rezultata, a u bazi postoji 25. Rezultat su 3 stranice (prve dve sa 10 i poslednja sa 5 rezultata) . Prelazak na drugu stranicu je novi zahtev koji sadrži broj željene stranice kao parametar, na osnovu koje će backend znati koji deo rezultata je potrebno dobiti iz baze: offset (current_page - 1) * 10 limit 10.

6.	Tehnologije 
Sistem treba da se sastoji iz dva dela:
-	Frontend: JQuery ili Vue.js. Stilizovanje je opciono i moguće je korišćenje CSS framework-a po izboru.
-	Backend: JAX-RS 

