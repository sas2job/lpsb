-- 11. JOIN (продолжение) и UNION
-- 11.1. LEFT JOIN / LEFT OUTER JOIN

-- Это частный случай формы FULL JOIN, когда мы получаем данные из первой ("левой") таблицы вместе с данными из "правой" таблицы, которые пересекаются с первой. Остальные данные правой таблицы исключаются.


-- SELECT Customers.CompanyName, Orders.OrderID FROM Customers 
-- LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
-- ORDER BY Customers.CompanyName; 
-- Мы получим все записи из таблицы пользователей Customers, даже если им не найдено сопоставлений из таблицы заказов Orders.

-- 11.2. RIGHT JOIN

-- Схема аналогична предыдущей, только в качестве базовой мы берём "правую" таблицу:


-- SELECT Orders.OrderID, Employees.LastName, Employees.FirstName FROM Orders 
-- RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID 
-- ORDER BY Orders.OrderID; 
-- Мы получим все записи из таблицы исполнителей Employees, даже если для них нет соответствия в таблице заказов Orders.

-- 11.3. SELF JOIN

-- Это вариант комбинирования таблицы с самой собой. Похожую технику мы уже рассматривали ранее. Например, мы хотим получить все пары пользователей из одного города:


-- SELECT A.CompanyName AS CustomerName1, B.CompanyName AS CustomerName2, A.City 
-- FROM Customers A, Customers B 
-- WHERE A.CustomerID <> B.CustomerID AND A.City = B.City 
-- ORDER BY A.City;
-- 11.4. UNION

-- С помощью оператора UNION мы можем скомбинировать результаты двух SQL-запросов по полям, которые в общем случае не являются ключевыми, но должны иметь одинаковые типы. По умолчанию UNION исключает дублирующиеся значения, а если они требуются, надо использовать UNION ALL.

-- Например, мы хотим отобрать все города из двух таблиц -- пользователей Customers и поставщиков Suppliers:


-- SELECT City FROM Customers 
-- UNION ALL 
-- SELECT City FROM Suppliers 
-- ORDER BY City; 
-- В каждом из запросов SELECT можно использовать условие отбора:


-- SELECT City, Country 
-- FROM Customers 
-- WHERE Country='USA' 
-- UNION 
-- SELECT City, Country 
-- FROM Suppliers 
-- WHERE Country='USA' 
-- ORDER BY City; 
-- Чтобы разделить записи по таблицам, можно в каждый SELECT включить собственное идентификационное поле:


-- SELECT 'Customer' As Type, City, Country FROM Customers 
-- WHERE Country='USA' 
-- UNION 
-- SELECT 'Supplier' As Type, City, Country FROM Suppliers 
-- WHERE Country='USA' 
-- ORDER BY City; 


-- 11.5. Задания

-- 11.5.1. Отберите с помощью LEFT JOIN все записи из таблицы Customers, для которых FK-ключ таблицы Orders пустой.

SELECT Customers.*
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE Orders.CustomerID IS NULL;

-- 11.5.2. Выведите конкретную информацию по всем пользователям Customers и поставщикам Suppliers -- имя контактной персоны, город и страну, а также идентификацию группы (пользователь или поставщик).
SELECT
ContactName,
City,
Country,
'Customer' AS Type
FROM Customers
UNION ALL
SELECT 
ContactName,
City,
Country,
'Supplier' AS Type
FROM Suppliers
ORDER BY ContactName;

-- рефлексия (задание 11.5)
-- Изучен LEFT JOIN и UNION. Научился находить записи без связей и объединять данные из разных таблиц.