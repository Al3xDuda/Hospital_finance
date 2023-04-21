--INSERT

INSERT INTO  dzień (id,numer_dnia,id_grafiku,przychód)
	VALUES (1,1,1,1000);
INSERT INTO  dzień (id,numer_dnia,id_grafiku,przychód)
	VALUES (2,2,2,200);

INSERT INTO  zmiana (id,id_pracownika,id_oddziału,id_dnia,ilość_przepracowanych_godzin,zmiana_nocna)
	VALUES (1,1,1,1,8,false);
INSERT INTO  zmiana (id,id_pracownika,id_oddziału,id_dnia,ilość_przepracowanych_godzin,zmiana_nocna)
	VALUES (2,1,2,2,8,true);


INSERT INTO  szpital (id,adres)
	VALUES (1,'ul. Kamieńskiego');

INSERT INTO  oddział (id,id_szpitala,rok,nazwa,roczna_ilość_przydzielonych_pieniędzy)
	VALUES (1,1,2023,'Oddział Kardiologiczny',50000);
INSERT INTO  oddział (id,id_szpitala,rok,nazwa,roczna_ilość_przydzielonych_pieniędzy)
	VALUES (2,1,2023,'Blok operacyjny',100000);

INSERT INTO  grafik(id,id_oddziału,numer_miesiąca)
	VALUES (1,1,1);
INSERT INTO  grafik(id,id_oddziału,numer_miesiąca)
	VALUES (2,1,2);
INSERT INTO  grafik(id,id_oddziału,numer_miesiąca)
	VALUES (3,2,1);
INSERT INTO  grafik(id,id_oddziału,numer_miesiąca)
	VALUES (4,2,2);

INSERT INTO  pracownik (id,imię,nazwisko,stanowisko,adres,pesel,stawka_godzinowa)
	VALUES (1,'ALeksander ','Duda','Kardiolog','ul. Wrocławska','01234567890',50);
INSERT INTO  pracownik (id,imię,nazwisko,stanowisko,adres,pesel,stawka_godzinowa)
	VALUES (2,'Grzegorz','Kowalski','Recepconijsta','ul Krakowska','01234567891',10);

INSERT INTO  płaca (id,id_pracownika,miesiąc,rok)
	VALUES (1,1,1,2023);
INSERT INTO  płaca (id,id_pracownika,miesiąc,rok)
	VALUES (2,1,2,2023);
INSERT INTO  płaca (id,id_pracownika,miesiąc,rok)
	VALUES (4,2,1,2023);
INSERT INTO  płaca (id,id_pracownika,miesiąc,rok)
	VALUES (5,2,2,2023);