package com.disid.restful.web.customerorder.html;

import com.disid.restful.model.CustomerOrder;
import com.disid.restful.service.api.CustomerOrderService;
import com.disid.restful.service.api.CustomerService;

import io.springlets.data.domain.GlobalSearch;
import io.springlets.data.web.datatables.Datatables;
import io.springlets.data.web.datatables.DatatablesData;
import io.springlets.data.web.datatables.DatatablesPageable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.util.UriComponents;

import javax.validation.Valid;

@Controller
@RequestMapping(value = "/customerorders", produces = MediaType.TEXT_HTML_VALUE)
public class CustomerOrdersCollectionThymeleafController {

  public CustomerOrderService customerOrderService;
  public CustomerService customerService;

  @Autowired
  public CustomerOrdersCollectionThymeleafController(CustomerOrderService customerOrderService,
      CustomerService customerService) {
    this.customerOrderService = customerOrderService;
    this.customerService = customerService;
  }

  @RequestMapping(value = "/create-form", method = RequestMethod.GET,
      produces = MediaType.TEXT_HTML_VALUE)
  public ModelAndView createForm(Model model) {
    model.addAttribute(new CustomerOrder());
    return new ModelAndView("customerorders/create");
  }

  @RequestMapping(method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE)
  public ModelAndView create(@Valid @ModelAttribute CustomerOrder customerOrder,
      BindingResult result, Model model) {
    if (result.hasErrors()) {
      return new ModelAndView("customerorders/create");
    }
    CustomerOrder newCustomerOrder = customerOrderService.save(customerOrder);
    UriComponents showURI = CustomerOrdersItemThymeleafController.showURI(newCustomerOrder);
    return new ModelAndView("redirect:" + showURI.toUriString());
  }

  @RequestMapping(method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
  public ModelAndView list(Model model) {
    return new ModelAndView("customerorders/list");
  }

  public static UriComponents listURI() {
    return MvcUriComponentsBuilder
        .fromMethodCall(MvcUriComponentsBuilder
            .on(CustomerOrdersCollectionThymeleafController.class).list(null))
        .build().encode();
  }

  @RequestMapping(method = RequestMethod.GET, produces = "application/vnd.datatables+json")
  @ResponseBody
  public DatatablesData<CustomerOrder> list(GlobalSearch search, DatatablesPageable pageable,
      @RequestParam(Datatables.PARAMETER_DRAW) Integer draw) {
    Page<CustomerOrder> customerOrders = customerOrderService.findAll(search, pageable);
    long allAvailableCustomerOrders = customerOrderService.count();
    return new DatatablesData<CustomerOrder>(customerOrders, allAvailableCustomerOrders, draw);
  }

}
