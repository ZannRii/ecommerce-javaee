package service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import dao.ProductDao;
import model.Product;

public class ProductSearchService {

	private ProductDao productDao;

	public ProductSearchService() {
		productDao = new ProductDao();
	}

	public String searchProducts(String message) {
		String keyword = extractKeyword(message);

		if (keyword.isEmpty()) {
			return "Please tell me the product name you want to search.";
		}

		if (keyword.length() < 2) {
			return "Please type at least 2 characters for product search.";
		}

		try {
			List<Product> products = productDao.searchProducts(keyword);

			if (products.isEmpty()) {
				return "No products found.";
			}

			StringBuilder result = new StringBuilder();
			result.append("Products found:\n\n");

			for (Product p : products) {
				result.append("- ").append(p.getName()).append(" ($").append(p.getPrice()).append(")\n");
			}

			return result.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "Something went wrong.";
		}
	}

	public boolean hasMatches(String message) {
		String keyword = extractKeyword(message);
		return keyword.length() >= 2 && !productDao.searchProducts(keyword).isEmpty();
	}

	private String extractKeyword(String message) {
		if (message == null) {
			return "";
		}

		Set<String> stopWords = new HashSet<>(Arrays.asList("show", "find", "search", "me", "can", "you",
				"please", "some", "i", "want", "need", "a", "an", "the", "product", "products", "for", "do",
				"have", "has", "any", "is", "are", "there", "available", "availability", "stock", "in", "of"));

		return Arrays.stream(message.toLowerCase().replaceAll("[^a-z0-9 ]", " ").split("\\s+"))
				.filter(word -> !word.isEmpty())
				.filter(word -> !stopWords.contains(word))
				.collect(Collectors.joining(" "))
				.trim();
	}
}
