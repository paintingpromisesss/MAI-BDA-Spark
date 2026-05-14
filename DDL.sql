DROP TABLE IF EXISTS fact_sale CASCADE;
DROP TABLE IF EXISTS dim_product CASCADE;
DROP TABLE IF EXISTS dim_store CASCADE;
DROP TABLE IF EXISTS dim_supplier CASCADE;
DROP TABLE IF EXISTS dim_seller CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS dim_pet CASCADE;

CREATE TABLE dim_customer (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age INT,
    email TEXT,
    country TEXT,
    postal_code TEXT
);

CREATE TABLE dim_pet (
    id SERIAL PRIMARY KEY,
    category TEXT,
    type TEXT,
    name TEXT,
    breed TEXT
);

CREATE TABLE dim_seller (
    id SERIAL PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    country TEXT,
    postal_code TEXT
);

CREATE TABLE dim_supplier (
    id SERIAL PRIMARY KEY,
    name TEXT,
    contact TEXT,
    email TEXT,
    phone TEXT,
    address TEXT,
    city TEXT,
    country TEXT
);

CREATE TABLE dim_product (
    id SERIAL PRIMARY KEY,
    name TEXT,
    category TEXT,
    price NUMERIC(10, 2),
    quantity INT,
    weight NUMERIC(10, 1),
    color TEXT,
    size TEXT,
    brand TEXT,
    material TEXT,
    description TEXT,
    rating NUMERIC(2, 1),
    reviews INT,
    release_date DATE,
    expiry_date DATE
);

CREATE TABLE dim_store (
    id SERIAL PRIMARY KEY,
    name TEXT,
    location TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    phone TEXT,
    email TEXT
);

CREATE TABLE fact_sale (
    id SERIAL PRIMARY KEY,
    date DATE,
    customer_id INT REFERENCES dim_customer(id),
    seller_id INT REFERENCES dim_seller(id),
    product_id INT REFERENCES dim_product(id),
    store_id INT REFERENCES dim_store(id),
    supplier_id INT REFERENCES dim_supplier(id),
    pet_id INT REFERENCES dim_pet(id),
    quantity INT,
    total_price NUMERIC(10, 2)
);
