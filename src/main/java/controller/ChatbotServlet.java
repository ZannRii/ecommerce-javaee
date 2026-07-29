package controller;

import java.io.*;
import java.net.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONObject;

import service.OrderTrackingService;
import service.ProductSearchService;
import service.ProductRecommendationService;
import service.StockCheckService;

@WebServlet("/chatbot")
public class ChatbotServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

		BufferedReader reader = request.getReader();

		String message = reader.readLine();

		HttpSession session = request.getSession();

		String chatbotState = (String) session.getAttribute("chatbot_state");

		int userId = 5; // testing only

		/*
		 * ==================================== WAITING FOR ORDER TRACKING ID
		 * ====================================
		 */

		if ("WAITING_FOR_TRACK_ORDER_ID".equals(chatbotState) && message.matches("\\d+")) {

			int orderId = Integer.parseInt(message);

			OrderTrackingService service = new OrderTrackingService();

			String finalResponse = service.trackOrder(orderId, userId);

			session.removeAttribute("chatbot_state");

			JSONObject output = new JSONObject();

			output.put("response", finalResponse);

			response.setContentType("application/json");

			response.getWriter().print(output.toString());

			return;

		}

		/*
		 * ==================================== SEND MESSAGE TO FLASK ML MODEL
		 * ====================================
		 */

		JSONObject json = new JSONObject();

		json.put("message", message);

		URL url = new URL("http://127.0.0.1:5000/chat");

		HttpURLConnection con = (HttpURLConnection) url.openConnection();

		con.setRequestMethod("POST");

		con.setRequestProperty("Content-Type", "application/json");

		con.setDoOutput(true);

		OutputStream os = con.getOutputStream();

		os.write(json.toString().getBytes());

		os.flush();

		os.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));

		StringBuilder result = new StringBuilder();

		String line;

		while ((line = br.readLine()) != null) {

			result.append(line);

		}

		br.close();

		JSONObject flaskResponse = new JSONObject(result.toString());

		String intent = flaskResponse.getString("intent");

		String finalResponse = flaskResponse.getString("response");

		ProductSearchService productSearchService = new ProductSearchService();

		if (!"PRODUCT_SEARCH".equals(intent) && productSearchService.hasMatches(message)) {
			intent = "PRODUCT_SEARCH";
		}

		/*
		 * ==================================== INTENT ROUTING
		 * ====================================
		 */

		// ORDER TRACKING

		if ("ORDER_TRACKING".equals(intent)) {

			session.setAttribute("chatbot_state", "WAITING_FOR_TRACK_ORDER_ID");

		}

		// PRODUCT SEARCH

		else if ("PRODUCT_SEARCH".equals(intent)) {

			finalResponse = productSearchService.searchProducts(message);

		}

		// PRODUCT RECOMMENDATION

		else if ("PRODUCT_RECOMMENDATION".equals(intent)) {

			ProductRecommendationService service = new ProductRecommendationService();

			try {
				finalResponse = service.recommendProducts();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		// STOCK CHECK

		else if ("STOCK_CHECK".equals(intent)) {

			StockCheckService service = new StockCheckService();

			try {
				finalResponse = service.checkStock(message);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		/*
		 * ==================================== RETURN RESPONSE
		 * ====================================
		 */

		JSONObject output = new JSONObject();

		output.put("response", finalResponse);

		response.setContentType("application/json");

		response.getWriter().print(output.toString());

	}

}
