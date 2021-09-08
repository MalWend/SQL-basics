USE SDA;

-- --- SELECT --- --
-- Wszystkie wiersze i kolumny z tabeli.
SELECT * FROM employees;

-- Wyświetlenie wybranych kolumn
SELECT last_name, hire_date, first_name FROM employees;

-- Aliasowanie kolumn
SELECT last_name AS nazwisko,
	hire_date AS data_zatrudnienia,
    first_name AS imie
FROM employees;

-- Ograniczenie liczby wyświetlanych wierszy
SELECT * FROM books LIMIT 5;

-- Unikatowe wiersze na poziomie wiersza!
-- Tylko unikatowe wydawnictwa
SELECT DISTINCT publisher FROM books;
-- Tylko zestaw unikatowy wydawnictwo+kategoria
SELECT DISTINCT publisher, cat_id FROM books;

/*
1. Wyświetl wszystko z tabeli departments.
2. Wyświetl imie, nazwisko, telefon z tabeli customers.
3. Wyświetl unikatowe wartości job_id z tabeli employees.
4. Wyświetl tylko 2 wiersze z tabeli categories.
5. Z tabeli rents kolumn book_id jako ID_KSIAZKI oraz cus_ID jako ID_KLIENTA.

Hint!: DESC nazwa_tabeli;
*/

-- --- ORDER BY --- --
-- Sortowanie ASC (domyślnie)
SELECT last_name AS nazwisko,
	hire_date AS data_zatrudnienia,
    first_name AS imie
FROM employees
ORDER BY hire_date;

-- Sortowanie po więcej niż 1 kolumnie
SELECT last_name AS nazwisko,
	hire_date AS data_zatrudnienia,
    first_name AS imie
FROM employees
ORDER BY hire_date, first_name DESC;

-- ORDER BY + LIMIT / Sortowanie po kolumnie ktorej nie ma wymienionej w SELECT
SELECT first_name, last_name
FROM customers
ORDER BY ID desc
LIMIT 2;

/*
1. Wyświetl 1 książkę, która jest najstarsza (tabela books).
2. Posortować kategories z categories po ID malejąco.
3. Posortować pracowników po job_id malejąco, i po dep_id rosnąco.
4. Posortować po rent_date od najmlodszej i po book_id rosnaco. (tabela rents).
*/

-- --- WHERE --- --
-- Operacje arytmetyczne
SELECT * FROM employees
WHERE salary > 9000
ORDER BY salary;

SELECT * FROM books
WHERE publisher = 'MAG';

-- BETWEEN .. AND ..
SELECT * FROM books
WHERE ID >= 5 AND ID <= 10;
-- ==
SELECT * FROM books
WHERE ID BETWEEN 5 AND 10;

-- IN / NOT IN
SELECT * FROM employees
WHERE dep_id = 2 OR dep_id = 4;
-- ==
SELECT * FROM employees
WHERE dep_id IN (2,4);

-- IS NULL / IS NOT NULL
SELECT * FROM employees
WHERE man_id IS NULL;

-- LIKE / NOT LIKE
-- % -> dowolna ilość dowolnych znaków | _ -> dowolny 1 znak.
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'A%';

SELECT *
FROM books
WHERE name LIKE 'P%a';

SELECT *
FROM books
WHERE publisher LIKE 'F__r%';

/*
1. Wyświetl pracowników tylko z trzeciego oddzialu.
2. Wyświetl wypożyczenia o ID pomiedzy 3-5.
3. Wyświetl książki wydane po 2020-04-01.
4. Wyświetl pracowników ktorzy pracuja na stanowisko (job_id) 1 lub 2.
5. Wyświetl kategorie (tabela categories / kolumna name) zaczynaja sie na litere B.
*/

-- --- JOIN --- --
-- ID z tabeli departments == dep_id z tabeli employees
SELECT e.first_name, e.last_name, e.ID AS ID_pracownika, d.name, d.ID AS ID_oddzialu
FROM employees AS e
JOIN departments AS d ON e.dep_id = d.ID;

SELECT first_name, last_name, ID AS ID_pracownika, name, ID AS ID_oddzialu
FROM employees
JOIN departments ON dep_id = ID;
-- Error Code: 1052. Column 'ID' in field list is ambiguous	0.000 sec

SELECT * FROM categories;
SELECT * FROM books;

SELECT b.name, c.name
FROM books AS b
JOIN categories AS c ON c.ID = b.cat_id;

/*
1. Imie i nazwisko pracownika oraz nazwe jego stanowiska (job_id i ID z tabeli Jobs)
2. ID wypozyczenia, date wypozyczenia, nazwe wypozyczonej ksiazki (book_id = ID z tabeli books)
*/

-- 1
SELECT e.first_name, e.last_name, j.name 
FROM employees AS e 
JOIN jobs AS j on e.job_id = j.ID; -- ON PRIMARY_KEY_A = FOREIGN_KEY_FROM_A

-- 2
SELECT r.ID, r.rent_date, b.name
FROM rents AS r
JOIN books AS b ON b.ID = r.book_ID;