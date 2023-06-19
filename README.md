# Тестовое задание на должность iOS/macOS разработчика.
## Задача
___
Разработать и протестировать приложение для iPhone с использованием среды разработки Xcode.

<img src="[https://github.com/nabiull1n/MovviApp/blob/main/Images/MovviApp.gif](https://github.com/nabiull1n/testTaskPlayer/blob/main/Simulator%20Screen%20Recording%20-%20iPhone%2013%20-%202023-06-12%20at%2019.44.10.gif)" width="300">

___
## Описание

Приложение для iPhone, представляющее из себя аудио проигрыватель.

Пользователь выбирает из списка треков один из треков и открывается окно проигрывателя с элементами управления воспроизведения и с
основной информации о треке.

Приложение должно состоять из двух экранов:<br>
• Экран со списком треков<br>
• Экран проигрывателя.<br>

На экране списка отобразить треки с отображением названия и длительности каждого трека. Чтобы получить список, понадобится
закинуть несколько треков в проект.

На экране проигрывателя выводить информацию о треке: Название,
исполнитель, текущее время, длительность трека и кнопка закрытия.
Также на экране проигрывателя должны быть элементы управления:
Воспроизведение/пауза, следующий/предыдущий трек и полоса
прогресса. После окончания трека идёт переключение на следующий
трек (на первый, если трек в списке был последний). При возврате на
экран списка, воспроизведение не останавливается и продолжается
при возврате на тот же трек, либо останавливается и переключается
при выборе другого трека.

Дополнительное задание: Брать название песни и имя исполнителя из
метаданных файла.

## Технические требования

Для реализации интерфейса пользователя необходимо
использовать стандартные элементы UIKit. Желательно
показать, как работу со Storyboard/XIB, так и программную
вёрстку.
Приложение должно поддерживать только вертикальную
ориентацию экрана.
Необходимо использование одного из архитектурных
подходов: MVC, MVP, MVVM, VIPER c обоснованием выбора.
Обоснование прикрепить в Readme проекта.
Всю разработку необходимо вести с применением системы
контроля версий GIT. Площадку для размещения выбрать на
свое усмотрение: GitHub, GitLab, BitBucket