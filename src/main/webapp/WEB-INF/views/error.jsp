<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="Error - 의약정보 시스템" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <div class="alert alert-danger">
            <h4 class="alert-heading">오류가 발생했습니다</h4>
            <hr>
            <c:choose>
                <c:when test="${not empty error}">
                    <p>${error}</p>
                </c:when>
                <c:otherwise>
                    <p>요청을 처리하는 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.</p>
                </c:otherwise>
            </c:choose>
            <hr>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">홈으로 돌아가기</a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
