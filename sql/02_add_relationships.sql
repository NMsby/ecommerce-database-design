-- Add foreign key constraints to establish relationships

-- Self-reference in product_category (parent-child relationship)
ALTER TABLE product_category
ADD CONSTRAINT fk_category_parent
FOREIGN KEY (parent_category_id) REFERENCES product_category(category_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- Product relationships
ALTER TABLE product
ADD CONSTRAINT fk_product_category
FOREIGN KEY (category_id) REFERENCES product_category(category_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE product
ADD CONSTRAINT fk_product_brand
FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Product item relationships
ALTER TABLE product_item
ADD CONSTRAINT fk_product_item_product
FOREIGN KEY (product_id) REFERENCES product(product_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE product_item
ADD CONSTRAINT fk_product_item_size
FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE product_item
ADD CONSTRAINT fk_product_item_color
FOREIGN KEY (color_id) REFERENCES color(color_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Product image relationship
ALTER TABLE product_image
ADD CONSTRAINT fk_image_product_item
FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Size option relationship
ALTER TABLE size_option
ADD CONSTRAINT fk_size_option_category
FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Product attribute relationships
ALTER TABLE product_attribute
ADD CONSTRAINT fk_product_attribute_category
FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE product_attribute
ADD CONSTRAINT fk_product_attribute_type
FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Product attribute value relationships (junction table)
ALTER TABLE product_attribute_value
ADD CONSTRAINT fk_attribute_value_product
FOREIGN KEY (product_id) REFERENCES product(product_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE product_attribute_value
ADD CONSTRAINT fk_attribute_value_attribute
FOREIGN KEY (product_attribute_id) REFERENCES product_attribute(product_attribute_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Product variation relationship
ALTER TABLE product_variation
ADD CONSTRAINT fk_variation_product
FOREIGN KEY (product_id) REFERENCES product(product_id)
ON DELETE CASCADE
ON UPDATE CASCADE;