# Table Requirements Analysis

1. **product_image**: Stores product image URLs or file references
   - Purpose: Manages multiple images for each product item

2. **color**: Manages available color options
   - Purpose: Acts as a lookup table for colors available across products

3. **product_category**: Classifies products into categories
   - Purpose: Organizes products into hierarchical categories (e.g., clothing, electronics)

4. **product**: Stores general product details
   - Purpose: Contains base product information like name, brand, base price

5. **product_item**: Represents purchasable items with specific variations
   - Purpose: Represents the actual items that can be purchased with specific variations (color, size)

6. **brand**: Stores brand-related data
   - Purpose: Contains information about product manufacturers/brands

7. **product_variation**: Links a product to its variations
   - Purpose: Connects products with their variation options (e.g., size, color)

8. **size_category**: Groups sizes into categories
   - Purpose: Categorizes sizes into logical groups (e.g., clothing sizes, shoe sizes)

9. **size_option**: Lists specific sizes
   - Purpose: Contains specific size values (e.g., S, M, L, 42)

10. **product_attribute**: Stores custom attributes
    - Purpose: Holds additional product specifications (e.g., material, weight)

11. **attribute_category**: Groups attributes into categories
    - Purpose: Organizes attributes into logical groups (e.g., physical, technical)

12. **attribute_type**: Defines types of attributes
    - Purpose: Specifies the data type of attributes (e.g., text, number, boolean)