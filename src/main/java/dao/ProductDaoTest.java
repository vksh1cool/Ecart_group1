package dao;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;
import bean.Product;
import dao.ProductDao;

import java.util.List;

public class ProductDaoTest {

    private ProductDao productDao;

    @Before
    public void setUp() {
        productDao = new ProductDao();
    }

    @Test
    public void testAddProduct() throws ClassNotFoundException {
        Product product = new Product();
        product.setProductId(1);
        product.setProductName("Test Product");
        product.setProductPrice(100.0f);
        product.setProductCategory("Test Category");
        product.setProductDescription("test product");

        boolean result = productDao.addProduct(product);
        assertTrue("Product should be added successfully", result);

        // Optionally, you can check if the product was really added
        List<Product> products = productDao.getAllProduct();
        assertTrue("Product list should contain the added product", products.stream()
                .anyMatch(p -> p.getProductId() == 1));
    }

    @Test
    public void testGetAllProducts() throws ClassNotFoundException {
        List<Product> products = productDao.getAllProduct();
        assertNotNull("Product list should not be null", products);
        assertTrue("Product list should not be empty", products.size() > 0);
    }

//    @Test
//    public void testDeleteProduct() throws ClassNotFoundException {
//        // First add a product to delete
//        Product product = new Product();
//        product.setProductId(2);
//        product.setProductName("Delete Test Product");
//        product.setProductPrice(50.0f);
//        product.setProductCategory("Delete Category");
//        product.setProductDescription("This product will be deleted.");
//
//        productDao.addProduct(product);
//
//        // Ensure the product was added
//        List<Product> productsBeforeDelete = productDao.getAllProduct();
//        assertTrue("Product list should contain the product before deletion", 
//                productsBeforeDelete.stream().anyMatch(p -> p.getProductId() == 2));
//
//        // Now delete the product
////        productDao.deleteProduct(2);
//
//        // Check that the product has been deleted
//        List<Product> productsAfterDelete = productDao.getAllProduct();
//        assertFalse("Product list should not contain the product after deletion", 
//                productsAfterDelete.stream().anyMatch(p -> p.getProductId() == 2));
//    }
}
