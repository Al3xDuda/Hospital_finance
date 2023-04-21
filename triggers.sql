CREATE TRIGGER update_rachunek
AFTER INSERT OR UPDATE ON  oddział
FOR EACH ROW
EXECUTE PROCEDURE update_rachunek_function();


CREATE TRIGGER bilans_update
AFTER INSERT OR UPDATE ON  grafik
FOR EACH ROW
EXECUTE PROCEDURE update_bilans_function();


CREATE TRIGGER suma_wydatków
AFTER INSERT OR UPDATE ON  dzień
FOR EACH ROW
EXECUTE PROCEDURE update_suma_wydatków_function();


CREATE TRIGGER suma_przychodów
AFTER INSERT OR UPDATE ON  dzień
FOR EACH ROW
EXECUTE PROCEDURE update_suma_przychodów_function();


CREATE TRIGGER update_wydatek
AFTER INSERT OR UPDATE ON  zmiana
FOR EACH ROW
EXECUTE PROCEDURE update_wydatek_function();

CREATE TRIGGER należna_kwota_pieniędzy
AFTER INSERT OR UPDATE ON  zmiana
FOR EACH ROW
WHEN (pg_trigger_depth() < 1)
EXECUTE PROCEDURE update_należna_kwota_pieniędzy_function();

CREATE TRIGGER update_ilość_przepracowanych_godzin
AFTER INSERT OR UPDATE ON  zmiana 
FOR EACH ROW
EXECUTE PROCEDURE update_ilość_przepracowanych_godzin_function();

CREATE TRIGGER update_kwota_wypłaty
AFTER INSERT OR UPDATE ON  zmiana
FOR EACH ROW 
EXECUTE PROCEDURE update_kwota_wypłaty();


CREATE TRIGGER update_bilans
AFTER INSERT OR UPDATE ON  oddział 
FOR EACH ROW 
WHEN (pg_trigger_depth() <1)
EXECUTE PROCEDURE update_bilans_2_function();

CREATE TRIGGER update_id_pracownika_on_delete
BEFORE DELETE ON  pracownik
FOR EACH ROW
EXECUTE FUNCTION update_id_pracownika_on_delete();