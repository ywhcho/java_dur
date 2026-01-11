@echo off
REM Pharmacy Information System - Quick Setup Script for Windows
REM This script automates the setup process for local development

echo ===================================
echo 의약정보 시스템 설치 스크립트
echo Pharmacy Information System Setup
echo ===================================
echo.

REM Check Java
echo 1. Checking prerequisites...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Java is not installed
    echo Please install JDK 11 or higher
    pause
    exit /b 1
)
echo [OK] Java found

REM Check Maven
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Maven is not installed
    echo Please install Maven 3.6 or higher
    pause
    exit /b 1
)
echo [OK] Maven found

REM Check MySQL
mysql --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [WARNING] MySQL client not found in PATH
    echo Make sure MySQL 8.0+ is installed
) else (
    echo [OK] MySQL found
)

echo.

REM Database configuration
echo 2. Database configuration...
set /p DB_USER="MySQL username (default: root): " || set DB_USER=root
set /p DB_PASS="MySQL password: "
set /p DB_HOST="MySQL host (default: localhost): " || set DB_HOST=localhost
set /p DB_PORT="MySQL port (default: 3306): " || set DB_PORT=3306

echo.
echo Testing MySQL connection...
mysql -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% -e "SELECT 1;" >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] MySQL connection failed
    echo Please check your credentials and try again
    pause
    exit /b 1
)
echo [OK] MySQL connection successful

echo.

REM Create database
echo 3. Creating database...
mysql -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% < database\schema.sql
echo [OK] Database and tables created

REM Insert sample data
set /p INSERT_SAMPLE="Do you want to insert sample medicine data? (Y/n): " || set INSERT_SAMPLE=Y
if /i "%INSERT_SAMPLE%"=="Y" (
    mysql -h %DB_HOST% -P %DB_PORT% -u %DB_USER% -p%DB_PASS% < database\sample_data.sql
    echo [OK] Sample data inserted
)

echo.

REM Update db.properties
echo 4. Updating database configuration...
(
echo # Database Configuration
echo db.url=jdbc:mysql://%DB_HOST%:%DB_PORT%/pharmacy_db?useSSL=false^&serverTimezone=UTC^&allowPublicKeyRetrieval=true
echo db.username=%DB_USER%
echo db.password=%DB_PASS%
echo db.driver=com.mysql.cj.jdbc.Driver
echo.
echo # Connection Pool Settings
echo db.pool.initialSize=5
echo db.pool.maxTotal=20
echo db.pool.maxIdle=10
echo db.pool.minIdle=5
) > src\main\resources\db.properties
echo [OK] Database configuration updated

echo.

REM Build project
echo 5. Building project...
call mvn clean package -DskipTests -q
if %errorlevel% neq 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)
echo [OK] Project built successfully
echo     WAR file: target\pharmacy-info.war

echo.

REM Check for Tomcat
echo 6. Checking for Apache Tomcat...
if not defined CATALINA_HOME (
    echo [WARNING] CATALINA_HOME environment variable not set
    echo.
    set /p TOMCAT_PATH="Enter Tomcat installation path (or press Enter to skip): "
    if defined TOMCAT_PATH (
        if exist "%TOMCAT_PATH%" (
            set CATALINA_HOME=%TOMCAT_PATH%
            echo [OK] Tomcat path set
        )
    )
) else (
    echo [OK] Tomcat found: %CATALINA_HOME%
)

REM Deploy to Tomcat
if defined CATALINA_HOME (
    if exist "%CATALINA_HOME%\webapps" (
        set /p DEPLOY="Deploy to Tomcat now? (Y/n): " || set DEPLOY=Y
        if /i "%DEPLOY%"=="Y" (
            copy target\pharmacy-info.war "%CATALINA_HOME%\webapps\" >nul
            echo [OK] WAR file deployed to Tomcat
            echo.
            
            set /p START_TOMCAT="Start Tomcat? (Y/n): " || set START_TOMCAT=Y
            if /i "%START_TOMCAT%"=="Y" (
                if exist "%CATALINA_HOME%\bin\startup.bat" (
                    call "%CATALINA_HOME%\bin\startup.bat"
                    echo [OK] Tomcat started
                )
            )
        )
    )
)

echo.
echo ===================================
echo Setup completed successfully!
echo ===================================
echo.
echo Next steps:
echo 1. Wait for Tomcat to deploy the application (about 10 seconds)
echo 2. Open your browser and go to: http://localhost:8080/pharmacy-info/
echo 3. Create an account and start using the system
echo.
echo For more information, check:
echo - README.md - General information
echo - DEPLOYMENT.md - Deployment guide
echo - DEVELOPER.md - Developer guide
echo - FEATURES.md - Features documentation
echo.
echo Need help? Check the logs at: %%CATALINA_HOME%%\logs\catalina.out
echo.
pause
