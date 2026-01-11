<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="프로필 - 의약정보 시스템" />
</jsp:include>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h3 class="mb-0">내 프로필</h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>
                
                <form method="post" action="${pageContext.request.contextPath}/user/profile">
                    <div class="mb-3">
                        <label for="username" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="username" value="${sessionScope.user.username}" disabled>
                        <div class="form-text">아이디는 변경할 수 없습니다</div>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" class="form-control" id="name" name="name" 
                               value="${sessionScope.user.name}" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">이메일</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               value="${sessionScope.user.email}" required>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">프로필 수정</button>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                            홈으로 돌아가기
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <div class="card mt-4">
            <div class="card-header">
                <h4 class="mb-0">계정 정보</h4>
            </div>
            <div class="card-body">
                <p><strong>가입일:</strong> ${sessionScope.user.createdAt}</p>
                <p><strong>최종 수정일:</strong> ${sessionScope.user.updatedAt}</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
