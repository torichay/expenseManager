package interfaces;

/**
 *  Содержит основные опперации относящиеся ко всем
 *  сущностям обьектной модели, расширяющие его интерфейсы
 *  добавляют методы относящие только к своей сущности.
 *
 *  В классе Main описан пример подключения к H2 через JDBC
 *  а также примеры для работы с таблицами.
 *
 *  Медод load() используется для поднятия данных из БД по входящему ID
 *
 *
 *  Задача:
 *  1) Создать собственный пакет - например Ivanov
 *  2) Имплементировать данный набор интерфейсов
 *  3) Реализовать в Main меню для работы с ними.
 *  4) Добавить валидации на CRUD опперации с пробросом ошибок.
 *
 */

public interface Entity {
    void create();
    void delete();
    void update();
    boolean load(Integer id);
}
