package com.slt.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.slt.model.Customer;
import com.slt.services.ICustomerService;

@Controller
public class CustomerController {

	@Autowired
	private ICustomerService customerService;

	@RequestMapping(value="/all/registrationForm")
	public ModelAndView  getRegistrationForm(){
		return new ModelAndView("registrationform", "customer", new Customer());
	}
	
	@RequestMapping(value="/all/regForm")
	public ModelAndView  getRegForm(){
		return new ModelAndView("registrationform", "customer", new Customer());
	}
	
	@RequestMapping(value="/all/registercustomer")
	public String registerCustomer(@ModelAttribute Customer customer){
		customerService.registerCustomer(customer);
		return "login";
	}
}