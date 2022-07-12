<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시글 수정/삭제</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        	게시글을 수정 또는 삭제하려면 아래의 버튼을 눌러주세요.
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	
                        	<form>
                        		<input type='hidden' name='pageNum' value='${cri.pageNum}'>
                        		<input type='hidden' name='amount' value='${cri.amount}'>
                        		<input type='hidden' name='type' value='${cri.type}'>
                        		<input type='hidden' name='keyword' value='${cri.keyword}'>
			
				                <div class="form-group">
					                    <label>글번호</label>
					                    <input class="form-control" name="bno" readonly="readonly" 
					                    value='<c:out value="${board.bno}"/>'>
				                </div>
				                <div class="form-group">
					                    <label>제목</label>
					                    <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
				                </div>
				                <div class="form-group">
					                    <label>내용</label>
					                    <textarea rows="5" cols="50" class="form-control" name="content"><c:out value="${board.content}"/></textarea>
				                </div>
				                <div class="form-group">
					                    <label>작성자</label>
					                    <input class="form-control" name="writer" readonly="readonly"
					                    value='<c:out value="${board.writer}"/>'>
				                </div>
				                <!-- data-oper 커스텀 데이터 속성(html5) -->
				                <button class="btn btn-default" data-oper='modify'>수정</button>
				                <button class="btn btn-danger" data-oper='remove'>삭제</button>
				                <button class="btn btn-info" data-oper='list'>글목록</button>
			                    
                        	</form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>

<script type="text/javascript">
$(document).ready(function() {
	
	var formObj = $("form");
	
	$('.btn').click(function(e){
		/* 이벤트 처리할때 기본동작을 막으면 좋다. 링크 이런거 다 안됨. 폼태그 안에서 버튼을 클릭하면 자동으로 서브밋이 일어난다. */
		/* 그러한 기본동작을 다 막아버린다. */
		e.preventDefault();
		/* $(this)는 클릭한 버튼을 의미, jquery의 데이타라는 속성을 쓰면 위의 data-oper의 속성을 알수 있다. */
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === "list") {
			/* 현재 윈도우 창에 위치를 /board/list로 */
			self.location = "/board/list";
		} else if(operation === "remove"){
			formObj.attr("action", "/board/remove")
				.attr("method", "post");
			formObj.submit();
			
		} else if(operation === "modify"){
			formObj.attr("action", "/board/modify")
				.attr("method", "post");
			formObj.submit();
		}
	})
});
</script>


<%@ include file="../includes/footer.jsp" %>