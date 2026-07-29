<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="chatModal" class="card shadow"
	style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 600px; z-index: 9999;">

	<div
		class="card-header bg-warning text-white d-flex justify-content-between align-items-center">

		<h5 class="mb-0">AI E-Commerce Assistant</h5>

		<button class="btn btn-sm btn-light" onclick="closeChat()">✕
		</button>

	</div>

	<div id="chatBox" class="card-body"
		style="height: 400px; overflow-y: auto;">

		<div class="mb-3">
			<div class="alert alert-secondary">
				Hello 👋 <br> How can I help you today?
			</div>
		</div>

	</div>

	<div class="card-footer">

		<div class="input-group">

			<input type="text" id="message" class="form-control"
				placeholder="Type your message..."
				onkeydown="if(event.key==='Enter'){sendMessage();}">

			<button class="btn btn-warning" onclick="sendMessage()">
				Send</button>

		</div>

	</div>

</div>

<script src="${pageContext.request.contextPath}/js/chatbot.js"></script>