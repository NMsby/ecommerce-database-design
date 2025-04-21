# Table Attributes with Data Types

## brand
- brand_id INT (Primary Key, Auto Increment)
- name VARCHAR(100) NOT NULL
- description TEXT
- logo_url VARCHAR(255)
- website VARCHAR(255)
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## product_category
- category_id INT (Primary Key, Auto Increment)
- parent_category_id INT (Foreign Key to product_category, can be NULL for top-level categories)
- name VARCHAR(100) NOT NULL
- description TEXT
- image_url VARCHAR(255)
- active BOOLEAN DEFAULT TRUE
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## product
- product_id INT (Primary Key, Auto Increment)
- category_id INT (Foreign Key to product_category)
- brand_id INT (Foreign Key to brand)
- name VARCHAR(100) NOT NULL
- description TEXT
- base_price DECIMAL(10,2) NOT NULL
- sku_prefix VARCHAR(20)
- active BOOLEAN DEFAULT TRUE
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## color
- color_id INT (Primary Key, Auto Increment)
- name VARCHAR(50) NOT NULL
- hex_code VARCHAR(7)
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## size_category
- size_category_id INT (Primary Key, Auto Increment)
- name VARCHAR(50) NOT NULL (e.g., "Clothing", "Shoes", "Accessories")
- description TEXT
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## size_option
- size_option_id INT (Primary Key, Auto Increment)
- size_category_id INT (Foreign Key to size_category)
- name VARCHAR(20) NOT NULL (e.g., "S", "M", "L", "42", "10.5")
- display_order INT
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## product_item
- product_item_id INT (Primary Key, Auto Increment)
- product_id INT (Foreign Key to product)
- size_option_id INT (Foreign Key to size_option, can be NULL)
- color_id INT (Foreign Key to color, can be NULL)
- sku VARCHAR(50) NOT NULL UNIQUE
- qty_in_stock INT DEFAULT 0
- price DECIMAL(10,2) (NULL if same as base_price, otherwise overrides product.base_price)
- weight DECIMAL(8,2) (in kg)
- active BOOLEAN DEFAULT TRUE
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## product_image
- image_id INT (Primary Key, Auto Increment)
- product_item_id INT (Foreign Key to product_item)
- image_url VARCHAR(255) NOT NULL
- alt_text VARCHAR(255)
- display_order INT DEFAULT 0
- is_thumbnail BOOLEAN DEFAULT FALSE
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## attribute_category
- attribute_category_id INT (Primary Key, Auto Increment)
- name VARCHAR(50) NOT NULL (e.g., "Physical", "Technical", "Performance")
- description TEXT
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## attribute_type
- attribute_type_id INT (Primary Key, Auto Increment)
- name VARCHAR(50) NOT NULL (e.g., "Text", "Number", "Boolean")
- description TEXT
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## product_attribute
- product_attribute_id INT (Primary Key, Auto Increment)
- attribute_category_id INT (Foreign Key to attribute_category)
- attribute_type_id INT (Foreign Key to attribute_type)
- name VARCHAR(100) NOT NULL (e.g., "Material", "Weight", "Waterproof")
- description TEXT
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## product_attribute_value (Junction table for product and product_attribute)
- product_attribute_value_id INT (Primary Key, Auto Increment)
- product_id INT (Foreign Key to product)
- product_attribute_id INT (Foreign Key to product_attribute)
- value TEXT NOT NULL
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

## product_variation
- product_variation_id INT (Primary Key, Auto Increment)
- product_id INT (Foreign Key to product)
- variation_name VARCHAR(100) NOT NULL (e.g., "Size", "Color", "Material")
- created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP