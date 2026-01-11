<%@ include file="../common/header.jsp" %>

<style>
    .form-container {
        max-width: 900px;
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
    
    .form-group input,
    .form-group textarea {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 1rem;
        font-family: inherit;
    }
    
    .form-group input:focus,
    .form-group textarea:focus {
        outline: none;
        border-color: #3498db;
    }
    
    .form-group textarea {
        min-height: 400px;
        resize: vertical;
    }
    
    .form-actions {
        display: flex;
        gap: 1rem;
        margin-top: 2rem;
    }
</style>

<div class="form-container">
    <h1>글쓰기</h1>
    
    <form method="post" action="${pageContext.request.contextPath}/board/create">
        <div class="form-group">
            <label for="title">제목 *</label>
            <input type="text" id="title" name="title" required>
        </div>
        
        <div class="form-group">
            <label for="content">내용 *</label>
            <textarea id="content" name="content" required></textarea>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn">작성</button>
            <a href="${pageContext.request.contextPath}/board" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
