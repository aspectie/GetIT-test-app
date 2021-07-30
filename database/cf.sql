-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3305
-- Время создания: Июл 30 2021 г., 20:30
-- Версия сервера: 8.0.19
-- Версия PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `cf`
--

-- --------------------------------------------------------

--
-- Структура таблицы `mistakes`
--

CREATE TABLE `mistakes` (
  `mistake_id` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `shortDesc` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user` int NOT NULL,
  `status` set('Новая','Открытая','Решенная','Закрытая') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `urgency` set('Очень Срочно','Срочно','Не срочно','Совсем не срочно') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `criticality` set('Авария','Критичная','Не критичная','Запрос на изменение') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mistakes`
--

INSERT INTO `mistakes` (`mistake_id`, `date`, `shortDesc`, `description`, `user`, `status`, `urgency`, `criticality`) VALUES
(1, '2021-07-07 21:00:00', 'краткое описание', 'описание', 1, 'Новая', 'Не срочно', 'Не критичная');

-- --------------------------------------------------------

--
-- Структура таблицы `mistake_story`
--

CREATE TABLE `mistake_story` (
  `id` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `action` set('Ввод','Открытие','Решение','Закрытие') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user` int NOT NULL,
  `mistake` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mistake_story`
--

INSERT INTO `mistake_story` (`id`, `date`, `action`, `comment`, `user`, `mistake`) VALUES
(1, '2021-07-29 08:35:54', 'Ввод', '555', 1, 1),
(79, '2021-07-29 08:35:54', 'Ввод', 'комментарий', 1, 1);

--
-- Триггеры `mistake_story`
--
DELIMITER $$
CREATE TRIGGER `mistakeChangeStatus` AFTER INSERT ON `mistake_story` FOR EACH ROW UPDATE mistakes  
SET mistakes.status = NEW.action+0
WHERE mistakes.mistake_id = NEW.mistake
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `account_id` int NOT NULL,
  `name` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `surname` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` set('admin','user') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`account_id`, `name`, `surname`, `password`, `role`) VALUES
(1, 'admin', 'root', 'admin', 'admin'),
(2, 'user', 'surname', 'user', 'user');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `mistakes`
--
ALTER TABLE `mistakes`
  ADD PRIMARY KEY (`mistake_id`),
  ADD KEY `user_index` (`user`) USING BTREE;

--
-- Индексы таблицы `mistake_story`
--
ALTER TABLE `mistake_story`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_index` (`user`),
  ADD KEY `mistake_index` (`mistake`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`account_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `mistakes`
--
ALTER TABLE `mistakes`
  MODIFY `mistake_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `mistake_story`
--
ALTER TABLE `mistake_story`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `account_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `mistakes`
--
ALTER TABLE `mistakes`
  ADD CONSTRAINT `mistakes_user_FK` FOREIGN KEY (`user`) REFERENCES `users` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `mistake_story`
--
ALTER TABLE `mistake_story`
  ADD CONSTRAINT `mistake_story_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mistake_story_ibfk_2` FOREIGN KEY (`mistake`) REFERENCES `mistakes` (`mistake_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
