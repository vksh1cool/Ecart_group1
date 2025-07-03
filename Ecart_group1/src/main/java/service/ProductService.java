package service;

import java.util.ArrayList;

import bean.Product;
import dao.ProductDao;

public class ProductService {
	private ProductDao productDAO = new ProductDao();

    public boolean addProduct(Product product) {
    	 
       return productDAO.addProduct(product);
       
    }
    
    public ArrayList<Product> getAllProducts() {
    	try {
			return ProductDao.getAllProduct();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
    
    public boolean updateProduct(Product product) {
    	return productDAO.updateProduct(product);
    }
}
