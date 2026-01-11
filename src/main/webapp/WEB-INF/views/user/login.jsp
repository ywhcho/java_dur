<%@ include file="../common/header.jsp" %>

<style>
    .form-container {
        max-width: 500px;
        margin: 0 auto;
    }
    
    .form-group {
        margin-bottom: 1.5rem;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        font-weight: 600;
        color: #2c3e50;
    }
    
    .form-group input {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 1rem;
    }
    
    .form-group input:focus {
        outline: none;
        border-color: #3498db;
    }
    
    .form-actions {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
    }
    
    .form-actions button {
        flex: 1;
    }
</style>

<div class="form-container">
    <h1>로그인</h1>
    
    <c:if test="${param.registered == 'true'}">
        <div class="alert alert-success">
            회원가입이 완료되었습니다. 로그인해주세요.
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">
            ${error}
        </div>
    </c:if>
    
    <form method="post" action="${pageContext.request.contextPath}/user/login">
        <div class="form-group">
            <label for="username">사용자명</label>
            <input type="text" id="username" name="username" required>
        </div>
        
        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn">로그인</button>
            <a href="${pageContext.request.contextPath}/user/register" class="btn btn-secondary">회원가입</a>
        </div>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
