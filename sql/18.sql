-- 18. Заключительная практика: задачки по SQL для игры Dwarf Fortress
-- Игра Dwarf Fortress управляется многими сущностями, которые взаимодействуют в сложной системе. Мы рассмотрим несколько основных сущностей: dwarves (гномы), squads (отряды), tasks (задачи) и items (предметы). Ваша задача состоит в создании SQL-запросов для анализа и управления данными.

-- База данных

-- Таблица Dwarves

-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | dwarf_id     | INT          | Уникальный идентификатор гнома            |
-- | name         | VARCHAR(100) | Имя гнома                                 |
-- | age          | INT          | Возраст гнома                             |
-- | profession   | VARCHAR(100) | Профессия гнома                           |
-- | squad_id     | INT          | Идентификатор отряда                      
--                                 (NULL, если не в отряде)                  |

-- Таблица Squads

-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | squad_id     | INT          | Уникальный идентификатор отряда           |
-- | name         | VARCHAR(100) | Название отряда                           |
-- | mission      | VARCHAR(100) | Текущая миссия отряда                     |

-- Таблица Tasks

-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | task_id      | INT          | Уникальный идентификатор задачи           |
-- | description  | VARCHAR(255) | Описание задачи                           |
-- | priority     | INT          | Приоритет задачи                          |
-- | assigned_to  | INT          | Идентификатор гнома, ответственного за задачу 
--                                 (NULL, если не назначена)                 |
-- | status       | VARCHAR(50)  | Статус задачи                             
--                         (например, 'pending', 'in_progress', 'completed') |

-- Таблица Items

-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | item_id      | INT          | Уникальный идентификатор предмета         |
-- | name         | VARCHAR(100) | Название предмета                         |
-- | type         | VARCHAR(100) | Тип предмета 
--                                 (например, 'weapon', 'armor', 'tool')     |
-- | owner_id     | INT          | Идентификатор гнома-владельца 
--                                 (NULL, если предмет общий)                |
-- Конечно, типы, статусы, профессии и т.д. лучше задавать числовыми идентификаторами, однако во множестве легаси-проектов не очень корректно используются строки.

-- Задачи решайте в голове!

-- 1. Получить информацию о всех гномах, 
-- которые входят в какой-либо отряд, 
-- вместе с информацией об их отрядах.
SELECT 
Dwarves.dwarf_id,
Dwarves.name,
Dwarves.age,
Dwarves.profession,
Squads.squad_id,
Squads.name,
Squads.mission
FROM Dwarves
JOIN Squads ON Squads.squad_id = Dwarves.squad_id;

-- 2. Найти всех гномов с профессией "miner", 
-- которые не состоят ни в одном отряде.
SELECT *
FROM Dwarves
WHERE profession = 'miner' 
AND squad_id IS NULL;

-- 3. Получить все задачи с наивысшим приоритетом, 
-- которые находятся в статусе "pending".
SELECT *
FROM Tasks
WHERE status = 'pending' 
AND priority = (SELECT MAX (priority) FROM Tasks WHERE status = 'pending');

-- 4. Для каждого гнома, 
-- который владеет хотя бы одним предметом, 
-- получить количество предметов, 
-- которыми он владеет.
SELECT 
Dwarves.dwarf_id,
Dwarves.name,
COUNT(Items.item_id)
FROM Dwarves
JOIN Items ON Items.owner_id = Dwarves.dwarf_id
GROUP BY Dwarves.dwarf_id, Dwarves.name;

-- 5. Получить список всех отрядов и 
-- количество гномов в каждом отряде. 
-- Также включите в выдачу отряды без гномов.

SELECT Squads.squad_id,
Squads.name,
Squads.mission,
COUNT(Dwarves.dwarf_id)
FROM Squads
LEFT JOIN Dwarves ON Dwarves.squad_id = Squads.squad_id
GROUP BY Squads.squad_id, Squads.name, Squads.mission;

-- 6. Получить список профессий 
-- с наибольшим количеством незавершённых задач 
--("pending" и "in_progress") у гномов этих профессий.

SELECT Dwarves.profession,
COUNT(*)
FROM Dwarves
JOIN Tasks ON Tasks.assigned_to = Dwarves.dwarf_id
WHERE Tasks.status IN ('pending', 'in_progress')
GROUP BY Dwarves.profession
ORDER BY COUNT(*) DESC;

-- 7. Для каждого типа предметов 
-- узнать средний возраст гномов, 
-- владеющих этими предметами.

SELECT Items.type,
AVG(Dwarves.age)
FROM Items
JOIN Dwarves ON Dwarves.dwarf_id = Items.owner_id
GROUP BY Items.type;

-- 8. Найти всех гномов старше среднего возраста 
-- (по всем гномам в базе), 
-- которые не владеют никакими предметами.

SELECT Dwarves.*
FROM Dwarves 
LEFT JOIN Items ON Items.owner_id = Dwarves.dwarf_id
WHERE Dwarves.age > (SELECT AVG(age) FROM Dwarves)
AND Items.owner_id IS NULL;

-- рефлексия (задание 18)
-- Повторил основные SQL - запросы.