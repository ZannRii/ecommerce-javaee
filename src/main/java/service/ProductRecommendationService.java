package service;

import java.util.List;

import dao.ProductDao;
import model.Product;

public class ProductRecommendationService {

	private ProductDao productDao;

	public ProductRecommendationService() {
		productDao = new ProductDao();
	}

	public String recommendProducts() throws Exception {

		List<Product> products = productDao.getTopProducts();

		StringBuilder result = new StringBuilder();

		result.append("Recommended products:\n");

		for (Product p : products) {

			result.append("- ").append(p.getName()).append("\n");
		}

		return result.toString();
	}
}