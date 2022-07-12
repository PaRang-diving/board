<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/header.jsp" %>


            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">SOON 게시판</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            안녕하세요! 반갑습니다.
		                    <button id="regBtn" type="button" class="btn btn-xs pull-right">
		                    	글쓰기
		                    </button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>글번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>등록일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${list}" var="board">
                                		<!-- ${list}는 BoardController.java에서 Model에 list(목록데이터)라는 이름으로 담았다. -->                                	
	                                    <tr class="odd gradeX">
	                                        <td><a class='move' href='<c:out value="${board.bno}"/>'>${board.bno}</td>
	                                        <td><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></td>
	                                        <td>${board.writer}</td>
	                                        <td><fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd"/></td>
	                                        <td><fmt:formatDate value="${board.updateDate }" pattern="yyyy-MM-dd"/></td>
	                                    </tr>
	                                </c:forEach>
 
                                </tbody>
                            </table>
                            <!-- /.table-responsive -->
                            <form id="searchForm" action="/board/list" method="get">
                            	<select name="type">
                            		<option value ="" ${pageMaker.cri.type == null?"selected":"" } >---</option>
                            		<option value ="T" ${pageMaker.cri.type eq 'T'?"selected":"" }>제목</option>
                            		<option value ="C" ${pageMaker.cri.type eq 'C'?"selected":"" }>내용</option>
                            		<option value ="W" ${pageMaker.cri.type eq 'W'?"selected":"" }>작성자</option>
                            		<option value ="TC" ${pageMaker.cri.type eq 'TC'?"selected":"" }>제목+내용</option>
                            		<option value ="TCW" ${pageMaker.cri.type eq 'TCW'?"selected":"" }>제목+내용+작성자</option>
                            	</select>
                            	<input type='text' name='keyword' value='${pageMaker.cri.keyword }'>
                            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
                            	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
                            	<button class='btn btn-default'>검색하기</button>                            
                            </form>
                            
                            
                            <%-- <h3>${pageMaker}</h3> --%>
                            <div class='pull-right'>
                            	<ul class="pagination">
                            		<!-- 조건에 따라 프리뷰 또는 넥스트가 안나오는 조건 -->
                            		<c:if test="${pageMaker.prev }">
									    <li class="page-item">
									      <a class="page-link" href="${pageMaker.startPage -1}" tabindex="-1">Previous</a>
									    </li>                            	
                            		</c:if>
                            		<c:forEach begin="${pageMaker.startPage}" 
                            				   end="${pageMaker.endPage}" var="num">
                            				   					<!--  -->
                            			 <li class='page-item ${pageMaker.cri.pageNum == num?"active":""}'>
                            			 	<a class="page-link" href="${num }">${num}</a>
                            			 </li>
                            		</c:forEach>
                            		
                            		<c:if test="${pageMaker.next }">
	                            		<li class="page-item">
									    	<a class="page-link" href="${pageMaker.endPage +1 }" tabindex="-1">Next</a>
								    	</li>  
								    </c:if>
                            	</ul>
                            </div>
                            
                            <form id = 'actionForm' action= "/board/list" method='get'>
                            	<input type='hidden' name='pageNum' value= '${pageMaker.cri.pageNum}'>
                            	<input type='hidden' name='amount' value= '${pageMaker.cri.amount}'>
                            	<input type='hidden' name='type' value= '${pageMaker.cri.type}'>
                            	<input type='hidden' name='keyword' value= '${pageMaker.cri.keyword}'>
                            </form>
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
<!-- 모달창 modal 만들기 -->

<div id="myModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> -->
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
$(document).ready(function() { //얘는 자동 수행
	
	/* EL태그 이용 boardController에서 rttr.addFlashAttribute("result", bno); 로 보냈던 result값 출력? */
	var result = '<c:out value="${result}"/>';
	/* c:out이 뭔지 c:out을 쓰는이유가 뭔지 구글에 검색해볼것.. */
	
	var searchForm = $("#searchForm");
	
	
	
	
	
	/* 아이디가 regBtn인 버튼을 클릭했을때 /bord/register.jsp로 가라! self는 윈도우를 말하고 
		윈도우의 브라우저 위치location을 이동시킨다.*/
	$("#regBtn").click(function() {
		self.location = "/board/register";
	});
	
	var actionForm = $('#actionForm');
	/* .paginate_button 이라는 클래스안에 있는 a태그 */
	$(".page-link").on("click", function(e) {
		
		/* e.preventDefault(); 기본동작 막기... a태그의 기본동작은 페이지 링크를 통해 이동하는것 */
		e.preventDefault(); /* 이동이 안된다. */
		
		/* 클릭한애(클릭한 페이지 번호)는 this가 된다. */
		var targetPage = $(this).attr("href");
		
		/* 웹에서 f12 콘솔을 통해 페이지 번호가 찍히는 것을 볼수 있다. 1, 2, 3, 4 ... 등 */
		console.log(targetPage);
		
		/* actionForm안에 find를 이용해서 하위 태그를 찾는다. pageNum이라는 태그를 찾아서 밸류값을 targetPage로 세팅 */
		actionForm.find("input[name='pageNum']").val(targetPage);
		/* <input type='hidden' name='pageNum' value= '${pageMaker.cri.pageNum}'> 페이지 번호를 클릭하면 이부분에 value값이 변화한다. */
		
		actionForm.submit();
		
	});
	
	$(".move").on("click", function(e) {
		e.preventDefault();
		
		var targetBno = $(this).attr("href");
		
		console.log(targetBno);
		
		/* form태그에 input태그를 추가한다. */
		actionForm.append("<input type='hidden' name='bno' value='"+targetBno+"'>");
		
		/* 액션 속성을 /board/get으로 바꾼다. */
		actionForm.attr("action", "/board/get");
		
		actionForm.submit();
		
	});
	
	$("#searchForm button").on("click", function(e){
		e.preventDefault();
		console.log(".............click");
		
		/* 7페이지를 보고 있다가 search를 진행하면 검색된 결과가 로드되면서 1page로 와야한다. */
		searchForm.find("input[name='pageNum']").val(1);
		
		searchForm.submit();
	});
	
	// 함수 실행부
	
	/* 모달 modal */
	checkModal(result);
	
	/* 브라우저를 뒤로 갔다가 앞으로 가면 모달 창이 뜨는데 그것을 방지 하기위해 history를 리셋한다.  */
	history.replaceState({}, null, null);
	
	function checkModal(result) {
		console.log(">>>>>>>>result : " + result);
		
		if (result === '' || history.state) {
			return;
		}
		
		if (result === 'success') {
			$(".modal-body").html(
					"정상적으로 처리되었습니다.");
			
		} else if (parseInt(result) > 0) {
			$(".modal-body").html(
					"게시글 " + parseInt(result)
							+ " 번이 등록되었습니다.");
		}
	
		$("#myModal").modal("show");		
	}
});


	







</script>

<%@ include file="../includes/footer.jsp" %>
