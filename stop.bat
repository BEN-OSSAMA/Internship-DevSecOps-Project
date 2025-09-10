@echo off
echo ========================================
echo 🛑 Arrêt de FSMicroGenerator...
echo ========================================
cd /d "%~dp0"
docker-compose -f docker-compose.prod.yml down

echo ✅ Application arrêtée avec succès.
pause
