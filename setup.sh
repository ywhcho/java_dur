#!/bin/bash

# Pharmacy Information System - Quick Setup Script
# This script automates the setup process for local development

set -e

echo "==================================="
echo "의약정보 시스템 설치 스크립트"
echo "Pharmacy Information System Setup"
echo "==================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
echo "1. Checking prerequisites..."

# Check Java
if ! command -v java &> /dev/null; then
    echo -e "${RED}❌ Java is not installed${NC}"
    echo "Please install JDK 11 or higher"
    exit 1
fi
echo -e "${GREEN}✓ Java found: $(java -version 2>&1 | head -n 1)${NC}"

# Check Maven
if ! command -v mvn &> /dev/null; then
    echo -e "${RED}❌ Maven is not installed${NC}"
    echo "Please install Maven 3.6 or higher"
    exit 1
fi
echo -e "${GREEN}✓ Maven found: $(mvn -version | head -n 1)${NC}"

# Check MySQL
if ! command -v mysql &> /dev/null; then
    echo -e "${YELLOW}⚠ MySQL client not found in PATH${NC}"
    echo "Make sure MySQL 8.0+ is installed"
else
    echo -e "${GREEN}✓ MySQL found: $(mysql --version)${NC}"
fi

echo ""

# Database configuration
echo "2. Database configuration..."
echo "Please enter your MySQL connection details:"
read -p "MySQL username (default: root): " DB_USER
DB_USER=${DB_USER:-root}

read -sp "MySQL password: " DB_PASS
echo ""

read -p "MySQL host (default: localhost): " DB_HOST
DB_HOST=${DB_HOST:-localhost}

read -p "MySQL port (default: 3306): " DB_PORT
DB_PORT=${DB_PORT:-3306}

echo ""
echo "Testing MySQL connection..."
if mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" -e "SELECT 1;" &> /dev/null; then
    echo -e "${GREEN}✓ MySQL connection successful${NC}"
else
    echo -e "${RED}❌ MySQL connection failed${NC}"
    echo "Please check your credentials and try again"
    exit 1
fi

echo ""

# Create database
echo "3. Creating database..."
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" < database/schema.sql
echo -e "${GREEN}✓ Database and tables created${NC}"

# Insert sample data
read -p "Do you want to insert sample medicine data? (Y/n): " INSERT_SAMPLE
INSERT_SAMPLE=${INSERT_SAMPLE:-Y}
if [[ "$INSERT_SAMPLE" =~ ^[Yy]$ ]]; then
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" < database/sample_data.sql
    echo -e "${GREEN}✓ Sample data inserted${NC}"
fi

echo ""

# Update db.properties
echo "4. Updating database configuration..."
cat > src/main/resources/db.properties << EOF
# Database Configuration
db.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/pharmacy_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=${DB_USER}
db.password=${DB_PASS}
db.driver=com.mysql.cj.jdbc.Driver

# Connection Pool Settings
db.pool.initialSize=5
db.pool.maxTotal=20
db.pool.maxIdle=10
db.pool.minIdle=5
EOF
echo -e "${GREEN}✓ Database configuration updated${NC}"

echo ""

# Build project
echo "5. Building project..."
mvn clean package -DskipTests -q
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Project built successfully${NC}"
    echo -e "   WAR file: target/pharmacy-info.war"
else
    echo -e "${RED}❌ Build failed${NC}"
    exit 1
fi

echo ""

# Check for Tomcat
echo "6. Checking for Apache Tomcat..."
if [ -z "$CATALINA_HOME" ]; then
    echo -e "${YELLOW}⚠ CATALINA_HOME environment variable not set${NC}"
    echo ""
    read -p "Enter Tomcat installation path (or press Enter to skip deployment): " TOMCAT_PATH
    
    if [ -n "$TOMCAT_PATH" ] && [ -d "$TOMCAT_PATH" ]; then
        export CATALINA_HOME="$TOMCAT_PATH"
        echo -e "${GREEN}✓ Tomcat path set${NC}"
    else
        echo "Skipping automatic deployment"
        echo "Please manually copy target/pharmacy-info.war to your Tomcat webapps directory"
    fi
else
    echo -e "${GREEN}✓ Tomcat found: $CATALINA_HOME${NC}"
fi

# Deploy to Tomcat
if [ -n "$CATALINA_HOME" ] && [ -d "$CATALINA_HOME/webapps" ]; then
    read -p "Deploy to Tomcat now? (Y/n): " DEPLOY
    DEPLOY=${DEPLOY:-Y}
    
    if [[ "$DEPLOY" =~ ^[Yy]$ ]]; then
        cp target/pharmacy-info.war "$CATALINA_HOME/webapps/"
        echo -e "${GREEN}✓ WAR file deployed to Tomcat${NC}"
        echo ""
        
        read -p "Start Tomcat? (Y/n): " START_TOMCAT
        START_TOMCAT=${START_TOMCAT:-Y}
        
        if [[ "$START_TOMCAT" =~ ^[Yy]$ ]]; then
            if [ -f "$CATALINA_HOME/bin/startup.sh" ]; then
                "$CATALINA_HOME/bin/startup.sh"
                echo -e "${GREEN}✓ Tomcat started${NC}"
            elif [ -f "$CATALINA_HOME/bin/startup.bat" ]; then
                "$CATALINA_HOME/bin/startup.bat"
                echo -e "${GREEN}✓ Tomcat started${NC}"
            fi
        fi
    fi
fi

echo ""
echo "==================================="
echo -e "${GREEN}Setup completed successfully!${NC}"
echo "==================================="
echo ""
echo "Next steps:"
echo "1. Wait for Tomcat to deploy the application (about 10 seconds)"
echo "2. Open your browser and go to: http://localhost:8080/pharmacy-info/"
echo "3. Create an account and start using the system"
echo ""
echo "For more information, check:"
echo "- README.md - General information"
echo "- DEPLOYMENT.md - Deployment guide"
echo "- DEVELOPER.md - Developer guide"
echo "- FEATURES.md - Features documentation"
echo ""
echo "Need help? Check the logs at: \$CATALINA_HOME/logs/catalina.out"
echo ""
