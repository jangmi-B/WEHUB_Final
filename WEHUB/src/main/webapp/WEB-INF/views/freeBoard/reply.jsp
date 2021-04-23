
'<div class="reply "id="reply">'
	
		+ '<c:if test="' + data[i].replies[r].replyContent + ' != null">'
			+ '<input type="hidden" id="replyUserId" name="replyUserId" value="' + data[i].replies[r].replyUserId + '">'
			+ '<div style="float:left">'
				+ '<span id="indi">  <img src="${path}/upload/userProfileImg/' + data[i].replies[r].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span>'
			+ '</div>'

			+ '<div style="margin-top:10px;font-size:15px; margin-bottom:40px">'
				+ '<span id="indi">' + data[i].replies[r].userName + '</span>'
				+ '<span class="date "id="indi">' + data[i].replies[r].replyCreateDate + '</span>'
   
				+ '<c:if test="${loginMember.user_id == ' + data[i].replies[r].replyUserId + '}">'
					+ '<span id="update"><b><a href="#opModal_' + data[i].replies[r].replyNo + '">수정</a></b></span>'
                    + '<span id="delete"><b><a href="${path}/freeBoard/deleteReply?replyNo=' + data[i].replies[r].replyNo + '">삭제</a></b></span>'
				+ '</c:if>'
       		+ '</div>'
     
     		+ '<div id="replycontent" style=" margin:20px; margin-left:60px">' + data[i].replies[r].replyContent + '</div>'                              
			+ '<hr></hr>'
    	+ '</c:if>'

+ '</div>'


+ '<div id="opModal_' + data[i].replies[r].replyNo + '" class="modal">'
	+ '<input type="hidden" id="replyNo" name="replyNo" value="' + data[i].replies[r].replyNo + '">'
	+ '<span id="indi">  <img src="${path}/upload/userProfileImg/' + data[i].replies[r].memberImage + '" width="40px" height="40px" style="border-radius: 20px;"></span>'
	+ '<span id="indi">' + data[i].replies[r].userName + '</span>'
	
	+ '<p></p>'
	+ '<textarea name="newReplyContent"id="newReplyContent(' + data[i].replies[r].replyNo + ')" style="width:320px; height:70px; margin:20px; margin-left:23px">' + data[i].replies[r].replyContent + '</textarea>'
	+ '<span id="replyUpdate" style="float:right; margin-top:40px; margin-right:13px"><b><button type="submit" onclick="replyUpdate(' + data[i].replies[r].replyNo + ')">등록</button></b></span>'
+ '</div>'

+ '<script>'
+ 	"$('a[href="#opModal_' + data[i].replies[r].replyNo + '"]').click(function(event) {"
+ 	'$(this).modal({'
+ 		'fadeDuration: 450'
+  	'});'
+ '});'
+ '</script>'