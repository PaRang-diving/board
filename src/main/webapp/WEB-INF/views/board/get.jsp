<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시글 확인</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        	게시글을 수정 또는 삭제하려면 아래 수정/삭제 버튼을 클릭하십시오.
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">

	                        <div class="form-group">
		                            <label>글번호</label>
		                            <input class="form-control" name="bno" readonly="readonly" 
		                            value='<c:out value="${board.bno}"/>'>
	                        </div>
	                        <div class="form-group">
		                            <label>제목</label>
		                            <input class="form-control" name="title" readonly="readonly" 
		                            value='<c:out value="${board.title}"/>'>
	                        </div>
	                        <div class="form-group">
		                            <label>내용</label>
		                            <textarea rows="5" cols="50" class="form-control" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
	                        </div>
	                        <div class="form-group">
		                            <label>작성자</label>
		                            <input class="form-control" name="writer" readonly="readonly"
		                            value='<c:out value="${board.writer}"/>'>
	                        </div>
	                        
	                        <form id = 'actionForm' action= "/board/list" method='get'>
	                        	<!-- BoardController에 @ModelAttribute("cri")를 통해 cri를 바로 소완가능히디 -->
                            	<input type='hidden' name='pageNum' value= '${cri.pageNum}'>
                            	<input type='hidden' name='amount' value= '${cri.amount}'>
                            	<input type='hidden' name='bno' value= '${board.bno}'>
                            	<input type='hidden' name='type' value= '${cri.type}'>
                            	<input type='hidden' name='keyword' value= '${cri.keyword}'>
                            </form>                 
	                        
	                        <button type="button" class="btn btn-default listBtn"><a href='/board/list'>글목록</a></button>
	                        <button type="button" class="btn btn-default modBtn"><a href='/board/modify?bno=<c:out value="${board.bno}"/>'>수정/삭제</a></button>
                        	
                        	<script type="text/javascript">
							
                        	var actionForm = $("#actionForm");
                        	
                        	$(".listBtn").click(function(e){
                        		e.preventDefault();
                        		actionForm.find("input[name='bno']").remove();
                        		actionForm.submit();
                        		
                        	});
                        	
                        	$(".modBtn").click(function(e){
                        		e.preventDefault();
                        		actionForm.attr("action", "/board/modify");
                        		actionForm.submit();
                        		
                        	});
                        	
                        	</script>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>

<%@ include file="../includes/footer.jsp" %>