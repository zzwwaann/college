import tkinter as tk
from random import shuffle
from tkinter.messagebox import showinfo, showerror
import time

colors = {
    0: 'white',
    1: '#054ff6',
    2: '#05f737',
    3: '#ff7700',
    4: '#db0202',
    5: '#5d00ff',
    6: '#3b1380',
    7: '#ca08c8',
    8: '#ff0095',
}


class MyButton(tk.Button):
    def __init__(self, master, x, y, number=0, *args, **kwargs):
        super(MyButton, self).__init__(master, width=3, font='Calibri 15 bold', *args, **kwargs)
        self.x = x
        self.y = y
        self.number = number
        self.is_mine = False
        self.count_bomb = 0
        self.is_open = False
        self.is_flag = False

    def __repr__(self):
        return f'MyButton{self.x} {self.y} {self.number} {self.is_mine}'


class MineSweeper:
    def __init__(self):
        self.window = tk.Tk()
        self.ROW = 8
        self.COLUMNS = 8
        self.MINES = 10
        self.IS_GAME_OVER = False
        self.IS_FIRST_CLICK = True
        self.WINDOW_WIDTH = 1200
        self.WINDOW_HEIGHT = 800
        self.flags_left = self.MINES
        self.start_time = 0
        self.timer_running = False

        self.window.geometry(f"{self.WINDOW_WIDTH}x{self.WINDOW_HEIGHT}")
        self.window.resizable(False, False)
        self.buttons = []
        self.show_main_menu()

    def clear_window(self):
        """Очищает окно от всех виджетов"""
        for widget in self.window.winfo_children():
            widget.destroy()

    def show_main_menu(self):
        self.clear_window()
        self.window.title("CAПEP")

        menu_frame = tk.Frame(self.window)
        menu_frame.pack(expand=True)

        title_label = tk.Label(menu_frame, text="CAПEP", font=("Arial", 24, "bold"))
        title_label.pack(pady=20)

        play_btn = tk.Button(menu_frame, text="ИГРАТЬ", font=("Arial", 16),
                             command=self.show_difficulty_menu, width=15, height=2)
        play_btn.pack(pady=10)

        rules_btn = tk.Button(menu_frame, text="ПРАВИЛА ИГРЫ", font=("Arial", 16),
                              command=self.show_rules, width=15, height=2)
        rules_btn.pack(pady=10)

        exit_btn = tk.Button(menu_frame, text="Выйти из игры", font=("Arial", 16),
                             command=self.window.destroy, width=15, height=2)
        exit_btn.pack(pady=10)

    def show_difficulty_menu(self):
        self.clear_window()
        self.window.title("Выбор уровня сложности")

        diff_frame = tk.Frame(self.window)
        diff_frame.pack(expand=True)

        title_label = tk.Label(diff_frame, text="Выберите уровень сложности", font=("Arial", 20, "bold"))
        title_label.pack(pady=30)

        easy_btn = tk.Button(diff_frame, text="Лёгкий (8x8)", font=("Arial", 16),
                             command=lambda: self.set_difficulty(8, 8, 10), width=20, height=2)
        easy_btn.pack(pady=10)

        medium_btn = tk.Button(diff_frame, text="Средний (12x12)", font=("Arial", 16),
                               command=lambda: self.set_difficulty(12, 12, 24), width=20, height=2)
        medium_btn.pack(pady=10)

        hard_btn = tk.Button(diff_frame, text="Сложный (16x16)", font=("Arial", 16),
                             command=lambda: self.set_difficulty(16, 16, 40), width=20, height=2)
        hard_btn.pack(pady=10)

        back_btn = tk.Button(diff_frame, text="Назад", font=("Arial", 14),
                             command=self.show_main_menu, width=10, height=1)
        back_btn.pack(pady=20)

    def set_difficulty(self, rows, cols, mines):
        self.ROW = rows
        self.COLUMNS = cols
        self.MINES = mines
        self.flags_left = mines
        self.start_game()

    def show_rules(self):
        rules_window = tk.Toplevel(self.window)
        rules_window.title("Правила игры")
        rules_window.geometry(f"{self.WINDOW_WIDTH}x{self.WINDOW_HEIGHT}")
        rules_window.resizable(False, False)

        # Главный фрейм для правил
        rules_frame = tk.Frame(rules_window)
        rules_frame.pack(expand=True, fill=tk.BOTH, padx=50, pady=50)

        # Заголовок
        title_label = tk.Label(rules_frame, text="ПРАВИЛА ИГРЫ",
                               font=("Arial", 24, "bold"))
        title_label.pack(pady=20)

        # Текст правил
        rules_text = """
Цель: открыть все клетки, в которых нет мин

Ход игры: на поле размещены мины, количество которых зависит от уровня сложности игры. 
Чем выше уровень сложности, тем больше мин на поле.

Когда игрок открывает клетку, в ней может оказаться цифра:

0: клетка и рядом с ней стоящие не содержит мин, она остается пустой.

1-8: цифра указывает количество мин, находящихся в соседних клетках 
(по горизонтали, вертикали и диагонали).

Пометка мин: игрок может пометить клетки, которые подозревает на наличие мин, 
используя ПКМ. Обычно пометка обозначается флажком.

Игровое поле: игровое поле состоит из клеток, которые могут быть либо пустыми, 
либо содержать мину. Поле обычно имеет квадратную форму и, может быть, 
различного размера (например, 8х8, 16х16 и т.д.).

Победа: игрок выигрывает, если откроет все клетки, не содержащие мин, 
либо если он пометит все мины правильно.

Поражение: нажатие на клетку, в которой была мина.
        """

        rules_label = tk.Label(rules_frame, text=rules_text,
                               font=("Arial", 14), justify=tk.LEFT)
        rules_label.pack(pady=20, padx=20)

        # Кнопка закрытия
        close_btn = tk.Button(rules_frame, text="Закрыть",
                              font=("Arial", 14), width=15,
                              command=rules_window.destroy)
        close_btn.place(x=450, y=650)

    def show_win_window(self):
        win_window = tk.Toplevel(self.window)
        win_window.title("Победа!")
        win_window.geometry("400x300")
        win_window.resizable(False, False)

        # Центрирование окна
        window_width = self.window.winfo_width()
        window_height = self.window.winfo_height()
        window_x = self.window.winfo_x()
        window_y = self.window.winfo_y()

        win_window.geometry(f"+{window_x + window_width // 2 - 200}+{window_y + window_height // 2 - 150}")

        # Главный фрейм
        main_frame = tk.Frame(win_window)
        main_frame.pack(expand=True, fill=tk.BOTH, padx=20, pady=20)

        # Заголовок ПОБЕДА
        title_label = tk.Label(main_frame, text="ПОБЕДА!",
                               font=("Arial", 24, "bold"), fg="green")
        title_label.pack(pady=20)

        # Время прохождения
        elapsed = int(time.time() - self.start_time)
        time_label = tk.Label(main_frame,
                              text=f"Время прохождения: {elapsed} секунд",
                              font=("Arial", 14))
        time_label.pack(pady=10)

        # Кнопка возврата
        back_btn = tk.Button(main_frame, text="Вернуться в главное меню",
                             font=("Arial", 14), width=25,
                             command=lambda: [win_window.destroy(), self.show_main_menu()])
        back_btn.pack(pady=20)

        # Фокус на новом окне
        win_window.grab_set()

    def show_lose_window(self):
        lose_window = tk.Toplevel(self.window)
        lose_window.title("Поражение")
        lose_window.geometry("400x300")
        lose_window.resizable(False, False)

        # Центрирование окна
        window_width = self.window.winfo_width()
        window_height = self.window.winfo_height()
        window_x = self.window.winfo_x()
        window_y = self.window.winfo_y()

        lose_window.geometry(f"+{window_x + window_width // 2 - 200}+{window_y + window_height // 2 - 150}")

        # Главный фрейм
        main_frame = tk.Frame(lose_window)
        main_frame.pack(expand=True, fill=tk.BOTH, padx=20, pady=20)

        # Заголовок ПОРАЖЕНИЕ
        title_label = tk.Label(main_frame, text="ПОРАЖЕНИЕ",
                               font=("Arial", 24, "bold"), fg="red")
        title_label.pack(pady=20)

        # Сообщение
        message_label = tk.Label(main_frame,
                                 text="Вы наступили на мину!",
                                 font=("Arial", 14))
        message_label.pack(pady=10)

        # Кнопка возврата
        back_btn = tk.Button(main_frame, text="Вернуться в главное меню",
                             font=("Arial", 14), width=25,
                             command=lambda: [lose_window.destroy(), self.show_main_menu()])
        back_btn.pack(pady=20)

        # Фокус на новом окне
        lose_window.grab_set()

    def start_game(self):
        self.clear_window()
        self.window.title("Сапер")
        self.IS_GAME_OVER = False
        self.IS_FIRST_CLICK = True
        self.start_time = time.time()
        self.timer_running = True

        # Создаем главный фрейм для игры
        main_frame = tk.Frame(self.window)
        main_frame.pack(fill=tk.BOTH, expand=True)

        # Верхняя панель
        top_frame = tk.Frame(main_frame)
        top_frame.pack(side=tk.TOP, fill=tk.X, padx=10, pady=10)

        # Счётчик времени
        self.time_label = tk.Label(top_frame, text="Время: 0", font=("Arial", 14))
        self.time_label.pack(side=tk.LEFT)

        # Сложность
        difficulty_text = "ЛЁГКАЯ" if self.MINES == 10 else "СРЕДНЯЯ" if self.MINES == 24 else "СЛОЖНАЯ"
        difficulty_label = tk.Label(main_frame, text=f"СЛОЖНОСТЬ: {difficulty_text}",
                                    font=("Arial", 14))
        difficulty_label.place(x=10, y=725)

        # Счётчик флажков
        self.flags_label = tk.Label(top_frame, text=f"Флагов: {self.flags_left}/{self.MINES}",
                                    font=("Arial", 14))
        self.flags_label.pack(side=tk.LEFT)

        # Кнопка возврата
        back_btn = tk.Button(main_frame, text="Вернуться в главное меню",
                             font=("Arial", 12), command=self.show_main_menu)
        back_btn.place(x=975, y=725)

        # Фрейм для игрового поля
        game_frame = tk.Frame(main_frame)
        game_frame.pack(pady=20)

        # Инициализация кнопок
        self.buttons = []
        for i in range(self.ROW + 2):
            temp = []
            for j in range(self.COLUMNS + 2):
                btn = MyButton(game_frame, x=i, y=j)
                btn.config(command=lambda button=btn: self.click(button))
                btn.bind("<Button-3>", self.right_click)
                temp.append(btn)
            self.buttons.append(temp)

        # Размещение кнопок на игровом поле
        count = 1
        for i in range(1, self.ROW + 1):
            for j in range(1, self.COLUMNS + 1):
                btn = self.buttons[i][j]
                btn.number = count
                btn.grid(row=i, column=j, padx=1, pady=1)
                count += 1

        # Запуск таймера
        self.update_timer()

    def update_timer(self):
        if self.timer_running and not self.IS_GAME_OVER:
            elapsed = int(time.time() - self.start_time)
            self.time_label.config(text=f"Время: {elapsed}")
            self.window.after(1000, self.update_timer)

    def check_win(self):
        correct_flags = 0
        opened_cells = 0

        for i in range(1, self.ROW + 1):
            for j in range(1, self.COLUMNS + 1):
                btn = self.buttons[i][j]
                if btn.is_mine and btn.is_flag:
                    correct_flags += 1
                if not btn.is_mine and btn.is_open:
                    opened_cells += 1

        # Условие победы: все мины помечены флажками ИЛИ все не-мины открыты
        if correct_flags == self.MINES or opened_cells == (self.ROW * self.COLUMNS - self.MINES):
            self.timer_running = False
            self.IS_GAME_OVER = True
            self.show_win_window()
            self.open_all_buttons()

    def open_all_buttons(self):
        for i in range(1, self.ROW + 1):
            for j in range(1, self.COLUMNS + 1):
                btn = self.buttons[i][j]
                if btn.is_mine:
                    btn.config(text="*", background='red', disabledforeground='black')
                elif btn.count_bomb in colors:
                    color = colors.get(btn.count_bomb, 'black')
                    btn.config(text=btn.count_bomb, fg=color)
                btn.config(state='disabled')

    def right_click(self, event):
        if self.IS_GAME_OVER:
            return
        cur_btn = event.widget

        if cur_btn['state'] == 'normal' and self.flags_left > 0 and not cur_btn.is_open:
            cur_btn['state'] = 'disabled'
            cur_btn['text'] = '🚩'
            cur_btn['disabledforeground'] = 'red'
            cur_btn.is_flag = True
            self.flags_left -= 1
            self.flags_label.config(text=f"Флагов: {self.flags_left}/{self.MINES}")
            self.check_win()
        elif cur_btn['text'] == '🚩':
            cur_btn['text'] = ''
            cur_btn['state'] = 'normal'
            cur_btn.is_flag = False
            self.flags_left += 1
            self.flags_label.config(text=f"Флагов: {self.flags_left}/{self.MINES}")

    def click(self, clicked_button: MyButton):
        if self.IS_GAME_OVER or clicked_button.is_flag:
            return

        if self.IS_FIRST_CLICK:
            self.insert_mines(clicked_button.number)
            self.count_mines_in_buttons()
            self.print_buttons()
            self.IS_FIRST_CLICK = False

        if clicked_button.is_mine:
            clicked_button.config(text="*", background='red', disabledforeground='black')
            clicked_button.is_open = True
            self.IS_GAME_OVER = True
            self.timer_running = False
            self.show_lose_window()
            for i in range(1, self.ROW + 1):
                for j in range(1, self.COLUMNS + 1):
                    btn = self.buttons[i][j]
                    if btn.is_mine:
                        btn['text'] = '*'
        else:
            color = colors.get(clicked_button.count_bomb, 'black')
            if clicked_button.count_bomb:
                clicked_button.config(text=clicked_button.count_bomb, disabledforeground=color)
                clicked_button.is_open = True
            else:
                self.breadth_first_search(clicked_button)
        clicked_button.config(state='disabled')
        clicked_button.config(relief=tk.SUNKEN)
        self.check_win()

    def breadth_first_search(self, btn: MyButton):
        queue = [btn]
        while queue:
            cur_btn = queue.pop()
            color = colors.get(cur_btn.count_bomb, 'black')
            if cur_btn.count_bomb:
                cur_btn.config(text=cur_btn.count_bomb, disabledforeground=color)
            else:
                cur_btn.config(text='', disabledforeground=color)
            cur_btn.is_open = True
            cur_btn.config(state='disabled')
            cur_btn.config(relief=tk.SUNKEN)

            if cur_btn.count_bomb == 0:
                x, y = cur_btn.x, cur_btn.y
                for dx in [-1, 0, 1]:
                    for dy in [-1, 0, 1]:
                        next_btn = self.buttons[x + dx][y + dy]
                        if not next_btn.is_open and 1 <= next_btn.x <= self.ROW and \
                                1 <= next_btn.y <= self.COLUMNS and next_btn not in queue and not next_btn.is_flag:
                            queue.append(next_btn)

    def insert_mines(self, number: int):
        index_mines = self.get_mines_places(number)
        for i in range(1, self.ROW + 1):
            for j in range(1, self.COLUMNS + 1):
                btn = self.buttons[i][j]
                if btn.number in index_mines:
                    btn.is_mine = True

    def count_mines_in_buttons(self):
        for i in range(1, self.ROW + 1):
            for j in range(1, self.COLUMNS + 1):
                btn = self.buttons[i][j]
                count_bomb = 0
                if not btn.is_mine:
                    for row_dx in [-1, 0, 1]:
                        for col_dx in [-1, 0, 1]:
                            neighbour = self.buttons[i + row_dx][j + col_dx]
                            if neighbour.is_mine:
                                count_bomb += 1
                btn.count_bomb = count_bomb

    def print_buttons(self):
        for i in range(1, self.ROW + 1):
            for j in range(1, self.COLUMNS + 1):
                btn = self.buttons[i][j]
                if btn.is_mine:
                    print('B', end='')
                else:
                    print(btn.count_bomb, end='')
            print()

    def get_mines_places(self, exclude_number: int):
        indexes = list(range(1, self.COLUMNS * self.ROW + 1))
        indexes.remove(exclude_number)
        shuffle(indexes)
        return indexes[:self.MINES]

    def run(self):
        self.window.mainloop()


if __name__ == "__main__":
    game = MineSweeper()
    game.run()
