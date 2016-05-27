// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.disid.restful.config;

import com.disid.restful.config.WebMvcConfiguration;
import com.disid.restful.service.api.CategoryService;
import com.disid.restful.service.api.CustomerOrderService;
import com.disid.restful.service.api.CustomerService;
import com.disid.restful.service.api.OrderDetailService;
import com.disid.restful.service.api.ProductService;
import com.disid.restful.web.CategoryFormatter;
import com.disid.restful.web.CustomerFormatter;
import com.disid.restful.web.CustomerOrderFormatter;
import com.disid.restful.web.OrderDetailFormatter;
import com.disid.restful.web.ProductFormatter;
import com.disid.restful.web.method.support.GlobalSearchHandlerMethodArgumentResolver;
import java.lang.Override;
import java.util.List;
import java.util.Locale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.format.FormatterRegistry;
import org.springframework.format.support.FormattingConversionService;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

privileged aspect WebMvcConfiguration_Roo_WebMvcConfiguration {
    
    declare parents: WebMvcConfiguration extends WebMvcConfigurerAdapter;
    
    declare @type: WebMvcConfiguration: @Configuration;
    
    @Autowired
    private CategoryService WebMvcConfiguration.categoryService;
    
    @Autowired
    private CustomerService WebMvcConfiguration.customerService;
    
    @Autowired
    private CustomerOrderService WebMvcConfiguration.customerOrderService;
    
    @Autowired
    private OrderDetailService WebMvcConfiguration.orderDetailService;
    
    @Autowired
    private ProductService WebMvcConfiguration.productService;
    
    @Primary
    @Bean
    public LocalValidatorFactoryBean WebMvcConfiguration.validator() {
        return new LocalValidatorFactoryBean();
    }
    
    @Override
    public void WebMvcConfiguration.addFormatters(FormatterRegistry registry) {
        if (!(registry instanceof FormattingConversionService)) {
            return;
        }
        FormattingConversionService conversionService = (FormattingConversionService) registry;
        
        // Entity Formatters
        conversionService.addFormatter(new CategoryFormatter(categoryService, conversionService));
        conversionService.addFormatter(new CustomerFormatter(customerService, conversionService));
        conversionService.addFormatter(new CustomerOrderFormatter(customerOrderService, conversionService));
        conversionService.addFormatter(new OrderDetailFormatter(orderDetailService, conversionService));
        conversionService.addFormatter(new ProductFormatter(productService, conversionService));
    }
    
    @Bean
    public LocaleResolver WebMvcConfiguration.localeResolver() {
        SessionLocaleResolver localeResolver = new SessionLocaleResolver();
        localeResolver.setDefaultLocale(Locale.ENGLISH);
        return localeResolver;
    }
    
    @Bean
    public LocaleChangeInterceptor WebMvcConfiguration.localeChangeInterceptor() {
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("lang");
        return localeChangeInterceptor;
    }
    
    @Override
    public void WebMvcConfiguration.addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor());
    }
    
    @Override
    public void WebMvcConfiguration.addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        argumentResolvers.add(globalSearchResolver());
    }
    
    public GlobalSearchHandlerMethodArgumentResolver WebMvcConfiguration.globalSearchResolver() {
        return new GlobalSearchHandlerMethodArgumentResolver();
    }
    
}
