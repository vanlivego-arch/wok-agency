#!/bin/bash

# 🚀 WOK Agency - Автоматическая загрузка в GitHub
# 
# Использование:
#   1. Сделай скрипт исполняемым: chmod +x git_init.sh
#   2. Запусти: ./git_init.sh YOUR_GITHUB_USERNAME

echo "🚀 WOK AGENCY - ЗАГРУЗКА В GITHUB"
echo "================================="
echo ""

# Проверка аргументов
if [ -z "$1" ]; then
    echo "❌ Ошибка: Укажи свой GitHub username"
    echo ""
    echo "Использование:"
    echo "  ./git_init.sh YOUR_GITHUB_USERNAME"
    echo ""
    echo "Пример:"
    echo "  ./git_init.sh jonyvercetti"
    exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME="wok-agency"

echo "📦 GitHub Username: $GITHUB_USERNAME"
echo "📦 Repository: $REPO_NAME"
echo ""

# Проверка Git
if ! command -v git &> /dev/null; then
    echo "❌ Git не установлен!"
    echo ""
    echo "Установи Git:"
    echo "  Ubuntu/Debian: sudo apt-get install git"
    echo "  macOS: brew install git"
    echo "  Windows: https://git-scm.com/download/win"
    exit 1
fi

echo "✅ Git найден: $(git --version)"
echo ""

# Инициализация Git
if [ ! -d ".git" ]; then
    echo "📝 Инициализация Git репозитория..."
    git init
    echo "✅ Git инициализирован"
else
    echo "✅ Git уже инициализирован"
fi
echo ""

# Добавление файлов
echo "📦 Добавление файлов в Git..."
git add .
echo "✅ Файлы добавлены"
echo ""

# Коммит
echo "💾 Создание коммита..."
git commit -m "Initial commit: WOK Agency landing + demo dashboard"
echo "✅ Коммит создан"
echo ""

# Привязка к GitHub
echo "🔗 Привязка к GitHub репозиторию..."
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git" 2>/dev/null || \
git remote set-url origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
echo "✅ Репозиторий привязан"
echo ""

# Переименование ветки
echo "🌿 Переименование ветки в main..."
git branch -M main
echo "✅ Ветка переименована"
echo ""

# Отправка на GitHub
echo "🚀 Отправка кода на GitHub..."
echo ""
echo "⚠️  ВНИМАНИЕ: Сейчас GitHub попросит логин и пароль"
echo "    (Или Personal Access Token если у тебя 2FA)"
echo ""

git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ ================================="
    echo "✅ УСПЕШНО ЗАГРУЖЕНО В GITHUB!"
    echo "✅ ================================="
    echo ""
    echo "📍 Твой репозиторий:"
    echo "   https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo ""
    echo "🎯 СЛЕДУЮЩИЕ ШАГИ:"
    echo "   1. Открой https://vercel.com"
    echo "   2. Войди через GitHub"
    echo "   3. Import Project → выбери wok-agency"
    echo "   4. Deploy!"
    echo ""
    echo "⏱️  Деплой займёт ~2 минуты"
else
    echo ""
    echo "❌ ================================="
    echo "❌ ОШИБКА ПРИ ЗАГРУЗКЕ"
    echo "❌ ================================="
    echo ""
    echo "Возможные причины:"
    echo "  1. Репозиторий ещё не создан на GitHub"
    echo "  2. Неверный логин/пароль"
    echo "  3. Нет прав доступа"
    echo ""
    echo "Создай репозиторий на GitHub:"
    echo "  1. Открой https://github.com/new"
    echo "  2. Имя: wok-agency"
    echo "  3. Private или Public"
    echo "  4. НЕ добавляй README/gitignore"
    echo "  5. Create repository"
    echo ""
    echo "Потом запусти скрипт снова:"
    echo "  ./git_init.sh $GITHUB_USERNAME"
fi
