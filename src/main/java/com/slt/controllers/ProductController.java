package com.slt.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.slt.dao.IProductDao;
import com.slt.model.Category;
import com.slt.model.Category1;
import com.slt.model.Product;
import com.slt.model.Subcategory;
import com.slt.services.IProductService;


@Controller
public class ProductController {

	@Autowired
	private IProductService productService;

	@Autowired
	private IProductDao productDao;

	
	public ProductController(){
		System.out.println("ProductController bean is created");
	}

	//http://localhost:8080/project1frontend/all/getproducts 
	/**
	 * @return
	 */
	@RequestMapping(value="/all/getproducts")
	public ModelAndView getAllProducts(){
		List<Product> products=productService.getAllProducts();
		//1st parameter - logical view name - productlist
		//2nd parameter - model attribute name - refer it in jsp page
		//3rd parameter - model [data] list of products
		// /WEB-INF/views/productlist.jsp
		return new ModelAndView("productlist","productsAttr",products);
	}
	
	@RequestMapping(value="/all/productGrid")
	public ModelAndView getAllProduct(){
		List<Product> products=productService.getAllProducts();
		//1st parameter - logical view name - productlist
		//2nd parameter - model attribute name - refer it in jsp page
		//3rd parameter - model [data] list of products
		// /WEB-INF/views/productlist.jsp
		return new ModelAndView("productlist2","product",products);
	}
	

	@RequestMapping(value="/all/productg")
	public String getAllProd(){
		List<Product> products=productService.getAllProducts();
		//1st parameter - logical view name - productlist
		//2nd parameter - model attribute name - refer it in jsp page
		//3rd parameter - model [data] list of products
		// /WEB-INF/views/productlist.jsp
		return "productlist2";
	}
	
	
	
	/**
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/all/getproduct/{id}")  //id is pathvariable  id=1, id=2, id=3
	//  all/getproduct/1  , all/getproduct/2 , all/getproduct/3...
	public ModelAndView getProduct(@PathVariable int id){//id =1, 2, 3 
		//Pass this id to Service -> Service has to pass the id to Dao -> select * from product where id=1
		System.out.println("Product Id is " + id);
		Product product=productService.getProduct(id);
		System.out.println("Product is " + product );
		return new ModelAndView("productdetails","product",product);
		// 1st parameter productdetails - view name - jsp filename
		//2nd parameter product  - model attribute - in jsp page to display the data
		//3rd parameter product - model -data [1 1000.0 Product Description for toy car Toy Car 12]
		//product = [1 1000.0 Product Description for toy car Toy Car 12]
	}

	/**
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/admin/deleteproduct/{id}")
	public String deleteProduct(@PathVariable int id, HttpServletRequest request) {
		productService.deleteProduct(id);

		String root = request.getServletContext().getRealPath("/");
		System.out.println(root);
		Path path = Paths.get(root+"/WEB-INF/resources/images/"+id+".png");

		if(Files.exists(path)){
			try {
				Files.delete(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return "redirect:/all/getproducts";
	}

	/**
	 * @return
	 */
	/*@RequestMapping(value="/admin/getproductform")
	public ModelAndView getProductForm(){
		//two modal attributes
		// product and  categories
		List<Category> categories = productService.getCategories();
		return new ModelAndView("productform","product",new Product());
	}*/

	@RequestMapping(value="/admin/getproductform")
	public String getProductForm(Model model){
		//two modal attributes
		// product and  categories
		List<Category> categories = productService.getCategories();
		List<Category1> categories1 = productDao.getCategory();
		List<Subcategory> subcategory = productDao.getSubcategory();
		model.addAttribute("product", new Product());
		model.addAttribute("categories", categories);
		model.addAttribute("categories1", categories1);
		model.addAttribute("subcategory", subcategory);
		return "productform2";
	}

	/**
	 * Add Product form.
	 * Product is the value entered by the user in the form.
	 * If error redirect the user to the same page.
	 * min- price and quantity
	 * not empty - name and description
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/admin/updateproductform/{id}")
	public String getUpdateProductForm(@PathVariable int id, Model model){
		Product product=productService.getProduct(id);
		List<Category> categories = productService.getCategories();
		model.addAttribute("product", product);
		model.addAttribute("categories", categories);
		return "updateproductform";
	}


	/**
	 * @param product
	 * @return
	 */
	@RequestMapping(value="/admin/saveproduct")
	public String saveProduct(@Valid @ModelAttribute(name="product") Product product, BindingResult result, Model model,
			HttpServletRequest request)
	{
		if(result.hasErrors()){
			model.addAttribute("categories", productService.getCategories());
			return "productform";
		}
		System.out.println("New Product Details " + product);

		productService.saveProduct(product);

		MultipartFile productImage = product.getImage();
		if(productImage != null && !productImage.isEmpty()){
			// how to get root director
			String root = request.getServletContext().getRealPath("/");
			System.out.println(root);
			Path path = Paths.get(root+"/WEB-INF/resources/images/"+product.getId()+".png");

			try{
				productImage.transferTo(new File(path.toString()));
			}catch(Exception ex ){
				System.out.println("image is not uploaded");
			}
		}
		return "redirect:/all/getproducts";
	}

	/**
	 * @param product
	 * @return
	 */
	@RequestMapping(value="/admin/updateproduct")
	public String updateProduct(@Valid @ModelAttribute(name="product") Product product, BindingResult result, Model model, HttpServletRequest request){
		if(result.hasErrors()){
			model.addAttribute("categories", productService.getCategories());
			return "updateproductform";
		}
		System.out.println("New Product Details " + product);
		productService.updateProduct(product);
		MultipartFile productImage = product.getImage();
		if(productImage != null && !productImage.isEmpty()){
			// how to get root director
			String root = request.getServletContext().getRealPath("/");
			System.out.println(root);
			Path path = Paths.get(root+"/WEB-INF/resources/images/"+product.getId()+".png");

			try{
				productImage.transferTo(new File(path.toString()));
			}catch(Exception ex ){
				System.out.println("image is not uploaded");
			}
		}
		return "redirect:/all/getproducts";
	}
	
	@RequestMapping(value="/all/searchByCategory")
	public String searchByCategory(@RequestParam String searchCondition,Model model){
		if(searchCondition.equals("All")){
			model.addAttribute("searchCondition","");
		}
		else{
		model.addAttribute("searchCondition",searchCondition);
		}
		List<Product> products=productService.getAllProducts();
		model.addAttribute("productsAttr",products);
		return "productlist";
	}
}