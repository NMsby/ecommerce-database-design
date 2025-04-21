-- E-commerce Database Schema: Consolidated Script
-- This script creates the entire e-commerce database structure including
-- tables, relationships, constraints, and indexes

-- =============================================
-- PART 1: CREATE TABLES
-- =============================================

-- Create brand table
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    logo_url VARCHAR(255),
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create product_category table with self-reference
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    parent_category_id INT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uc_category_name_parent UNIQUE (name, parent_category_id)
);

-- Create color table
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    hex_code VARCHAR(7),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_hex_code CHECK (hex_code REGEXP '^#[0-9A-Fa-f]{6}$')
);

-- Create size_category table
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create size_option table
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    display_order INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uc_size_category_name UNIQUE (size_category_id, name)
);

-- Create attribute_category table
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create attribute_type table
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create product table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    brand_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2) NOT NULL,
    sku_prefix VARCHAR(20),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_base_price CHECK (base_price > 0)
);

-- Create product_attribute table
CREATE TABLE product_attribute (
    product_attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_category_id INT NOT NULL,
    attribute_type_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uc_attribute_name_category UNIQUE (name, attribute_category_id)
);

-- Create product_variation table
CREATE TABLE product_variation (
    product_variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    variation_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uc_product_variation_name UNIQUE (product_id, variation_name)
);

-- Create product_item table
CREATE TABLE product_item (
    product_item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    size_option_id INT,
    color_id INT,
    sku VARCHAR(50) NOT NULL UNIQUE,
    qty_in_stock INT DEFAULT 0,
    price DECIMAL(10,2),
    weight DECIMAL(8,2),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_qty_in_stock CHECK (qty_in_stock >= 0),
    CONSTRAINT chk_price CHECK (price IS NULL OR price > 0)
);

-- Create product_image table
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    display_order INT DEFAULT 0,
    is_thumbnail BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create product_attribute_value junction table
CREATE TABLE product_attribute_value (
    product_attribute_value_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    product_attribute_id INT NOT NULL,
    value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uc_product_attribute UNIQUE (product_id, product_attribute_id)
);

-- =============================================
-- PART 2: ADD RELATIONSHIPS (FOREIGN KEYS)
-- =============================================

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

-- =============================================
-- PART 3: ADD INDEXES
-- =============================================

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