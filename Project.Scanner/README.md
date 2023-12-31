1. Сборка контейнера стандартная: 
    docker build -t 'scanner' .

2. Для того, чтобы использовать скрипт сканирования, при запуске контейнера надо сразу передать в него аргументы скрипта Python (через "-e"), чтобы они записались в переменные окружения, а скрипт смог их увидеть. Механизм максимально простой: передали всё из терминала, получили ответ. Нет нужды подключаться к контейнеру через SSH или HTTP, делать какие-то дополнительные действия. Если задать параметр "--rm", то после отображения результатов контейнер удаляется.

3. Основные параметры, которые нужно передать при запуске контейнера:
    task: тип задачи. Два значения: scan (сканирование диапазона IP) и sendhttp (запрос HTTP).
    ip: начальный IP для сканирования. Обязательный параметр для scan.
    num: количество IP для сканирования. Обязательный параметр для scan.
    target: целевой адрес для HTTP-запроса. Обязательный параметр для sendhttp.
    met: метод HTTP-запроса. Два значения: GET и POST. Обязательный параметр для sendhttp.
    hd: заголовки для HTTP-запроса. Необязательный параметр для sendhttp.

4. Примеры.
    - Сканирование IP (ya.ru, 1 адрес): 
    ```
    docker run --rm -e task='scan' -e ip='77.88.55.242' -e num=1 scanner
    ```

    - HTTP-запрос:

    ```
    docker run --rm -e task='sendhttp' -e target='http://info.cern.ch/' -e met='GET' scanner
    ```