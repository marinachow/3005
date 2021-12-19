-- View: bookstore.a_book

-- DROP VIEW bookstore.a_book;

CREATE OR REPLACE VIEW bookstore.a_book
 AS
 SELECT book.isbn,
    book.title,
    book.num_pages,
    book.price,
    book.pub_id,
    book.percentage,
    book.stock
   FROM bookstore.book;

ALTER TABLE bookstore.a_book
    OWNER TO postgres;

-- View: bookstore.a_publisher

-- DROP VIEW bookstore.a_publisher;

CREATE OR REPLACE VIEW bookstore.a_publisher
 AS
 SELECT publisher.pub_id,
    publisher.bank_info,
    publisher.pub_name,
    publisher.address,
    publisher.email,
    publisher.phone_num
   FROM bookstore.publisher;

ALTER TABLE bookstore.a_publisher
    OWNER TO postgres;

-- View: bookstore.an_author

-- DROP VIEW bookstore.an_author;

CREATE OR REPLACE VIEW bookstore.an_author
 AS
 SELECT author.a_id,
    author.a_name
   FROM bookstore.author;

ALTER TABLE bookstore.an_author
    OWNER TO postgres;

-- View: bookstore.authors_sold

-- DROP VIEW bookstore.authors_sold;

CREATE OR REPLACE VIEW bookstore.authors_sold
 AS
 SELECT sold.s_id,
    sold.isbn,
    sold.date_sold,
    sold.qty
   FROM bookstore.sold;

ALTER TABLE bookstore.authors_sold
    OWNER TO postgres;

-- View: bookstore.genres_sold

-- DROP VIEW bookstore.genres_sold;

CREATE OR REPLACE VIEW bookstore.genres_sold
 AS
 SELECT sold.s_id,
    sold.isbn,
    sold.date_sold,
    sold.qty
   FROM bookstore.sold;

ALTER TABLE bookstore.genres_sold
    OWNER TO postgres;

-- View: bookstore.my_cart

-- DROP VIEW bookstore.my_cart;

CREATE OR REPLACE VIEW bookstore.my_cart
 AS
 SELECT cart.isbn,
    cart.u_id,
    cart.qty
   FROM bookstore.cart;

ALTER TABLE bookstore.my_cart
    OWNER TO postgres;

-- View: bookstore.my_orders

-- DROP VIEW bookstore.my_orders;

CREATE OR REPLACE VIEW bookstore.my_orders
 AS
 SELECT orders.o_num,
    orders.u_id,
    orders.is_outgoing,
    orders.received,
    orders.o_date,
    orders.o_time
   FROM bookstore.orders;

ALTER TABLE bookstore.my_orders
    OWNER TO postgres;

