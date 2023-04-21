CREATE OR REPLACE FUNCTION update_rachunek_function() 
RETURNS TRIGGER
AS
$$
BEGIN
	UPDATE szpital s
	SET rachunek=(SELECT SUM(o.bilans) FROM testoddział o WHERE o.id_szpitala=NEW.id_szpitala) WHERE s.id=NEW.id_szpitala;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE	OR REPLACE FUNCTION update_bilans_function()
RETURNS TRIGGER
AS
$$
BEGIN
	
	UPDATE  oddział o
	SET bilans=(o.roczna_ilość_przydzielonych_pieniędzy-(SELECT SUM(g.suma_wydatków -g.suma_przychodów) FROM  grafik g WHERE NEW.id_oddziału=g.id_oddziału))
	WHERE o.id=NEW.id_oddziału;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_suma_wydatków_function()
RETURNS TRIGGER
AS
$$
BEGIN
  UPDATE  grafik g
  SET suma_wydatków = (suma_wydatków+(NEW.wydatek-COALESCE(OLD.wydatek,0)))
  WHERE g.id = NEW.id_grafiku;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_suma_przychodów_function()
RETURNS TRIGGER
AS
$$
BEGIN
  UPDATE  grafik g
  SET suma_przychodów = (suma_przychodów+(NEW.przychód-COALESCE(OLD.przychód,0)))
  WHERE g.id = NEW.id_grafiku;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_wydatek_function()
RETURNS TRIGGER
AS $$
BEGIN
  UPDATE  dzień d
  SET wydatek = wydatek + NEW.należna_kwota_pieniędzy-COALESCE(OLD.należna_kwota_pieniędzy,0)
  WHERE d.id = NEW.id_dnia;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_należna_kwota_pieniędzy_function()
RETURNS TRIGGER
AS
$$
BEGIN
	UPDATE  zmiana z
	SET należna_kwota_pieniędzy =(CASE WHEN NEW.zmiana_nocna THEN (SELECT pr.stawka_godzinowa FROM  pracownik pr WHERE pr.id=NEW.id_pracownika)*z.ilość_przepracowanych_godzin*1.5
								  ELSE (SELECT pr.stawka_godzinowa FROM  pracownik pr WHERE pr.id=NEW.id_pracownika)*z.ilość_przepracowanych_godzin 
								  END)
	WHERE z.id = NEW.id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_ilość_przepracowanych_godzin_function()
RETURNS TRIGGER
AS
$$
  DECLARE _month INTEGER;
  DECLARE _year INTEGER;
  DECLARE _sum_hours INTEGER;
BEGIN
  
  SELECT numer_miesiąca,o.rok  INTO _month, _year
  FROM  grafik g
  JOIN  dzień d ON g.id = d.id_grafiku
  JOIN  zmiana z ON d.id = z.id_dnia
  JOIN  oddział o ON g.id_oddziału = o.id
  WHERE z.id = NEW.id;

 SELECT SUM(ilość_przepracowanych_godzin)
  INTO _sum_hours
  FROM  zmiana z
  JOIN  dzień  d ON z.id_dnia = d.id
  JOIN  grafik g ON d.id_grafiku = g.id
  JOIN  oddział o ON g.id_oddziału = o.id
  WHERE g.numer_miesiąca = _month AND o.rok = _year AND z.id_pracownika = NEW.id_pracownika;

 UPDATE  płaca p
  SET ilość_przepracowanych_godzin = _sum_hours WHERE id_pracownika=NEW.id_pracownika AND p.miesiąc=_month AND p.rok=_year;
 RETURN NEW;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_kwota_wypłaty()
RETURNS TRIGGER
AS
$$

  DECLARE _month INTEGER;
  DECLARE _year INTEGER;
  DECLARE _sum_pay INTEGER;
BEGIN
  
  SELECT numer_miesiąca,o.rok  INTO _month, _year
  FROM  grafik g
  JOIN  dzień d ON g.id = d.id_grafiku
  JOIN  zmiana z ON d.id = z.id_dnia
  JOIN  oddział o ON g.id_oddziału = o.id
  WHERE z.id = NEW.id;

 SELECT SUM(należna_kwota_pieniędzy)
  INTO _sum_pay
  FROM  zmiana z
  JOIN  dzień  d ON z.id_dnia = d.id
  JOIN  grafik g ON d.id_grafiku = g.id
  JOIN  oddział o ON g.id_oddziału = o.id
  WHERE g.numer_miesiąca = _month AND o.rok = _year AND z.id_pracownika = NEW.id_pracownika;

 UPDATE  płaca p
  SET kwota_wypłaty = _sum_pay WHERE id_pracownika=NEW.id_pracownika AND p.miesiąc=_month AND p.rok=_year;
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE  FUNCTION update_bilans_2_function()
RETURNS TRIGGER 
AS 
$$
BEGIN 
	UPDATE  oddział o
	SET bilans=bilans+NEW.roczna_ilość_przydzielonych_pieniędzy-COALESCE(OLD.roczna_ilość_przydzielonych_pieniędzy,0) WHERE o.id=NEW.id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION update_id_pracownika_on_delete()
RETURNS TRIGGER
AS 
$$
BEGIN
	UPDATE  zmiana
	SET id_pracownika=NULL WHERE id_pracownika=OLD.id;
	DELETE FROM  płaca WHERE id_pracownika = OLD.id;
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;


