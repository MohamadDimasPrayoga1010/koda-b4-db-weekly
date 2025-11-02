CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(100),
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE profile(
    id SERIAL PRIMARY KEY,
    image VARCHAR(100),
    phone VARCHAR(100),
    address VARCHAR(100),
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    user_id BIGINT UNIQUE REFERENCES users(id)
);

CREATE TABLE variants(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE categories(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) UNIQUE,
    description VARCHAR(100),
    variant_id BIGINT REFERENCES variants(id),
    category_id BIGINT REFERENCES categories(id),
    stock INT,
    base_price NUMERIC,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    deleted_at TIMESTAMP DEFAULT now()
);

CREATE TABLE products_categories(
    product_id BIGINT REFERENCES products(id),
    category_id BIGINT REFERENCES categories(id)
);

CREATE TABLE product_images(
    product_id BIGINT REFERENCES products(id),
    image VARCHAR(250),
    updated_at TIMESTAMP DEFAULT now(),
    deleted_at TIMESTAMP
);

CREATE TABLE promos(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    discount FLOAT NOT NULL,
    start TIMESTAMP NOT NULL,
    "end" TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    deleted_at TIMESTAMP
);

CREATE TABLE product_promos(
    promo_id BIGINT REFERENCES promos(id),
    product_id BIGINT REFERENCES products(id)
);

CREATE TABLE payment_methods(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    image VARCHAR(250) NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id),
    payment_method BIGINT REFERENCES payment_methods(id),
    delevery VARCHAR(100) NOT NULL,
    no_orders VARCHAR(50),
    total NUMERIC NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE sizes(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    additional_price NUMERIC
);

CREATE TABLE orders_products(
    orderd_id BIGINT REFERENCES orders(id),
    product_id BIGINT REFERENCES products(id),
    size_id INT REFERENCES sizes(id),
    qty INT
);

CREATE TABLE product_sizes(
    product_id BIGINT REFERENCES products(id),
    size_id INT REFERENCES sizes(id)
);


