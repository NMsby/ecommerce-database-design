# Entity Relationship Definitions

1. **brand** to **product**:
   - One brand can have many products
   - Each product belongs to one brand
   - Relationship type: 1 Mandatory to Many Optional (1:N)

2. **product_category** to **product**:
   - One category can contain many products
   - Each product belongs to one category
   - Relationship type: 1 Mandatory to Many Optional (1:N)

3. **product** to **product_item**:
   - One product can have many product items (variations)
   - Each product item belongs to one product
   - Relationship type: 1 Mandatory to Many Mandatory (1:N)

4. **product_item** to **product_image**:
   - One product item can have multiple images
   - Each image belongs to one product item
   - Relationship type: 1 Mandatory to Many Optional (1:N)

5. **color** to **product_item**:
   - One color can be used by many product items
   - Each product item may have one color
   - Relationship type: 1 Optional to Many Optional (1:N)

6. **size_category** to **size_option**:
   - One size category can have many size options
   - Each size option belongs to one size category
   - Relationship type: 1 Mandatory to Many Mandatory (1:N)

7. **size_option** to **product_item**:
   - One size option can be used by many product items
   - Each product item may have one size option
   - Relationship type: 1 Optional to Many Optional (1:N)

8. **attribute_category** to **product_attribute**:
   - One attribute category can have many product attributes
   - Each product attribute belongs to one category
   - Relationship type: 1 Mandatory to Many Mandatory (1:N)

9. **attribute_type** to **product_attribute**:
   - One attribute type can be used by many product attributes
   - Each product attribute has one attribute type
   - Relationship type: 1 Mandatory to Many Mandatory (1:N)

10. **product_attribute** to **product**:
    - One product attribute can be associated with many products
    - One product can have many attributes
    - Relationship type: Many Optional to Many Optional (M:N)
    - Note: This will require a junction table in implementation

11. **product** to **product_variation**:
    - One product can have many variation options
    - Each variation option belongs to one product
    - Relationship type: 1 Mandatory to Many Optional (1:N)

12. **product_category** to itself (self-referencing):
    - One category can have many subcategories
    - Each subcategory has one parent category
    - Relationship type: Recursive relationship (0:N)