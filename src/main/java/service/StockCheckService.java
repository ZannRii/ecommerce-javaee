package service;

import dao.ProductDao;
import model.Product;

public class StockCheckService {

	private ProductDao productDao;

	public StockCheckService() {
		productDao = new ProductDao();
	}

	public String checkStock(String productName) throws Exception {

		Product product = productDao.findByName(productName);

		if (product == null) {
			return "Product not found.";
		}

		return product.getName() + " has " + product.getStockQuantity() + " items in stock.";
	}
}