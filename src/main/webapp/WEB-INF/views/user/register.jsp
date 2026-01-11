<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="회원가입 - 의약정보 시스템" />
</jsp:include>

<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card">
            <div class="card-header">
                <h3 class="mb-0">회원가입</h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                
                <form method="post" action="${pageContext.request.contextPath}/user/register" onsubmit="return validateForm()">
                    <div class="mb-3">
                        <label for="username" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="username" name="username" required 
                               pattern="[a-zA-Z0-9]{3,20}" 
                               title="3-20자의 영문자와 숫자만 사용 가능합니다">
                        <div class="form-text">3-20자의 영문자와 숫자만 사용 가능합니다</div>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="password" name="password" required 
                               minlength="6">
                        <div class="form-text">최소 6자 이상</div>
                    </div>
                    <div class="mb-3">
                        <label for="passwordConfirm" class="form-label">비밀번호 확인</label>
                        <input type="password" class="form-control" id="passwordConfirm" required>
                    </div>
                    <div class="mb-3">
                        <label for="name" class="form-label">이름</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">이메일</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">회원가입</button>
                        <a href="${pageContext.request.contextPath}/user/login" class="btn btn-outline-secondary">
                            로그인 페이지로
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function validateForm() {
    const password = document.getElementById('password').value;
    const passwordConfirm = document.getElementById('passwordConfirm').value;
    
    if (password !== passwordConfirm) {
        alert('비밀번호가 일치하지 않습니다.');
        return false;
    }
    return true;
}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
