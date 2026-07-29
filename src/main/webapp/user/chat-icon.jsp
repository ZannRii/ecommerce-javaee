<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- start of the chatbot -->

<!-- Chatbot Button -->
<button onclick="openChat()"
	class="btn btn-warning rounded-circle shadow position-fixed"
	style="bottom: 30px; right: 30px; width: 60px; height: 60px; font-size: 25px; z-index: 10000;">

	<i class="bi bi-chat-dots-fill"></i>

</button>

<!-- Dark Overlay -->
<div id="overlay" onclick="closeChat()"
	style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.4); z-index: 9998;">
</div>

<!-- Include Chatbot -->
<jsp:include page="chat.jsp" />

<script>
	function openChat() {

		document.getElementById("chatModal").style.display = "block";
		document.getElementById("overlay").style.display = "block";

	}

	function closeChat() {

		document.getElementById("chatModal").style.display = "none";
		document.getElementById("overlay").style.display = "none";

	}
</script>
<!-- end  for chat bot -->