# 빠른 시작 가이드 (Quick Start Guide)

의약정보 시스템을 5분 안에 시작하세요! 🚀

## 📋 준비물

시작하기 전에 다음이 설치되어 있는지 확인하세요:
- ✅ Java 11 이상
- ✅ Maven 3.6 이상
- ✅ MySQL 8.0 이상
- ✅ Apache Tomcat 9.0 이상

## 🚀 자동 설치 (추천)

### Linux / Mac
```bash
chmod +x setup.sh
./setup.sh
```

### Windows
```cmd
setup.bat
```

설치 스크립트가 다음을 자동으로 수행합니다:
1. ✅ 필수 소프트웨어 확인
2. ✅ MySQL 데이터베이스 생성
3. ✅ 샘플 데이터 삽입
4. ✅ 프로젝트 빌드
5. ✅ Tomcat에 배포

## 🔧 수동 설치 (3단계)

자동 설치가 안 될 경우 아래 단계를 따르세요:

### 1단계: 데이터베이스 설정
```bash
# MySQL 접속
mysql -u root -p

# 데이터베이스 생성 및 데이터 삽입
source database/schema.sql
source database/sample_data.sql
```

### 2단계: 설정 파일 수정
`src/main/resources/db.properties` 파일을 열고 MySQL 정보 입력:
```properties
db.username=root
db.password=your_password
```

### 3단계: 빌드 및 배포
```bash
# 프로젝트 빌드
mvn clean package

# Tomcat에 배포
cp target/pharmacy-info.war $CATALINA_HOME/webapps/

# Tomcat 시작
$CATALINA_HOME/bin/startup.sh  # Linux/Mac
$CATALINA_HOME\bin\startup.bat  # Windows
```

## 🌐 접속하기

1. 브라우저를 열고 다음 주소로 이동:
   ```
   http://localhost:8080/pharmacy-info/
   ```

2. 회원가입하고 시스템 사용 시작!

## 📱 주요 기능 둘러보기

### 1️⃣ 회원가입 및 로그인
- 우측 상단 "회원가입" 클릭
- 정보 입력 후 가입
- 자동으로 로그인됨

### 2️⃣ 게시판 사용하기
- 상단 메뉴 "게시판" 클릭
- "글쓰기" 버튼으로 게시글 작성
- 자신의 글은 수정/삭제 가능

### 3️⃣ 의약정보 검색
- 상단 메뉴 "의약정보" 클릭
- 성분명으로 검색 (예: "아세트아미노펜")
- 효능별 버튼 클릭 (예: "해열진통제")
- 의약품 상세정보 확인

## 🎯 샘플 계정 (선택)

빠른 테스트를 위해 계정을 미리 만들어두고 싶다면:

```sql
# MySQL에서 실행
INSERT INTO users (username, password, name, email) VALUES
('testuser', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 
 '테스트', 'test@example.com');
```
- **아이디**: testuser
- **비밀번호**: password123

## ❓ 문제 해결

### 포트 8080이 이미 사용 중
다른 프로그램이 8080 포트를 사용 중입니다.
```bash
# 사용 중인 프로세스 확인
lsof -i :8080  # Mac/Linux
netstat -ano | findstr :8080  # Windows

# 또는 Tomcat 포트 변경
# $CATALINA_HOME/conf/server.xml 편집
```

### 데이터베이스 연결 실패
MySQL 서비스가 실행 중인지 확인:
```bash
# Linux
sudo systemctl status mysql

# Mac
brew services list

# Windows
services.msc에서 MySQL 확인
```

### WAR 파일이 배포되지 않음
- Tomcat 로그 확인: `$CATALINA_HOME/logs/catalina.out`
- 권한 확인: Tomcat이 webapps 디렉토리에 쓰기 권한이 있는지
- Tomcat 재시작

### 페이지가 깨져 보임
- 브라우저 캐시 삭제 (Ctrl+Shift+Del)
- 브라우저 개발자 도구(F12)에서 Console 탭 확인

## 📚 더 자세한 정보

- **배포 가이드**: [DEPLOYMENT.md](DEPLOYMENT.md)
- **개발자 가이드**: [DEVELOPER.md](DEVELOPER.md)
- **기능 명세**: [FEATURES.md](FEATURES.md)
- **프로젝트 요약**: [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md)

## 💡 팁

1. **개발 시**: IDE(IntelliJ, Eclipse)에서 직접 Tomcat 서버 실행 가능
2. **로그 확인**: 문제 발생 시 `$CATALINA_HOME/logs/catalina.out` 확인
3. **데이터 초기화**: `database/schema.sql` 재실행으로 데이터베이스 초기화
4. **샘플 데이터**: `database/sample_data.sql`로 의약품 샘플 재생성

## 🎉 완료!

이제 의약정보 시스템을 사용할 준비가 되었습니다!

궁금한 점이 있다면:
- 📧 이메일: info@pharmacy-system.com
- 🐛 이슈: https://github.com/ywhcho/java_dur/issues

**즐거운 사용 되세요!** 😊
