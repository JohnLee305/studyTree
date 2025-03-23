<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pomodor</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                flex-direction: column;
                font-family: Arial, sans-serif;
                background-size: cover;
                background-position: center;
            }

            .content {
                margin-top: 20%;
                margin-bottom: 20%;
                border: 2px dashed white;
                margin-left: 70%;
                padding: 3%;
                border-radius: 5%;
                background-color: rgba(255, 255, 255, 0.5);
                /* Transparent background */
                text-align: center;
                /* Center align content */
            }

            .content * {
                opacity: 1;
                /* Ensure inner elements are opaque */
            }

            .logo {
                color: white;
                font-size: 40px;
                font-weight: bold;
                text-shadow: 2px 2px 4px #000000;
            }

            #timer {
                font-size: 48px;
                margin: 20px 0;
                padding: 10px;
                border-radius: 10px;
                background-color: rgba(255, 255, 255, 0.8);
                /* Semi-transparent background for readability */
            }

            #progress {
                font-size: 24px;
                margin: 10px 0;
            }

            button {
                padding: 10px 20px;
                font-size: 16px;
                margin: 5px;
            }

            .circle-container {
                display: flex;
                justify-content: center;
                margin: 20px 0;
            }

            .circle {
                width: 20px;
                height: 20px;
                border-radius: 50%;
                background-color: pink;
                margin: 0 5px;
            }

            #messages {
                width: 100%;
                height: 100px;
                border: 1px solid #ccc;
                padding: 10px;
                margin-top: 20px;
                overflow-y: auto;
                font-family: Arial, sans-serif;
                font-size: 14px;
                background-color: #f9f9f9;
            }

            #settings,
            #pomodoro {
                display: none;
            }
        </style>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
    </head>

    <body>
        <div class="content">
            <div class="circle-container">
                <button onclick="showSettings()">Settings</button>
                <button onclick="showPomodoro()">Pomodoro</button>
                <!-- <button onclick="showHabitTracker()">Habit Tracker</button> -->
            </div>
            <div id="settings">
                <h1>Settings</h1>
                <div>
                    <label for="work-time-input">Set Work Time (minutes): </label>
                    <input type="number" id="work-time-input" value="45">
                    <button onclick="setWorkTime()">Set Work Time</button>
                </div>
                <div>
                    <label for="break-time-input">Set Break Time (minutes): </label>
                    <input type="number" id="break-time-input" value="15">
                    <button onclick="setBreakTime()">Set Break Time</button>
                </div>
                <!--<button onclick="saveSettings()">Save Settings</button>-->
                <button onclick="saveSettingsToLocalStorage()">Save Settings</button>
                <input type="file" id="settings-file-input" accept=".txt" style="display:none"
                    onchange="loadSettingsFromFile(event)">
                <!--<button onclick="document.getElementById('settings-file-input').click()">Load Settings from File</button>-->
            </div>
            <div id="pomodoro">
                <h1 class="logo">이쨔빠의 뽐오돌오</h1>
                <p id="timer">45:00</p>
                <div class="circle-container">
                    <div class="circle" id="circle1"></div>
                    <div class="circle" id="circle2"></div>
                    <div class="circle" id="circle3"></div>
                    <div class="circle" id="circle4"></div>
                    <div class="circle" id="circle5"></div>
                    <div class="circle" id="circle6"></div>
                </div>
                <p id="progress">Set: 1/6</p>
                <button id="start-stop-button" onclick="toggleTimer()">Start</button>
                <button id="mute-unmute-button" onclick="muteToggle()">Mute</button>
                <div id="messages"></div>
                <audio id="alarm-sound-fw" src="/sound/finishwork.mp3"></audio>
                <audio id="alarm-sound-fb" src="/sound/finishbreak.mp3"></audio>
                <audio id="background-music" src="/sound/noise.mp3" loop></audio>
            </div>
            <div id="habit_tracker">
                <h1>Habit Tracker</h1>
                <style>
                    #calendar {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        margin-top: 20px;
                    }

                    #calendar-table {
                        border-collapse: collapse;
                        width: 100%;
                        max-width: 600px;
                    }

                    #calendar-table th,
                    #calendar-table td {
                        border: 1px solid #ddd;
                        padding: 10px;
                        text-align: center;
                        width: 20px;
                        height: 20px;
                    }

                    #calendar-table td {
                        background-color: #ebedf0;
                        /* Default color for contribution graph */
                    }

                    #calendar-table td[data-contribution-level="1"] {
                        background-color: #c6e48b;
                    }

                    #calendar-table td[data-contribution-level="2"] {
                        background-color: #7bc96f;
                    }

                    #calendar-table td[data-contribution-level="3"] {
                        background-color: #239a3b;
                    }

                    #calendar-table td[data-contribution-level="4"] {
                        background-color: #196127;
                    }


                    #calendar button {
                        background-color: #4CAF50;
                        color: white;
                        border: none;
                        padding: 10px 20px;
                        text-align: center;
                        text-decoration: none;
                        display: inline-block;
                        font-size: 16px;
                        margin: 4px 2px;
                        cursor: pointer;
                        border-radius: 5px;
                    }

                    #month-year {
                        font-size: 24px;
                        font-weight: bold;
                        margin: 0 20px;
                    }
                </style>
                <div id="calendar">
                    <button onclick="prevMonth()">&#9664;</button>
                    <span id="month-year"></span>
                    <button onclick="nextMonth()">&#9654;</button>
                    <table id="calendar-table">
                        <thead>
                            <tr>
                                <th>Sun</th>
                                <th>Mon</th>
                                <th>Tue</th>
                                <th>Wed</th>
                                <th>Thu</th>
                                <th>Fri</th>
                                <th>Sat</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>

            <script>
                const calendarTable = document.getElementById('calendar-table').getElementsByTagName('tbody')[0];
                const monthYear = document.getElementById('month-year');
                let currentMonth = new Date().getMonth();
                let currentYear = new Date().getFullYear();

                function renderCalendar(month, year) {
                    const firstDay = new Date(year, month).getDay();
                    const daysInMonth = new Date(year, month + 1, 0).getDate();
                    calendarTable.innerHTML = '';
                    monthYear.textContent = `${year}-${month + 1 < 10 ? '0' : ''}${month + 1}`;

                    let date = 1;
                    for (let i = 0; i < 6; i++) {
                        const row = document.createElement('tr');
                        for (let j = 0; j < 7; j++) {
                            const cell = document.createElement('td');
                            if (i === 0 && j < firstDay) {
                                cell.textContent = '';
                            } else if (date > daysInMonth) {
                                break;
                            } else {
                                cell.textContent = date;
                                if (j === 0) {
                                    cell.style.color = 'red';
                                } else if (j === 6) {
                                    cell.style.color = 'red';
                                }
                                date++;
                            }
                            row.appendChild(cell);
                        }
                        calendarTable.appendChild(row);
                    }
                }

                function prevMonth() {
                    currentMonth--;
                    if (currentMonth < 0) {
                        currentMonth = 11;
                        currentYear--;
                    }
                    renderCalendar(currentMonth, currentYear);
                }

                function nextMonth() {
                    currentMonth++;
                    if (currentMonth > 11) {
                        currentMonth = 0;
                        currentYear++;
                    }
                    renderCalendar(currentMonth, currentYear);
                }

                renderCalendar(currentMonth, currentYear);
            </script>

            <script>
                const DEFAULT_WORK_TIME = 45 * 60;
                const DEFAULT_BREAK_TIME = 15 * 60;
                const TOTAL_SETS = 6;
                const TIMER_INTERVAL = 1000;
                const CIRCLE_COLOR_WORK = 'pink';
                const CIRCLE_COLOR_BREAK = 'lightgreen';

                let workTime = DEFAULT_WORK_TIME;
                let breakTime = DEFAULT_BREAK_TIME;
                let isWorkTime = true;
                let timer;
                let setCount = 1;
                let isTimerRunning = false;
                let isMute = false;

                function showSettings() {
                    document.getElementById('settings').style.display = 'block';
                    document.getElementById('pomodoro').style.display = 'none';
                    document.getElementById('habit_tracker').style.display = 'none';
                }

                function showPomodoro() {
                    document.getElementById('settings').style.display = 'none';
                    document.getElementById('pomodoro').style.display = 'block';
                    document.getElementById('habit_tracker').style.display = 'none';
                }

                function showHabitTracker() {
                    document.getElementById('settings').style.display = 'none';
                    document.getElementById('pomodoro').style.display = 'none';
                    document.getElementById('habit_tracker').style.display = 'block';
                }

                function toggleTimer() {
                    if (isTimerRunning) {
                        clearInterval(timer);
                        document.getElementById("background-music").pause();
                        document.getElementById("start-stop-button").textContent = "Start";
                    } else {
                        startTimer();
                        document.getElementById("background-music").play();
                        document.getElementById("start-stop-button").textContent = "Stop";
                    }
                    isTimerRunning = !isTimerRunning;
                }

                function muteToggle() {
                    if (isMute) {
                        document.getElementById("background-music").play();
                        document.getElementById("mute-unmute-button").textContent = "Mute";
                    } else {
                        document.getElementById("background-music").pause();
                        document.getElementById("mute-unmute-button").textContent = "Unmute";
                    }
                    isMute = !isMute;
                }

                function startTimer() {
                    clearInterval(timer);
                    timer = setInterval(updateTimer, TIMER_INTERVAL);
                }

                //                function setWorkTime() {
                //                   const workTimeInput = document.getElementById("work-time-input").value;
                //                  workTime = workTimeInput * 60;
                //                 document.getElementById("timer").textContent = `${workTimeInput < 10 ? '0' : ''}${workTimeInput}:00`;
                //            }
                function setWorkTime() {
                    const workTimeInput = document.getElementById("work-time-input").value;
                    workTime = workTimeInput * 60;
                    document.getElementById("timer").textContent = (workTimeInput < 10 ? '0' : '') + workTimeInput + ":00";
                }

                function setBreakTime() {
                    const breakTimeInput = document.getElementById("break-time-input").value;
                    breakTime = breakTimeInput * 60;
                }

                function updateTimer() {
                    let minutes, seconds;
                    if (isWorkTime) {
                        document.body.style.backgroundImage = `url(${WORK_BACKGROUND_IMAGE})`;
                        minutes = Math.floor(workTime / 60);
                        seconds = workTime % 60;
                        workTime--;
                        if (workTime < 0) {
                            isWorkTime = false;
                            workTime = document.getElementById("work-time-input").value * 60;
                            playSound(1);
                            addMessage("쨔빠대장!! 쉬는시간!!");
                        }
                    } else {
                        document.body.style.backgroundImage = `url(${BREAK_BACKGROUND_IMAGE})`;
                        minutes = Math.floor(breakTime / 60);
                        seconds = breakTime % 60;
                        breakTime--;
                        if (breakTime < 0) {
                            isWorkTime = true;
                            breakTime = document.getElementById("break-time-input").value * 60;
                            document.getElementById(`circle${setCount}`).style.backgroundColor = CIRCLE_COLOR_BREAK;
                            setCount++;
                            if (setCount > TOTAL_SETS) {
                                clearInterval(timer);
                                playSound();
                                addMessage("와 오늘 여섯세트 다했다 고생했어 희진아 정말 대단하다 대장!!");
                                return;
                            }
                            playSound(2);
                            addMessage("다시 공부 시작하자 희진아 힘들어도 화이팅!");
                        }
                    }

                    document.getElementById("timer").textContent = (minutes < 10 ? '0' : '') + minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
                    document.getElementById("progress").textContent = "Set: " + setCount + "/" + TOTAL_SETS;

                }

                function playSound(type) {
                    if (type == 1) {
                        const alarmSoundFW = document.getElementById("alarm-sound-fw");
                        alarmSoundFW.play();
                    } else {
                        const alarmSoundFB = document.getElementById("alarm-sound-fb");
                        alarmSoundFB.play();
                    }
                }

                function addMessage(message) {
                    const messages = document.getElementById("messages");
                    const messageElement = document.createElement("p");
                    messageElement.textContent = message;
                    messages.appendChild(messageElement);
                }
                /*
                function saveSettings() {
                    const workTimeInput = document.getElementById("work-time-input").value;
                    const breakTimeInput = document.getElementById("break-time-input").value;
                    const settings = `workTime=${workTimeInput}\nbreakTime=${breakTimeInput}`;
                    const blob = new Blob([settings], { type: 'text/plain;charset=utf-8' });
                    saveAs(blob, 'settings.txt');
                    alert("Settings saved to file!");
                }
                */
                function saveSettings() {
                    const workTimeInput = document.getElementById("work-time-input").value;
                    const breakTimeInput = document.getElementById("break-time-input").value;
                    const settings = "workTime=" + workTimeInput + "\nbreakTime=" + breakTimeInput;
                    const blob = new Blob([settings], { type: 'text/plain;charset=utf-8' });
                    saveAs(blob, 'settings.txt');
                    alert("Settings saved to file!");
                }

                function saveSettingsToLocalStorage() {
                    const workTimeInput = document.getElementById("work-time-input").value;
                    const breakTimeInput = document.getElementById("break-time-input").value;
                    localStorage.setItem("workTime", workTimeInput);
                    localStorage.setItem("breakTime", breakTimeInput);
                    alert("Settings saved to local storage!");
                }

                function loadSettings() {
                    const savedWorkTime = localStorage.getItem("workTime");
                    const savedBreakTime = localStorage.getItem("breakTime");
                    if (savedWorkTime) {
                        document.getElementById("work-time-input").value = savedWorkTime;
                        workTime = savedWorkTime * 60;
                        document.getElementById("timer").textContent = (savedWorkTime < 10 ? '0' : '') + savedWorkTime + ":00";
                    }
                    if (savedBreakTime) {
                        document.getElementById("break-time-input").value = savedBreakTime;
                        breakTime = savedBreakTime * 60;
                    }
                }

                function loadSettingsFromFile(event) {
                    const file = event.target.files[0];
                    if (!file || file.name !== 'settings.txt') {
                        alert("Please select the correct settings.txt file.");
                        return;
                    }

                    const reader = new FileReader();
                    /*
                    reader.onload = function (e) {
                        const contents = e.target.result;
                        const lines = contents.split('\n');
                        lines.forEach(line => {
                            const [key, value] = line.split('=');
                            if (key === 'workTime') {
                                document.getElementById("work-time-input").value = value;
                                workTime = value * 60;
                                document.getElementById("timer").textContent = `${value < 10 ? '0' : ''}${value}:00`;
                            } else if (key === 'breakTime') {
                                document.getElementById("break-time-input").value = value;
                                breakTime = value * 60;
                            }
                        });
                        alert("Settings loaded from file!");
                    };
                    */
                    reader.onload = function (e) {
                        const contents = e.target.result;
                        const lines = contents.split('\n');
                        lines.forEach(line => {
                            const [key, value] = line.split('=');
                            if (key === 'workTime') {
                                document.getElementById("work-time-input").value = value;
                                workTime = value * 60;
                                document.getElementById("timer").textContent = `${value < 10 ? '0' : ''}${value}:00`;
                            } else if (key === 'breakTime') {
                                document.getElementById("break-time-input").value = value;
                                breakTime = value * 60;
                            }
                        });
                        alert("Settings loaded from file!");
                    };


                    reader.readAsText(file);
                }
                document.body.style.backgroundImage = `url(${WORK_BACKGROUND_IMAGE})`;

                // Load settings on page load
                window.onload = loadSettings;

                // Show Pomodoro timer by default
                showPomodoro();
            </script>
        </div>
    </body>

    </html>