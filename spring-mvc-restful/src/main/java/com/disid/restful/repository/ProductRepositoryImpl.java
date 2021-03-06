package com.disid.restful.repository;

import com.disid.restful.model.Category;
import com.disid.restful.model.Product;
import com.disid.restful.model.QProduct;
import com.querydsl.jpa.JPQLQuery;

import io.springlets.data.domain.GlobalSearch;
import io.springlets.data.jpa.repository.support.QueryDslRepositorySupportExt;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
public class ProductRepositoryImpl extends QueryDslRepositorySupportExt<Product>
    implements ProductRepositoryCustom {

  ProductRepositoryImpl() {
    super(Product.class);
  }

  public Page<Product> findByCategoriesContains(Category category, GlobalSearch globalSearch,
      Pageable pageable) {
    QProduct product = QProduct.product;
    JPQLQuery<Product> query = from(product);
    if (category != null) {
      query.where(product.categories.contains(category));
    }
    applyGlobalSearch(globalSearch, query, product.name, product.description);
    applyPagination(pageable, query);
    applyOrderById(query);
    return loadPage(query, pageable, product);
  }

  public Page<Product> findAll(GlobalSearch globalSearch, Pageable pageable) {
    QProduct product = QProduct.product;
    JPQLQuery<Product> query = from(product);
    applyGlobalSearch(globalSearch, query, product.name, product.description);
    applyPagination(pageable, query);
    applyOrderById(query);
    return loadPage(query, pageable, product);
  }
}
