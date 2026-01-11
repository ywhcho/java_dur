<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="홈 - 의약정보 시스템" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <div class="jumbotron bg-light p-5 rounded">
            <h1 class="display-4">의약정보 시스템에 오신 것을 환영합니다</h1>
            <p class="lead">안전한 의약품 사용을 위한 정보를 제공합니다.</p>
            <hr class="my-4">
            <p>의약품의 성분, 효능, 용법, 주의사항 등을 검색하고 확인하실 수 있습니다.</p>
            <div class="mt-4">
                <a class="btn btn-primary btn-lg me-2" href="${pageContext.request.contextPath}/medicine/search" role="button">
                    의약정보 검색
                </a>
                <a class="btn btn-secondary btn-lg" href="${pageContext.request.contextPath}/board/list" role="button">
                    게시판 바로가기
                </a>
            </div>
        </div>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-4">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">성분명 검색</h5>
                <p class="card-text">의약품의 주성분으로 검색하여 관련 의약품 정보를 확인하세요.</p>
                <a href="${pageContext.request.contextPath}/medicine/search" class="btn btn-outline-primary">검색하기</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">효능별 보기</h5>
                <p class="card-text">해열진통제, 소화제, 항생제 등 효능별로 의약품을 분류하여 확인하세요.</p>
                <a href="${pageContext.request.contextPath}/medicine/search" class="btn btn-outline-primary">보기</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title">게시판</h5>
                <p class="card-text">의약품 관련 질문과 정보를 공유할 수 있는 커뮤니티 게시판입니다.</p>
                <a href="${pageContext.request.contextPath}/board/list" class="btn btn-outline-primary">게시판 가기</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
