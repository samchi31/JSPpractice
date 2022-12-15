<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/includee/preScript.jsp"></jsp:include>
</head>
<body>
	<h4>Restful 기반의 메모 관리(자원에 대한 식별성(url)+행위 정보(method))</h4>
	
	<form action="${pageContext.request.contextPath}/memo" method="post">
		<input type="text" name="writer" placeholder="작성자" />
		<input type="date" name="date" placeholder="작성일" />
		<textarea name="content"></textarea>
		<input type="submit" value="등록" />		
	</form>
	
	<table class="table-bordered">
		<thead>
			<tr>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody id="listBody">
		
		</tbody>
	</table>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        ...
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
	      </div>
	    </div>
	  </div>
	</div>
	
<script type="text/javascript">
	let listBody = $('#listBody');
	let form = $('form').on('submit',function(){
		event.preventDefault();
		
		let data = $(this).serialize();
				
		$.ajax({
			url : "${pageContext.request.contextPath}/memo",
			method : this.method,
			data : data,
			dataType : "json",
			success : function(resp) {
				makeListBody(resp.target);
			},
			error : function(jqXHR, status, error) {
				console.log(jqXHR);
				console.log(status);
				console.log(error);
			}
		});
		
		return false;
	});
	
	//ED'path't Driven Development), TDD(Test Driven Development)
	const myModal = $('#myModal').on('show.bs.modal',function(event){
		//this == event.target
		//console.log(event.relatedTarget);	// modal을 오픈할 때 사용한 클릭 대상, tr
		let memo = $(event.relatedTarget).data("memo");
		$(this).find(".modal-body").html(memo.content);	// 현재 떠있는 모달의 요소에 접근
		$(this).find(".modal-title").html(memo.code);		
	}).on('hidden.bs.modal',function(event){
		$(event.target).find(".modal-body").empty();
		$(event.target).find(".modal-title").empty();
	});
	
	let makeListBody = function(memoList){
		listBody.empty();
		let trs = [];
		if(makeListBody.length>0){
			$.each(memoList,function(idx,memo){
				//console.log(idx, value);
				//data-bs-toggle="modal" data-bs-target="#exampleModal"
				let tr = $('<tr>').append(
						$('<td>').html(memo.writer), $('<td>').html(this.date)
					).data("memo",memo)
					.attr({
						"data-bs-toggle":"modal",
						"data-bs-target":"#myModal"
					});
				trs.push(tr);
			});
		} else {
			$("<tr>").html(
					$("<td>").attr("colspan","2")
							 .html("작성된 메모 없음"));
			trs.push(tr);
		}
		listBody.append(trs);
	};
	
	$.ajax({
		url : "${pageContext.request.contextPath}/memo",
		method : "get",
		dataType : "json",
		success : function(resp) {
			makeListBody(resp.target);
		},
		error : function(jqXHR, status, error) {
			console.log(jqXHR);
			console.log(status);
			console.log(error);
		}
	});

</script>
<jsp:include page="/includee/postScript.jsp" />
</body>
</html>