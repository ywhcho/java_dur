<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
    <jsp:param name="title" value="${medicine.name} - 의약정보" />
</jsp:include>

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h3>${medicine.name}</h3>
            </div>
            <div class="card-body">
                <div class="row mb-3">
                    <div class="col-md-3"><strong>의약품명:</strong></div>
                    <div class="col-md-9">${medicine.name}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-3"><strong>성분명:</strong></div>
                    <div class="col-md-9">${medicine.ingredient}</div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-3"><strong>효능:</strong></div>
                    <div class="col-md-9">
                        <span class="badge bg-info fs-6">${medicine.efficacy}</span>
                    </div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="col-md-3"><strong>용법:</strong></div>
                    <div class="col-md-9" style="white-space: pre-wrap;">${medicine.usage}</div>
                </div>
                <hr>
                <div class="row mb-3">
                    <div class="col-md-3"><strong>주의사항:</strong></div>
                    <div class="col-md-9 text-danger" style="white-space: pre-wrap;">${medicine.precautions}</div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${pageContext.request.contextPath}/medicine/search" class="btn btn-secondary">
                    검색으로 돌아가기
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
