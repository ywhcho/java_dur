# 배포 가이드 (Deployment Guide)

## 의약정보 웹사이트 배포 방법

이 문서는 의약정보 웹사이트를 로컬 또는 프로덕션 환경에 배포하는 방법을 설명합니다.

## 목차
1. [사전 준비](#사전-준비)
2. [데이터베이스 설정](#데이터베이스-설정)
3. [애플리케이션 빌드](#애플리케이션-빌드)
4. [Tomcat 배포](#tomcat-배포)
5. [검증](#검증)
6. [문제 해결](#문제-해결)

---

## 사전 준비

### 필수 소프트웨어
- **Java Development Kit (JDK)**: 11 이상
- **Apache Maven**: 3.6 이상
- **MySQL**: 8.0 이상
- **Apache Tomcat**: 9.0 이상

### 설치 확인
```bash
# Java 버전 확인
java -version

# Maven 버전 확인
mvn -version

# MySQL 버전 확인
mysql --version
```

---

## 데이터베이스 설정

### 1. MySQL 접속
```bash
mysql -u root -p
```

### 2. 데이터베이스 및 테이블 생성
프로젝트 루트 디렉토리에서:
```bash
# 스키마 생성
mysql -u root -p < database/schema.sql

# 샘플 데이터 삽입 (선택사항)
mysql -u root -p < database/sample_data.sql
```

또는 MySQL 클라이언트에서 직접:
```sql
source /path/to/project/database/schema.sql;
source /path/to/project/database/sample_data.sql;
```

### 3. 데이터베이스 연결 설정
`src/main/resources/db.properties` 파일을 수정:

```properties
db.url=jdbc:mysql://localhost:3306/pharmacy_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=your_mysql_password
db.driver=com.mysql.cj.jdbc.Driver
```

**주의**: 실제 MySQL 비밀번호로 `your_mysql_password`를 변경하세요.

---

## 애플리케이션 빌드

### 1. 프로젝트 클론 (Git 사용시)
```bash
git clone https://github.com/ywhcho/java_dur.git
cd java_dur
```

### 2. Maven 빌드
```bash
# 클린 빌드
mvn clean package

# 빌드 완료 후 생성된 WAR 파일 확인
ls -l target/pharmacy-info.war
```

빌드가 성공하면 `target/pharmacy-info.war` 파일이 생성됩니다 (약 5MB).

---

## Tomcat 배포

### 방법 1: 자동 배포 (권장)
```bash
# WAR 파일을 Tomcat webapps 디렉토리로 복사
cp target/pharmacy-info.war $TOMCAT_HOME/webapps/

# Tomcat 시작
$TOMCAT_HOME/bin/startup.sh  # Linux/Mac
$TOMCAT_HOME\bin\startup.bat  # Windows
```

Tomcat이 자동으로 WAR 파일을 압축 해제하고 배포합니다.

### 방법 2: Tomcat Manager 사용
1. 웹 브라우저에서 Tomcat Manager 접속: `http://localhost:8080/manager`
2. "WAR file to deploy" 섹션에서 파일 선택
3. `pharmacy-info.war` 파일 업로드
4. "Deploy" 버튼 클릭

### 방법 3: 수동 배포
```bash
# 1. Tomcat 중지
$TOMCAT_HOME/bin/shutdown.sh

# 2. 기존 배포 삭제 (재배포시)
rm -rf $TOMCAT_HOME/webapps/pharmacy-info
rm -f $TOMCAT_HOME/webapps/pharmacy-info.war

# 3. WAR 파일 복사
cp target/pharmacy-info.war $TOMCAT_HOME/webapps/

# 4. Tomcat 시작
$TOMCAT_HOME/bin/startup.sh
```

---

## 검증

### 1. 애플리케이션 접속
웹 브라우저에서 다음 URL로 접속:
```
http://localhost:8080/pharmacy-info/
```

### 2. 기능 테스트

#### a) 홈페이지 확인
- 메인 페이지가 정상적으로 표시되는지 확인
- 네비게이션 메뉴 동작 확인

#### b) 회원가입 테스트
1. "회원가입" 메뉴 클릭
2. 정보 입력:
   - 아이디: testuser
   - 비밀번호: test1234
   - 이름: 테스트
   - 이메일: test@example.com
3. 회원가입 완료 후 자동 로그인 확인

#### c) 로그인 테스트
1. 로그아웃 후 "로그인" 메뉴 클릭
2. 방금 생성한 계정으로 로그인
3. 우측 상단에 사용자 이름 표시 확인

#### d) 게시판 테스트
1. "게시판" 메뉴 클릭
2. "글쓰기" 버튼으로 게시글 작성
3. 작성한 게시글 확인
4. 게시글 수정/삭제 테스트

#### e) 의약정보 검색 테스트
1. "의약정보" 메뉴 클릭
2. 성분명으로 검색 (예: "아세트아미노펜")
3. 효능별 분류 버튼 클릭
4. 의약품 상세 정보 확인

### 3. 로그 확인
```bash
# Tomcat 로그 실시간 모니터링
tail -f $TOMCAT_HOME/logs/catalina.out

# 에러 로그 확인
grep -i error $TOMCAT_HOME/logs/catalina.out
```

---

## 문제 해결

### 데이터베이스 연결 실패
**증상**: "Database error occurred" 또는 연결 오류 메시지

**해결방법**:
1. MySQL 서비스 실행 확인:
   ```bash
   # Linux
   sudo systemctl status mysql
   
   # Mac
   brew services list
   
   # Windows
   services.msc에서 MySQL 서비스 확인
   ```

2. `db.properties` 설정 확인:
   - 호스트, 포트, 데이터베이스명 확인
   - 사용자명과 비밀번호 확인

3. MySQL 연결 테스트:
   ```bash
   mysql -u root -p -e "USE pharmacy_db; SELECT COUNT(*) FROM users;"
   ```

### 404 에러 (페이지를 찾을 수 없음)
**증상**: 애플리케이션 접속시 404 에러

**해결방법**:
1. WAR 파일이 정상적으로 배포되었는지 확인:
   ```bash
   ls -l $TOMCAT_HOME/webapps/
   ```

2. Tomcat이 WAR를 압축 해제했는지 확인:
   ```bash
   ls -l $TOMCAT_HOME/webapps/pharmacy-info/
   ```

3. 정확한 URL 사용:
   - `http://localhost:8080/pharmacy-info/` (끝에 슬래시 포함)

### 500 에러 (서버 내부 오류)
**증상**: 특정 기능 실행시 500 에러

**해결방법**:
1. Tomcat 로그 확인:
   ```bash
   tail -100 $TOMCAT_HOME/logs/catalina.out
   ```

2. 데이터베이스 연결 확인

3. 스택 트레이스에서 오류 원인 파악

### 포트 충돌
**증상**: Tomcat 시작 실패, "Address already in use"

**해결방법**:
1. 8080 포트 사용 프로세스 확인:
   ```bash
   # Linux/Mac
   lsof -i :8080
   
   # Windows
   netstat -ano | findstr :8080
   ```

2. Tomcat 포트 변경:
   - `$TOMCAT_HOME/conf/server.xml` 편집
   - `<Connector port="8080"...>` 를 다른 포트로 변경

### 의약정보가 표시되지 않음
**증상**: 의약정보 검색시 결과 없음

**해결방법**:
1. 샘플 데이터가 삽입되었는지 확인:
   ```bash
   mysql -u root -p -e "USE pharmacy_db; SELECT COUNT(*) FROM medicine;"
   ```

2. 샘플 데이터 재삽입:
   ```bash
   mysql -u root -p < database/sample_data.sql
   ```

---

## 프로덕션 배포 체크리스트

프로덕션 환경에 배포하기 전 확인 사항:

- [ ] 데이터베이스 비밀번호가 안전하게 관리되고 있는가?
- [ ] MySQL은 외부 접근이 제한되어 있는가?
- [ ] Tomcat Manager는 강력한 비밀번호로 보호되어 있는가?
- [ ] HTTPS가 설정되어 있는가? (SSL/TLS)
- [ ] 세션 타임아웃이 적절하게 설정되어 있는가?
- [ ] 로그 파일 로테이션이 설정되어 있는가?
- [ ] 정기적인 데이터베이스 백업이 설정되어 있는가?
- [ ] 방화벽 규칙이 올바르게 설정되어 있는가?

---

## 유용한 명령어

### Tomcat 제어
```bash
# 시작
$TOMCAT_HOME/bin/startup.sh

# 중지
$TOMCAT_HOME/bin/shutdown.sh

# 재시작
$TOMCAT_HOME/bin/shutdown.sh && sleep 3 && $TOMCAT_HOME/bin/startup.sh

# 상태 확인
ps aux | grep tomcat
```

### 데이터베이스 백업
```bash
# 전체 데이터베이스 백업
mysqldump -u root -p pharmacy_db > backup_$(date +%Y%m%d).sql

# 복원
mysql -u root -p pharmacy_db < backup_20260111.sql
```

### 로그 모니터링
```bash
# 실시간 로그
tail -f $TOMCAT_HOME/logs/catalina.out

# 최근 에러만 확인
grep -i error $TOMCAT_HOME/logs/catalina.out | tail -50

# 특정 날짜 로그 확인
grep "2026-01-11" $TOMCAT_HOME/logs/catalina.out
```

---

## 지원 및 문의

문제가 지속되거나 추가 지원이 필요한 경우:
- 이메일: info@pharmacy-system.com
- 이슈 트래커: https://github.com/ywhcho/java_dur/issues

---

**최종 업데이트**: 2026-01-11
