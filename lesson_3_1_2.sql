/*
 * 
 * Задание 1. В целом, каких-то явных замечанимй по усовершенствованию пока не вижу, возможно, в силу неопытности или ещё что-то, разве что просто расширить объём данных, например, в профиль информацию об 
 * образовании, месте работы, но такой цели не стоит в целом, можно было бы добавить возможность оставлять посты в группе, будучи админом. В целом вся структура понятна и ясна.
 * 
 * Задание 2. Создадим таблицу для постов.
 * 
 * Сценарий: Петя добавляет пост.
 * 
 * Петя может добавить текстовый пост (возьмём за условие обязательное наличие текста), а также прикрепить разные файлы медиа к нему (документы, изображение, музыку), однако автор только один (пользователь).
 * Связь от одного (пользователя) к многим (постам).
 * 
 */

CREATE TABLE post(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	post_text TEXT NOT NULL,
	media_id BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (media_id),
	KEY (user_id),
	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Добавим 2 поста, которые оставил Петя
INSERT INTO post VALUES (DEFAULT, 1, 'Всем привет! Я зарегистрировался в vk!', NULL, DEFAULT);
INSERT INTO post VALUES (DEFAULT, 1, 'Только посмотрите на это', 1, DEFAULT);

-- Добавим 1 пост, оставленный Васей
INSERT INTO post VALUES (DEFAULT, 3, 'Только посмотрите на этого милого котика', 2, DEFAULT);

/* Создадим табилцу для лайков.
 * 
 * Сценирай: Петя ставит лайк медиа, посту или профилю.
 * 
 * Петя может ставить лайк медиафайлам, постам или профилю пользователей.
 * Связь от одного (пользователя) к многим (медиа, постам, профилям)
 * 
 */

CREATE TABLE likes(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED DEFAULT NULL,
	post_id BIGINT UNSIGNED DEFAULT NULL,
	profile_id BIGINT UNSIGNED DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (media_id),
	KEY (user_id),
	KEY (profile_id),
	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (post_id) REFERENCES post(id),
	FOREIGN KEY (profile_id) REFERENCES profiles(user_id)
);

-- Добавим 2 лайка от Пети на пост с котиком от Васи (post_id = 3) и на медиафайл 1
INSERT INTO likes VALUES (DEFAULT, 1, DEFAULT, 3, DEFAULT, DEFAULT);
INSERT INTO likes VALUES (DEFAULT, 1, 1, DEFAULT, DEFAULT, DEFAULT);

-- Добавим 1 лак от Васи на профиль Пети
INSERT INTO likes VALUES (DEFAULT, 3, DEFAULT, DEFAULT, 1, DEFAULT);

