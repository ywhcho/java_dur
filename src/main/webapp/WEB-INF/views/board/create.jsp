<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="글쓰기 - 게시판" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h3>글쓰기</h3>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
                
                <form method="post" action="${pageContext.request.contextPath}/board/create">
                    <div class="mb-3">
                        <label for="title" class="form-label">제목</label>
                        <input type="text" class="form-control" id="title" name="title" required maxlength="200">
                    </div>
                    <div class="mb-3">
                        <label for="content" class="form-label">내용</label>
                        <textarea class="form-control" id="content" name="content" rows="10" required></textarea>
                    </div>
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/board/list" class="btn btn-secondary">취소</a>
                        <button type="submit" class="btn btn-primary">작성</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
