-- Add indexes for performance optimization

-- Indexes for product table
CREATE INDEX idx_product_name ON product(name);
CREATE INDEX idx_product_active ON product(active);
CREATE INDEX idx_product_category ON product(category_id);
CREATE INDEX idx_product_brand ON product(brand_id);

-- Indexes for product_item table
CREATE INDEX idx_product_item_sku ON product_item(sku);
CREATE INDEX idx_product_item_active ON product_item(active);
CREATE INDEX idx_product_item_product ON product_item(product_id);
CREATE INDEX idx_product_item_color ON product_item(color_id);
CREATE INDEX idx_product_item_size ON product_item(size_option_id);

-- Indexes for product_category table
CREATE INDEX idx_category_parent ON product_category(parent_category_id);
CREATE INDEX idx_category_active ON product_category(active);
CREATE INDEX idx_category_name ON product_category(name);

-- Indexes for product_image table
CREATE INDEX idx_image_product_item ON product_image(product_item_id);
CREATE INDEX idx_image_display_order ON product_image(display_order);
CREATE INDEX idx_image_thumbnail ON product_image(is_thumbnail);

-- Indexes for size_option table
CREATE INDEX idx_size_option_category ON size_option(size_category_id);
CREATE INDEX idx_size_option_display ON size_option(display_order);

-- Indexes for product_attribute table
CREATE INDEX idx_attribute_category ON product_attribute(attribute_category_id);
CREATE INDEX idx_attribute_type ON product_attribute(attribute_type_id);
CREATE INDEX idx_attribute_name ON product_attribute(name);

-- Indexes for product_attribute_value table
CREATE INDEX idx_attribute_value_product ON product_attribute_value(product_id);
CREATE INDEX idx_attribute_value_attribute ON product_attribute_value(product_attribute_id);

-- Indexes for product_variation table
CREATE INDEX idx_variation_product ON product_variation(product_id);
CREATE INDEX idx_variation_name ON product_variation(variation_name);

-- Indexes for brand table
CREATE INDEX idx_brand_name ON brand(name);

-- Indexes for color table
CREATE INDEX idx_color_name ON color(name);

-- Indexes for size_category table
CREATE INDEX idx_size_category_name ON size_category(name);

-- Indexes for attribute_category table
CREATE INDEX idx_attribute_category_name ON attribute_category(name);

-- Indexes for attribute_type table
CREATE INDEX idx_attribute_type_name ON attribute_type(name);