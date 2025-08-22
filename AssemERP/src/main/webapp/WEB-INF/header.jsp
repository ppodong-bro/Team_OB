<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
    String logoPath = "C:/GitHub/Team_OB/AssemERP/upload/account/profile-images/Login.png";

    String avatarSrc = null;
    try {
        java.nio.file.Path p = java.nio.file.Paths.get(logoPath);
        if (java.nio.file.Files.exists(p)) {
            String mime = java.nio.file.Files.probeContentType(p);
            if (mime == null) mime = "image/png";
            byte[] bytes = java.nio.file.Files.readAllBytes(p);
            String b64 = java.util.Base64.getEncoder().encodeToString(bytes);
            avatarSrc = "data:" + mime + ";base64," + b64;
        }
    } catch (Exception ignore) { }

    if (avatarSrc == null) {
        String svg = "<svg xmlns='http://www.w3.org/2000/svg' width='80' height='80'>"
                + "<defs><linearGradient id='g' x1='0' y1='0' x2='1' y2='1'>"
                + "<stop offset='0%' stop-color='#6366f1'/>"
                + "<stop offset='100%' stop-color='#60a5fa'/>"
                + "</linearGradient></defs>"
                + "<rect width='100%' height='100%' rx='40' fill='url(#g)'/>"
                + "<text x='50%' y='54%' text-anchor='middle' dominant-baseline='middle'"
                + " font-family='-apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif'"
                + " font-size='30' fill='#fff' font-weight='700'>U</text></svg>";
        avatarSrc = "data:image/svg+xml;utf8," + java.net.URLEncoder.encode(svg, "UTF-8");
    }
%>

<sec:authentication property="name" var="loginId" />

<style>
  /* 레이아웃 간섭 없는 심플 헤더: position: static, grid 사용 안 함 */
  .app-header{
    height:65px;
    padding:0 1rem;
    border-bottom:1px solid #e5e7eb;
    background:#fff;
    display:flex; align-items:center; justify-content:space-between;
    width:100%;
  }
  .brand-link{display:inline-flex;align-items:center;gap:.5rem;text-decoration:none;color:#111827;}
  .brand-badge{display:inline-grid;place-items:center;width:32px;height:32px;border-radius:8px;background:#4f46e5;color:#fff;font-weight:800}
  .brand-text{font-weight:700;letter-spacing:.2px}

  .avatar-btn{padding:0;border:0;background:transparent}
  .hdr-avatar{
    width:40px;height:40px;border-radius:999px;object-fit:cover;display:block;
    background:#eef2ff;
    
  /* User dropdown: modern Bootstrap-ish look */
	.user-dd{min-width:160px;border-radius:14px;overflow:hidden}
	.user-dd .dropdown-header{
	  background:linear-gradient(135deg,#6366f1,#60a5fa);
	  color:#fff
	}
	.user-dd .dropdown-header .name{font-weight:700;letter-spacing:.2px}
	.user-dd .dropdown-header .sub{opacity:.85}
	.user-dd .list-group-item{padding:.6rem .9rem}
	.user-dd .list-group-item .bi{font-size:1.1rem}
 	}

   /* 드롭다운 카드 최소 스타일(부트스트랩 드롭다운 사용 전제) */
   .dropdown-menu{border-radius:12px}
   
   /* 드롭다운 헤더의 로그인 아이디 크기/두께 */
	.user-dd .dropdown-header .sub{
	  font-size: 1rem;   /* 16px, 더 키우려면 1.1rem~1.2rem */
	  font-weight: 600;  /* 선택: 두껍게 */
	}
</style>

<header class="app-header" role="banner"><!-- style="background:#30619E; color:#fff;"  -->
  <!-- 좌측 브랜드 -->
  <a href="#" class="#">
    <span class="#"></span>
    <span class="#"></span>
  </a>

  <!-- 우측: 로그인/아바타 -->
  <div class="d-flex align-items-center">
    <sec:authorize access="isAnonymous()">
      <a href="${pageContext.request.contextPath}/account/loginForm" class="btn btn-primary btn-sm px-3 fw-bold">Login</a>
    </sec:authorize>

    <sec:authorize access="isAuthenticated()">
    	<div class="dropdown">
		    <button class="avatar-btn" data-bs-toggle="dropdown" aria-expanded="false" aria-label="사용자 메뉴 열기">
		      <!-- 필수! 프로필 이미지 -->
		      <img class="hdr-avatar" alt="프로필" loading="lazy" decoding="async"
		           src="<%= avatarSrc %>" />
		    </button>
      	<!-- ↓ 이 아래는 ‘프로필/로그아웃’ 메뉴 (원하시는 근사한 스타일) -->
	  	<!-- <div class="dropdown-menu dropdown-menu-end p-0 border-0 shadow user-dd"> -->
	  	<div class="dropdown-menu dropdown-menu-end p-0 border-0 shadow user-dd" style="min-width: 160px;">

		  <!-- 상단 그라데이션 헤더 -->
		  <div class="dropdown-header py-2 px-3">
		    <div class="d-flex align-items-center gap-1">
		      <!-- 작게 재사용: 헤더 아바타 소스(이미 Base64 세팅되어 있음) -->
		      <img src="<%= avatarSrc %>" alt="" class="rounded-circle border border-white"
		           style="width:32px;height:32px;object-fit:cover">
		      <div>
		        <div class="name">${displayName}</div>
		        <div class="sub">${loginId}</div>
		      </div>
		    </div>
		  </div>
		  
		  <!-- ★ 긴 구분선 -->
  		  <hr class="dropdown-divider my-0">
		
		  <!-- 본문 액션: 프로필 -->
		  <!-- 버튼 타입으로 통일: 프로필(GET) + 로그아웃(POST) -->
		 <!--  <div class="px-3 py-3 d-grid gap-2"> -->
		  <div class="px-3 py-2">
		    <!-- 프로필: GET 폼 -->
		    <form action="${ctx}/sm/profileForm" method="get" class="m-0">
		      <!-- <button type="submit" class="btn btn-primary w-90">
		        <i class="bi bi-person-circle me-1"></i> 프로필
		      </button> -->
		      <button type="submit" class="btn btn-outline-primary w-90">
		        <i class="bi bi-clipboard me-1"></i> 프로필 &nbsp;&nbsp;
		      </button>
		    </form>
		  </div>
		  
		  <!-- 하단: 로그아웃 버튼(POST) -->
		  <div class="px-3 py-2">
		    <form action="${ctx}/logout" method="post" class="m-0">
		      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		      <button type="submit" class="btn btn-outline-danger w-90">
		        <i class="bi bi-box-arrow-right me-1"></i> 로그아웃
		      </button>
		    </form>
		  </div>
		</div>
	</div>

    </sec:authorize>
  </div>
</header>
