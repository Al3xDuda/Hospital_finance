CREATE SCHEMA hospital;
--SHOW search_path;
SET search_path TO hospital;


CREATE TABLE Employees(
	id INTEGER  PRIMARY KEY ,
	imię VARCHAR(30) NOT NULL,
	nazwisko VARCHAR(30) NOT NULL,
	Stanowisko VARCHAR(50) NOT NULL,
	Adres VARCHAR(100) NOT NULL,
	pesel VARCHAR(11) NOT NULL,
	stawka_godzinowa DECIMAL NOT NULL,
	UNIQUE(pesel)
);
CREATE TABLE płaca(
	id INTEGER PRIMARY KEY,
	id_pracownika INTEGER NOT NULL,
	miesiąc INTEGER NOT NULL,
	rok INTEGER NOT NULL,
	ilość_przepracowanych_godzin INTEGER DEFAULT 0,
	kwota_wypłaty DECIMAL DEFAULT 0,
	UNIQUE(id_pracownika,miesiąc),
	FOREIGN KEY (id_pracownika) REFERENCES Employees(id)
);
CREATE TABLE szpital(
	id INTEGER PRIMARY KEY,
	adres VARCHAR(100) NOT NULL,
	rachunek DECIMAL DEFAULT 0
);
CREATE TABLE oddział(
	id INTEGER PRIMARY KEY,
	id_szpitala INTEGER NOT NULL,
	rok INTEGER NOT NULL,
	nazwa VARCHAR(50) NOT NULL,
	roczna_ilość_przydzielonych_pieniędzy INTEGER NOT NULL,
	bilans DECIMAL DEFAULT 0,
	UNIQUE(id_szpitala,rok,nazwa),
	FOREIGN KEY (id_szpitala) REFERENCES szpital(id)
);

CREATE TABLE grafik(
	id  INTEGER PRIMARY KEY,
	id_oddziału INTEGER NOT NULL,
	numer_miesiąca integer NOT NULL,
	suma_wydatków DECIMAL DEFAULT 0,
	suma_przychodów DECIMAL DEFAULT 0,
	UNIQUE(id_oddziału,numer_miesiąca),
	FOREIGN KEY (id_oddziału) REFERENCES oddział(id)
);
CREATE TABLE dzień(
	id INTEGER PRIMARY KEY,
	numer_dnia INTEGER NOT NULL,
	id_grafiku INTEGER NOT NULL,
	wydatek DECIMAL DEFAULT 0,
	przychód DECIMAL DEFAULT 0,
	UNIQUE(numer_dnia,id_grafiku),
	FOREIGN KEY (id_grafiku) REFERENCES grafik(id)
);

CREATE TABLE zmiana(
	id INTEGER PRIMARY KEY,
	id_pracownika INTEGER,
	id_oddziału INTEGER NOT NULL,
	id_dnia INTEGER NOT NULL,
	ilość_przepracowanych_godzin INTEGER NOT NULL,
	należna_kwota_pieniędzy DECIMAL DEFAULT 0 check(ilość_przepracowanych_godzin BETWEEN 0 AND 24),
	zmiana_nocna BOOL NOT NULL,
	FOREIGN KEY (id_pracownika) REFERENCES Employees(id),
	FOREIGN KEY (id_dnia) REFERENCES dzień(id),
	FOREIGN KEY (id_oddziału) REFERENCES oddział(id)
);
------------------------------------------------------------------------------------------------

