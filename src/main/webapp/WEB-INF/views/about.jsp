<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="About Us - 의약정보 시스템" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <h1 class="mb-4">About Us</h1>
        
        <div class="card mb-4">
            <div class="card-body">
                <h3 class="card-title">회사 소개</h3>
                <p class="card-text">
                    저희는 <strong>의약품 안전사용 전문회사</strong>입니다. 
                    국민의 건강한 삶을 위해 정확하고 신뢰할 수 있는 의약품 정보를 제공합니다.
                </p>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <h3 class="card-title">비전</h3>
                <p class="card-text">
                    모든 국민이 안전하게 의약품을 사용할 수 있도록 돕는 것이 저희의 비전입니다.
                    정확한 정보 제공을 통해 의약품 오남용을 방지하고, 건강한 사회를 만들어 갑니다.
                </p>
            </div>
        </div>

        <div class="card mb-4">
            <div class="card-body">
                <h3 class="card-title">미션</h3>
                <ul>
                    <li>의약품 안전사용 정보의 체계적 관리 및 제공</li>
                    <li>사용자 친화적인 검색 시스템 구축</li>
                    <li>지속적인 데이터 업데이트와 품질 관리</li>
                    <li>의약품 관련 커뮤니티 활성화</li>
                </ul>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <h3 class="card-title">연락처</h3>
                <p class="card-text">
                    <strong>주소:</strong> 서울특별시 강남구 테헤란로 123<br>
                    <strong>전화:</strong> 02-1234-5678<br>
                    <strong>이메일:</strong> info@pharmacy-system.com<br>
                    <strong>운영시간:</strong> 평일 09:00 - 18:00
                </p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
