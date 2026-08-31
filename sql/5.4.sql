-- 5.4. Задания
-- 5.4.1. Отсортируйте список сотрудников Employees по дате рождения, начиная с самых молодых, и по стране.
SELECT * 
FROM Employees 
ORDER BY BirthDate DESC, Country;

-- 5.4.2. Исключите из предыдущего набора те записи, в которых поле Region равно NULL.
SELECT * 
FROM Employees 
WHERE Region IS NOT NULL
ORDER BY BirthDate DESC, Country;

-- 5.4.3. Найдите среднюю, минимальную и максимальную цены по полю UnitPrice из таблицы Order Details.
SELECT 
MAX(UnitPrice), 
MIN(UnitPrice),
AVG(UnitPrice) FROM [Order Details];

-- 5.4.4. Подсчитайте количество уникальных городов в списке пользователей (Customers).
SELECT COUNT(DISTINCT City) FROM Customers;

-- рефлексия (задание 5.4)
-- Узнал:
-- - как задавать сортировку по нескольким полям последовательно.
-- - как можно выводить вычисляемые значения по данным таблицы, используя агрегатные функции
-- - как используются предикаты.