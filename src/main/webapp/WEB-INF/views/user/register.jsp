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
    <h1>회원가입</h1>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">
            ${error}
        </div>
    </c:if>
    
    <form method="post" action="${pageContext.request.contextPath}/user/register">
        <div class="form-group">
            <label for="username">사용자명 *</label>
            <input type="text" id="username" name="username" required>
        </div>
        
        <div class="form-group">
            <label for="password">비밀번호 *</label>
            <input type="password" id="password" name="password" required>
        </div>
        
        <div class="form-group">
            <label for="email">이메일 *</label>
            <input type="email" id="email" name="email" required>
        </div>
        
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name">
        </div>
        
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="phone">
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn">회원가입</button>
            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-secondary">로그인으로</a>
        </div>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
