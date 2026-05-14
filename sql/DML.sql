INSERT INTO dim_customer (first_name, last_name, age, email, country, postal_code)
SELECT DISTINCT
    NULLIF(customer_first_name, '') AS first_name,
    NULLIF(customer_last_name, '') AS last_name,
    customer_age,
    NULLIF(customer_email, '') AS email,
    NULLIF(customer_country, '') AS country,
    NULLIF(customer_postal_code, '') AS postal_code
FROM mock_data;

INSERT INTO dim_pet(category, type, name, breed)
SELECT DISTINCT
    NULLIF(pet_category, '') AS category,
    NULLIF(customer_pet_type, '') AS type,
    NULLIF(customer_pet_name, '') AS name,
    NULLIF(customer_pet_breed, '') AS breed
FROM mock_data;

INSERT INTO dim_seller(first_name, last_name, email, country, postal_code)
SELECT DISTINCT
    NULLIF(seller_first_name, '') AS first_name,
    NULLIF(seller_last_name, '') AS last_name,
    NULLIF(seller_email, '') AS email,
    NULLIF(seller_country, '') AS country,
    NULLIF(seller_postal_code, '') AS postal_code
FROM mock_data;

INSERT INTO dim_supplier(name, contact, email, phone, address, city, country)
SELECT DISTINCT
    NULLIF(supplier_name, '') AS name,
    NULLIF(supplier_contact, '') AS contact,
    NULLIF(supplier_email, '') AS email,
    NULLIF(supplier_phone, '') AS phone,
    NULLIF(supplier_address, '') AS address,
    NULLIF(supplier_city, '') AS city,
    NULLIF(supplier_country, '') AS country
FROM mock_data;

INSERT INTO dim_product(name, category, price, quantity, weight, color, size, brand, material, description, rating, reviews, release_date, expiry_date)
SELECT DISTINCT
    NULLIF(product_name, '') AS name,
    NULLIF(product_category, '') AS category,
    product_price AS price,
    product_quantity AS quantity,
    product_weight AS weight,
    NULLIF(product_color, '') AS color,
    NULLIF(product_size, '') AS size,
    NULLIF(product_brand, '') AS brand,
    NULLIF(product_material, '') AS material,
    NULLIF(product_description, '') AS description,
    product_rating AS rating,
    product_reviews AS reviews,
    product_release_date,
    product_expiry_date
FROM mock_data;

INSERT INTO dim_store(name, location, city, state, country, phone, email)
SELECT DISTINCT
    NULLIF(store_name, '') AS name,
    NULLIF(store_location, '') AS location,
    NULLIF(store_city, '') AS city,
    NULLIF(store_state, '') AS state,
    NULLIF(store_country, '') AS country,
    NULLIF(store_phone, '') AS phone,
    NULLIF(store_email, '') AS email
FROM mock_data;

INSERT INTO fact_sale(date, customer_id, seller_id, product_id, store_id, supplier_id, pet_id, quantity, total_price)
SELECT
    sale_date,
    c.id,
    se.id,
    pr.id,
    st.id,
    su.id,
    pe.id,
    m.sale_quantity,
    m.sale_total_price
FROM mock_data m
JOIN dim_customer c
    ON c.first_name IS NOT DISTINCT FROM NULLIF(m.customer_first_name, '')
    AND c.last_name IS NOT DISTINCT FROM NULLIF(m.customer_last_name, '')
    AND c.age IS NOT DISTINCT FROM m.customer_age
    AND c.email IS NOT DISTINCT FROM NULLIF(m.customer_email, '')
    AND c.country IS NOT DISTINCT FROM NULLIF(m.customer_country, '')
    AND c.postal_code IS NOT DISTINCT FROM NULLIF(m.customer_postal_code, '')
JOIN dim_seller se
    ON se.first_name IS NOT DISTINCT FROM NULLIF(m.seller_first_name, '')
    AND se.last_name IS NOT DISTINCT FROM NULLIF(m.seller_last_name, '')
    AND se.email IS NOT DISTINCT FROM NULLIF(m.seller_email, '')
    AND se.country IS NOT DISTINCT FROM NULLIF(m.seller_country, '')
    AND se.postal_code IS NOT DISTINCT FROM NULLIF(m.seller_postal_code, '')
JOIN dim_product pr
    ON pr.name IS NOT DISTINCT FROM NULLIF(m.product_name, '')
    AND pr.category IS NOT DISTINCT FROM NULLIF(m.product_category, '')
    AND pr.price IS NOT DISTINCT FROM m.product_price
    AND pr.quantity IS NOT DISTINCT FROM m.product_quantity
    AND pr.weight IS NOT DISTINCT FROM m.product_weight
    AND pr.color IS NOT DISTINCT FROM NULLIF(m.product_color, '')
    AND pr.size IS NOT DISTINCT FROM NULLIF(m.product_size, '')
    AND pr.brand IS NOT DISTINCT FROM NULLIF(m.product_brand, '')
    AND pr.material IS NOT DISTINCT FROM NULLIF(m.product_material, '')
    AND pr.description IS NOT DISTINCT FROM NULLIF(m.product_description, '')
    AND pr.rating IS NOT DISTINCT FROM m.product_rating
    AND pr.reviews IS NOT DISTINCT FROM m.product_reviews
    AND pr.release_date IS NOT DISTINCT FROM m.product_release_date
    AND pr.expiry_date IS NOT DISTINCT FROM m.product_expiry_date
JOIN dim_store st
    ON st.name IS NOT DISTINCT FROM NULLIF(m.store_name, '')
    AND st.location IS NOT DISTINCT FROM NULLIF(m.store_location, '')
    AND st.city IS NOT DISTINCT FROM NULLIF(m.store_city, '')
    AND st.state IS NOT DISTINCT FROM NULLIF(m.store_state, '')
    AND st.country IS NOT DISTINCT FROM NULLIF(m.store_country, '')
    AND st.phone IS NOT DISTINCT FROM NULLIF(m.store_phone, '')
    AND st.email IS NOT DISTINCT FROM NULLIF(m.store_email, '')
JOIN dim_supplier su
    ON su.name IS NOT DISTINCT FROM NULLIF(m.supplier_name, '')
    AND su.contact IS NOT DISTINCT FROM NULLIF(m.supplier_contact, '')
    AND su.email IS NOT DISTINCT FROM NULLIF(m.supplier_email, '')
    AND su.phone IS NOT DISTINCT FROM NULLIF(m.supplier_phone, '')
    AND su.address IS NOT DISTINCT FROM NULLIF(m.supplier_address, '')
    AND su.city IS NOT DISTINCT FROM NULLIF(m.supplier_city, '')
    AND su.country IS NOT DISTINCT FROM NULLIF(m.supplier_country, '')
JOIN dim_pet pe
    ON pe.category IS NOT DISTINCT FROM NULLIF(m.pet_category, '')
    AND pe.type IS NOT DISTINCT FROM NULLIF(m.customer_pet_type, '')
    AND pe.name IS NOT DISTINCT FROM NULLIF(m.customer_pet_name, '')
    AND pe.breed IS NOT DISTINCT FROM NULLIF(m.customer_pet_breed, '');
