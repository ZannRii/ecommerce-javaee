function sendMessage() {
	let input = document.getElementById("message");
	let message = input.value.trim();

	if (message === "") {
		return;
	}

	addMessage(message, "user");
	input.value = "";

	fetch("chatbot", {
		method: "POST",
		headers: {
			"Content-Type": "text/plain"
		},
		body: message
	})
		.then(response => response.json())
		.then(data => {
			addMessage(data.response, "bot");
		})
		.catch(error => {
			addMessage("Server error. Please try again.", "bot");
		});
}

function addMessage(message, sender) {
	let chatBox = document.getElementById("chatBox");
	let div = document.createElement("div");
	let safeMessage = escapeHtml(message).replace(/\n/g, "<br>");

	div.className = "mb-3";

	if (sender === "user") {
		div.innerHTML = `
			<div class="text-end">
				<div class="alert alert-primary d-inline-block text-start">
					${safeMessage}
				</div>
			</div>
		`;
	} else {
		div.innerHTML = `
			<div class="text-start">
				<div class="alert alert-secondary d-inline-block">
					${safeMessage}
				</div>
			</div>
		`;
	}

	chatBox.appendChild(div);
	chatBox.scrollTop = chatBox.scrollHeight;
}

function escapeHtml(value) {
	return String(value)
		.replace(/&/g, "&amp;")
		.replace(/</g, "&lt;")
		.replace(/>/g, "&gt;")
		.replace(/"/g, "&quot;")
		.replace(/'/g, "&#039;");
}
