# 2.5. Задание
Разберитесь во взаимосвязях между таблицами northwind и опишите их (один-к-одному, один-ко-многим и многие-ко-многим).
Для случаев многие-ко-многим уточните, почему именно соответствущие таблицы относятся к этому типу.

1. Orders.
Имеет первичный ключ OrderID
Внешние ключи FK:
- FK_Orders_Customers (CustomerID) для связи с таблицей Customers.
	Customers - Orders. Один ко многим.
	Один клиент имеет много заказов
- FK_Orders_Employees (EmployeeID) для связи с таблицей Employees
	Employees - Orders. Один ко многим.
	Один сотрудник может оформить много заказов.
- FK_Orders_Shippers (ShipVia) для связи с таблицей Shippers
	Shippers - Orders. Один ко многим.
	Один перевозчик может доставить много заказов.

2. Order Details
Имеет составной первичный ключ OrderID и ProductID
Внешние ключи FK:
- FK_Order_Details_Orders (OrderID) - таблица Orders
- FK_Order_Details_Products(ProductID) - Таблица Products
Образует связь многие ко многим. 
Один заказ может содержать много товаров. 
Один товар может встречаться во множестве заказов.

3. Categories
Имеет первичный ключ CategoryID
Внешних ключей нет.
	Categories - Products. Один ко многим
	Одна категория содержит много товаров.

4. Customers
Имеет первичный ключ CustomerID
Внешних ключей нет.
	Customers - Orders. Один ко многим.
	Один клиент имеет много заказов
Связь многие ко многим с CustomerDemographics через CustomerCustomerDemo.

5. Employees
Имеет первичный ключ EmployeeID
Внешние ключи FK:
- FK_Employees_Employees (ReportsTo) - таблица Employees
Один руководитель может иметь несколько подчиненных.

	Employees - Orders. Один ко многим.
	Один сотрудник может оформить много заказов.

	Employees - Territories. Многие ко многим через EmployeeTerritories.

6. Products
Имеет первичный ключ ProductID
Внешние ключи FK:
- FK_Products_Categories (CategoryID) - таблица Categories
	Categories - Products. Один ко многим
	Одна категория содержит много товаров.
- FK_Products_Suppliers (SupplierID) - таблица Suppliers
	Suppliers - Products. Один ко многим
	Один поставщик может поставлять много товаров.

7. Shippers
Имеет первичный ключ ShipperID
Внешних ключей нет.
	Shippers - Orders. Один ко многим.
	Один перевозчик может доставить много заказов.

8. Suppliers
Имеет первичный ключ SupplierID
Внешних ключей нет.
	Suppliers - Products. Один ко многим
	Один поставщик может поставлять много товаров.

9. EmployeeTerritories
Имеет составной первичный ключ EmployeeID и TerritoryID
Внешние ключи FK:
- FK_EmployeeTerritories_Employees (EmployeeID) - таблица Employees
- FK_EmployeeTerritories_Territories (TerritoryID) - таблица Territories
Образует связь многие ко многим
Один сотрудник работает на нескольких территориях, а на одной территории работает несколько сотрудников.

10. Territories
Имеет первичный ключ TerritoryID
Внешние ключи FK:
FK_Territories_Region (RegionID) - таблица Region
Region - Territories. Один ко многим. 
Один регион включает много территорий.

11. Region
Имеет первичный ключ RegionID
Внешних ключей нет.
Region - Territories. Один ко многим. 
Один регион включает много территорий.

12. CustomerDemographics
Имеет первичный ключ CustomerTypeID
Внешних ключей нет.
Связь многие ко многим с Customers через CustomerCustomerDemo
Один клиент имеет несколько типов, а один тип клиента может быть у нескольких клиентов.

13. CustomerCustomerDemo
Имеет составной первичный ключ CustomerID и CustomerTypeID
Внешние ключи FK:
- FK_CustomerCustomerDemo (CustomerTypeID) - таблица CustomerDemographics
- FK_CustomerCustomerDemo_Customers (CustomerID) - Таблица Customers
Связь многие ко многим с Customers через CustomerCustomerDemo
Один клиент имеет несколько типов, а один тип клиента может быть у нескольких клиентов.

-- рефлексия (задание 2.5.1)
-- Изучил связи между таблицами, проверил первичные и внешние ключи. 
-- Разобрал типы связей между таблицами.