# 📱 LingoLite

##Team members:
Ayazhan Taimas 22B030447
Nurkhan Tulepbergen 22B030455

LingoLite — это iOS-приложение для изучения английского языка. Пользователи могут проходить авторизацию через Firebase и получать доступ к переводу и изучению английских слов с помощью open-source API.

Приложение написано с использованием Storyboard, что упрощает визуальную настройку интерфейса.

---

## 🚀 Основные функции

- 🔐 Авторизация и регистрация через Firebase Authentication
- 🌐 Получение слов и переводов с использованием open-source API
- 🧠 Повторение и запоминание слов
- 📱 Нативный интерфейс с использованием Storyboard

---

## 🛠️ Set-up Instructions

Следуй этим шагам, чтобы развернуть и запустить проект на своём устройстве или в Xcode:


### 1. Клонируй репозиторий

Bash


git clone https://github.com/yourusername/LingoLite.git
cd LingoLite

### 2. Настрой Firebase


Перейди на Firebase Console, создай новый проект.


Добавь iOS-приложение с твоим bundle identifier.


Скачай GoogleService-Info.plist.


Добавь GoogleService-Info.plist в корень проекта (через Xcode).


Убедись, что в AppDelegate.swift инициализирован Firebase:



swiftКопироватьРедактироватьimport Firebase

FirebaseApp.configure()
```

### 3. Настрой API
Open-source API для слов и переводов:

Зарегистрируйся на нужном API (например, DictionaryAPI, LibreTranslate)

Получи API ключ 

Добавь его в .plist или в Constants.swift (убедись, что ключ не пушится в публичный репозиторий)

### 4. Запусти приложение
Выбери симулятор или подключённое устройство

Нажми ⌘ + R в Xcode для запуска приложения



## Структура проекта
Controllers/ — ViewController'ы для интерфейсов

Models/ — Модели данных (слова, пользователь и т.д.)

Services/ — Работа с API и Firebase

Views/ — Кастомные вьюшки и Storyboard элементы

## 🧩 Используемые технологии
Swift

Storyboard (UIKit)

Firebase Authentication

Firebase Realtime Database / Firestore

Open-source словари / переводчики
