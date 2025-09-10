@echo off
echo ========================================
echo 🚀 Lancement de FSMicroGenerator avec Docker...
echo ========================================
cd /d "%~dp0"
docker-compose -f docker-compose.prod.yml up -d

echo ✅ Application démarrée !
echo 🌐 Accède à http://localhost:4200
pause
