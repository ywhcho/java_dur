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
    
    .form-group input:disabled {
        background-color: #f5f5f5;
        cursor: not-allowed;
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
    <h1>프로필 수정</h1>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">
            ${success}
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">
            ${error}
        </div>
    </c:if>
    
    <form method="post" action="${pageContext.request.contextPath}/user/profile">
        <div class="form-group">
            <label for="username">사용자명</label>
            <input type="text" id="username" value="${user.username}" disabled>
            <small style="color: #7f8c8d;">사용자명은 변경할 수 없습니다.</small>
        </div>
        
        <div class="form-group">
            <label for="password">새 비밀번호</label>
            <input type="password" id="password" name="password">
            <small style="color: #7f8c8d;">변경하지 않으려면 비워두세요.</small>
        </div>
        
        <div class="form-group">
            <label for="email">이메일 *</label>
            <input type="email" id="email" name="email" value="${user.email}" required>
        </div>
        
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" value="${user.name}">
        </div>
        
        <div class="form-group">
            <label for="phone">전화번호</label>
            <input type="tel" id="phone" name="phone" value="${user.phone}">
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn">수정하기</button>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
