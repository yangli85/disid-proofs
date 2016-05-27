// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.disid.restful.web;

import com.disid.restful.model.Category;
import com.disid.restful.model.Customer;
import com.disid.restful.model.CustomerOrder;
import com.disid.restful.model.OrderDetail;
import com.disid.restful.model.Product;
import com.disid.restful.web.CategoryController;
import java.lang.SuppressWarnings;
import java.net.URI;
import java.util.Collection;
import java.util.List;
import javax.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

privileged aspect CategoryController_Roo_JSON {
    
    @RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ResponseEntity CategoryController.create(@Valid @RequestBody Category category, BindingResult result) {
        
        if (category.getId() != null) {
            return new ResponseEntity(HttpStatus.CONFLICT);
        }
        
        if (result.hasErrors()) {
            return new ResponseEntity(result, HttpStatus.CONFLICT);
        }
        
        Category newCategory = categoryService.save(category);
        HttpHeaders responseHeaders = populateHeaders(newCategory.getId());
        
        return new ResponseEntity(newCategory, responseHeaders, HttpStatus.CREATED);
    }
    
    @RequestMapping(value = "/{category}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ResponseEntity CategoryController.update(@Valid @RequestBody Category category, BindingResult result) {
        
        if (result.hasErrors()) {
            return new ResponseEntity(result, HttpStatus.CONFLICT);
        }
        
        Category savedCategory = categoryService.save(category);
        
        return new ResponseEntity(savedCategory, HttpStatus.OK);
    }
    
    @RequestMapping(value = "/batch", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ResponseEntity CategoryController.createBatch(@Valid @RequestBody Collection<Category> categorys, BindingResult result) {
        
        if (result.hasErrors()) {
            return new ResponseEntity(result, HttpStatus.CONFLICT);
        }
        
        List<Category> newCategorys = categoryService.save(categorys);
        
        return new ResponseEntity(newCategorys, HttpStatus.CREATED);
    }
    
    @RequestMapping(value = "/batch", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ResponseEntity CategoryController.updateBatch(@Valid @RequestBody Collection<Category> categorys, BindingResult result) {
        
        if (result.hasErrors()) {
            return new ResponseEntity(result, HttpStatus.CONFLICT);
        }
        
        List<Category> savedCategorys = categoryService.save(categorys);
        
        return new ResponseEntity(savedCategorys, HttpStatus.OK);
    }
    
    @RequestMapping(value = "/batch/{ids}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @SuppressWarnings({ "rawtypes" })
    public ResponseEntity CategoryController.deleteBatch(@PathVariable("ids") Collection<Long> ids) {
        
        categoryService.delete(ids);
        
        return new ResponseEntity(HttpStatus.OK);
    }
    
    public HttpHeaders CategoryController.populateHeaders(Long id) {
        UriComponents uriComponents = UriComponentsBuilder.fromUriString("/categorys/{id}").build();
        URI uri = uriComponents.expand(id).encode().toUri();
        
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setLocation(uri);
        return responseHeaders;
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ResponseEntity CategoryController.show(@PathVariable("id") Long id) {
        
        Category category = categoryService.findOne(id);
        
        if (category == null) {
            return new ResponseEntity(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity(category, HttpStatus.FOUND);
    }
    
}
