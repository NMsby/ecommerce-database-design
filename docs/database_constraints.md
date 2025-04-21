# Database Constraints

## Primary Key Constraints
- **brand**: `brand_id` as PRIMARY KEY
- **product_category**: `category_id` as PRIMARY KEY
- **product**: `product_id` as PRIMARY KEY
- **color**: `color_id` as PRIMARY KEY
- **size_category**: `size_category_id` as PRIMARY KEY
- **size_option**: `size_option_id` as PRIMARY KEY
- **product_item**: `product_item_id` as PRIMARY KEY
- **product_image**: `image_id` as PRIMARY KEY
- **attribute_category**: `attribute_category_id` as PRIMARY KEY
- **attribute_type**: `attribute_type_id` as PRIMARY KEY
- **product_attribute**: `product_attribute_id` as PRIMARY KEY
- **product_attribute_value**: `product_attribute_value_id` as PRIMARY KEY
- **product_variation**: `product_variation_id` as PRIMARY KEY

## Foreign Key Constraints
1. **product_category**:
   - `parent_category_id` REFERENCES `product_category(category_id)` (self-referencing)
   - ON DELETE: SET NULL (subcategories become top-level when parent is deleted)
   - ON UPDATE: CASCADE

2. **product**:
   - `category_id` REFERENCES `product_category(category_id)`
   - ON DELETE: RESTRICT (prevent category deletion if products exist)
   - ON UPDATE: CASCADE
   - `brand_id` REFERENCES `brand(brand_id)`
   - ON DELETE: RESTRICT (prevent brand deletion if products exist)
   - ON UPDATE: CASCADE

3. **product_item**:
   - `product_id` REFERENCES `product(product_id)`
   - ON DELETE: CASCADE (delete items when product is deleted)
   - ON UPDATE: CASCADE
   - `size_option_id` REFERENCES `size_option(size_option_id)`
   - ON DELETE: RESTRICT (prevent size deletion if product items exist)
   - ON UPDATE: CASCADE
   - `color_id` REFERENCES `color(color_id)`
   - ON DELETE: RESTRICT (prevent color deletion if product items exist)
   - ON UPDATE: CASCADE

4. **product_image**:
   - `product_item_id` REFERENCES `product_item(product_item_id)`
   - ON DELETE: CASCADE (delete images when product item is deleted)
   - ON UPDATE: CASCADE

5. **size_option**:
   - `size_category_id` REFERENCES `size_category(size_category_id)`
   - ON DELETE: RESTRICT (prevent category deletion if sizes exist)
   - ON UPDATE: CASCADE

6. **product_attribute**:
   - `attribute_category_id` REFERENCES `attribute_category(attribute_category_id)`
   - ON DELETE: RESTRICT (prevent category deletion if attributes exist)
   - ON UPDATE: CASCADE
   - `attribute_type_id` REFERENCES `attribute_type(attribute_type_id)`
   - ON DELETE: RESTRICT (prevent type deletion if attributes exist)
   - ON UPDATE: CASCADE

7. **product_attribute_value**:
   - `product_id` REFERENCES `product(product_id)`
   - ON DELETE: CASCADE (delete attribute values when product is deleted)
   - ON UPDATE: CASCADE
   - `product_attribute_id` REFERENCES `product_attribute(product_attribute_id)`
   - ON DELETE: CASCADE (delete attribute values when attribute is deleted)
   - ON UPDATE: CASCADE

8. **product_variation**:
   - `product_id` REFERENCES `product(product_id)`
   - ON DELETE: CASCADE (delete variations when product is deleted)
   - ON UPDATE: CASCADE

## Unique Constraints
1. **brand**: `name` should be UNIQUE
2. **product_category**: `name` should be UNIQUE within the same parent category
3. **color**: `name` should be UNIQUE
4. **product_item**: `sku` should be UNIQUE
5. **size_option**: Combination of `size_category_id` and `name` should be UNIQUE
6. **product_attribute**: `name` should be UNIQUE within the same attribute category
7. **product_variation**: Combination of `product_id` and `variation_name` should be UNIQUE

## Not Null Constraints
All fields marked with NOT NULL in the attributes definition, including:
- All table names
- All required foreign keys
- Critical data like prices, SKUs, etc.

## Default Values
1. **product_item**: `qty_in_stock` defaults to 0
2. **product_item** and **product**: `active` defaults to TRUE
3. All timestamp fields default to current timestamp
4. **product_image**: `display_order` defaults to 0, `is_thumbnail` defaults to FALSE

## Check Constraints
1. **product** and **product_item**: `base_price` and `price` should be greater than 0
2. **product_item**: `qty_in_stock` should be greater than or equal to 0
3. **color**: `hex_code` should match hexadecimal pattern (e.g., '#RRGGBB')

## Indexes
1. Foreign key columns for performance
2. Frequently searched fields (e.g., product name, SKU)
3. Fields used in ordering or grouping