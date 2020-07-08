package com.slt.controllers;
	
import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.slt.model.CartItem;
import com.slt.model.Customer;
import com.slt.model.CustomerOrder;
import com.slt.model.Product;
import com.slt.model.ShippingAddress;
import com.slt.model.User;
import com.slt.services.ICartItemService;
import com.slt.services.IProductService;

@Controller
public class CartItemController {

	@Autowired
	private ICartItemService cartItemService;

	@Autowired
	private IProductService productService;
	
	@RequestMapping(value="/cart/addtocart/{id}")
	public String addToCart(@PathVariable int id,@AuthenticationPrincipal Principal principal,
			@RequestParam int requestedQuantity){
		String email=principal.getName(); //return the email id of the logged in user
		User user=cartItemService.getUser(email);
		Product product=productService.getProduct(id);
		List<CartItem> cartItems=user.getCartItems();
		//if the selected product already exists in the cartitem table, only update the quantity
		//New cartITem object need not be created.
		for(CartItem cartItem:cartItems){//for(Type localvariable:collection)
			if(cartItem.getProduct().getId()==id){
				cartItem.setQuantity(requestedQuantity);
				cartItem.setTotalPrice(requestedQuantity * product.getPrice());
				cartItemService.saveOrUpdateCartItem(cartItem);//update
				return "redirect:/cart/purchasedetails";
			}
		}

		CartItem cartItem=new CartItem();
		cartItem.setQuantity(requestedQuantity);
		cartItem.setTotalPrice(requestedQuantity * product.getPrice());
		cartItem.setUser(user);//FK user_email
		cartItem.setProduct(product);//FK column product_id
		cartItemService.saveOrUpdateCartItem(cartItem);
		return "redirect:/cart/purchasedetails";
	}

	
	@RequestMapping(value="/cart/addFromList/{id}")
	public String addToCartFromGrid(@PathVariable int id,@AuthenticationPrincipal Principal principal){
		String email=principal.getName(); //return the email id of the logged in user
		User user=cartItemService.getUser(email);
		Product product=productService.getProduct(id);
		List<CartItem> cartItems=user.getCartItems();
		int requestedQuantity= 1;
		//if the selected product already exists in the cartitem table, only update the quantity
		//New cartITem object need not be created.
		for(CartItem cartItem:cartItems){//for(Type localvariable:collection)
			if(cartItem.getProduct().getId()==id){
				cartItem.setQuantity(requestedQuantity);
				cartItem.setTotalPrice(requestedQuantity * product.getPrice());
				cartItemService.saveOrUpdateCartItem(cartItem);//update
				return "redirect:/cart/purchasedetails";
			}
		}

		CartItem cartItem=new CartItem();
		cartItem.setQuantity(requestedQuantity);
		cartItem.setTotalPrice(requestedQuantity * product.getPrice());
		cartItem.setUser(user);//FK user_email
		cartItem.setProduct(product);//FK column product_id
		cartItemService.saveOrUpdateCartItem(cartItem);
		return "redirect:/cart/purchasedetails";
	}
	
	@RequestMapping(value="/cart/purchasedetails")
	public String getPurchaseDetails(@AuthenticationPrincipal Principal principal,Model model){
		String email=principal.getName();
		User user=cartItemService.getUser(email);
		List<CartItem> cartItems=user.getCartItems();//list of cartitems/products
		model.addAttribute("cartItems",cartItems);
		return "cart";
	}

	@RequestMapping(value="/cart/deletecartitem/{cartItemId}")
	public String removeCartItem(@PathVariable int cartItemId){
		cartItemService.removeCartItem(cartItemId);
		return "redirect:/cart/purchasedetails";
	}
	
	@RequestMapping(value="/cart/clearcart")
	public String clearCart(@AuthenticationPrincipal Principal principal){
		return "redirect:/cart/purchasedetails";
	}

	@RequestMapping(value="/cart/checkout")
	public String checkout(@AuthenticationPrincipal Principal principal,Model model){
		User user = cartItemService.getUser(principal.getName());
		ShippingAddress shipping = user.getCustomer().getShippingAddress();
		model.addAttribute("shippingAddress",shipping);
		return "shippingaddress";
	}

	@RequestMapping(value="/cart/createorder")
	public String createOrder(@AuthenticationPrincipal Principal principal ,
			@ModelAttribute ShippingAddress shippingaddress,
			Model model, HttpSession session){
		User user = cartItemService.getUser(principal.getName());
		Customer customer = user.getCustomer();
		customer.setShippingAddress(shippingaddress);
		user.setCustomer(customer);

		CustomerOrder order = cartItemService.createOrder(user);
		List<CartItem> cartItems = user.getCartItems();
		model.addAttribute("order", order);
		return "orderdetails";
	}
}