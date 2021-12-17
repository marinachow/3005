-- Table: bookstore.genre

-- DROP TABLE bookstore.genre;

CREATE TABLE IF NOT EXISTS bookstore.genre
(
    g_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT genre_pkey PRIMARY KEY (g_name)
)

TABLESPACE pg_default;

ALTER TABLE bookstore.genre
    OWNER to postgres;
	
-- Table: bookstore.user

-- DROP TABLE bookstore."user";

CREATE TABLE IF NOT EXISTS bookstore."user"
(
    u_id serial,
    username character varying COLLATE pg_catalog."default" NOT NULL,
    u_info character varying COLLATE pg_catalog."default",
    is_owner boolean,
    CONSTRAINT user_pkey PRIMARY KEY (u_id)
)

TABLESPACE pg_default;

ALTER TABLE bookstore."user"
    OWNER to postgres;
	
-- Table: bookstore.publisher

-- DROP TABLE bookstore.publisher;

CREATE TABLE IF NOT EXISTS bookstore.publisher
(
    pub_id serial,
    bank_info character varying COLLATE pg_catalog."default" NOT NULL,
    pub_name character varying COLLATE pg_catalog."default" NOT NULL,
    address character varying COLLATE pg_catalog."default" NOT NULL,
    email character varying COLLATE pg_catalog."default" NOT NULL,
    phone_num character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT publisher_pkey PRIMARY KEY (pub_id)
)

TABLESPACE pg_default;

ALTER TABLE bookstore.publisher
    OWNER to postgres;

-- Table: bookstore.author

-- DROP TABLE bookstore.author;

CREATE TABLE IF NOT EXISTS bookstore.author
(
    a_id serial,
    a_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT author_pkey PRIMARY KEY (a_id)
)

TABLESPACE pg_default;

ALTER TABLE bookstore.author
    OWNER to postgres;

-- Table: bookstore.book

-- DROP TABLE bookstore.book;

CREATE TABLE IF NOT EXISTS bookstore.book
(
    isbn character varying COLLATE pg_catalog."default" NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    num_pages integer NOT NULL,
    price numeric(2,0) NOT NULL,
    pub_id integer NOT NULL,
    percentage integer NOT NULL,
    stock integer NOT NULL,
    CONSTRAINT book_pkey PRIMARY KEY (isbn),
    CONSTRAINT pub_id_fk FOREIGN KEY (pub_id)
        REFERENCES bookstore.publisher (pub_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE bookstore.book
    OWNER to postgres;

-- Table: bookstore.cart

-- DROP TABLE bookstore.cart;

CREATE TABLE IF NOT EXISTS bookstore.cart
(
    isbn character varying COLLATE pg_catalog."default" NOT NULL,
    u_id integer NOT NULL,
    qty integer,
    CONSTRAINT cart_pkey PRIMARY KEY (isbn, u_id),
    CONSTRAINT isbn_fk FOREIGN KEY (isbn)
        REFERENCES bookstore.book (isbn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT u_id_fk FOREIGN KEY (u_id)
        REFERENCES bookstore."user" (u_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE bookstore.cart
    OWNER to postgres;	

-- Table: bookstore.has_genres

-- DROP TABLE bookstore.has_genres;

CREATE TABLE IF NOT EXISTS bookstore.has_genres
(
    isbn character varying COLLATE pg_catalog."default" NOT NULL,
    g_name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT has_genres_pkey PRIMARY KEY (isbn, g_name),
    CONSTRAINT g_name_fk FOREIGN KEY (g_name)
        REFERENCES bookstore.genre (g_name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT isbn_fk FOREIGN KEY (isbn)
        REFERENCES bookstore.book (isbn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE bookstore.has_genres
    OWNER to postgres;

-- Table: bookstore.orders

-- DROP TABLE bookstore.orders;

CREATE TABLE IF NOT EXISTS bookstore.orders
(
    o_num serial,
    u_id integer,
    is_outgoing boolean,
    received boolean,
    o_date date,
    o_time time without time zone,
    CONSTRAINT orders_pkey PRIMARY KEY (o_num),
    CONSTRAINT u_id_fk FOREIGN KEY (u_id)
        REFERENCES bookstore."user" (u_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE bookstore.orders
    OWNER to postgres;


-- Table: bookstore.ordered_book

-- DROP TABLE bookstore.ordered_book;

CREATE TABLE IF NOT EXISTS bookstore.ordered_book
(
    o_num integer NOT NULL,
    isbn character varying COLLATE pg_catalog."default" NOT NULL,
    qty integer,
    CONSTRAINT ordered_book_pkey PRIMARY KEY (o_num, isbn),
    CONSTRAINT isbn_fk FOREIGN KEY (isbn)
        REFERENCES bookstore.book (isbn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT o_num_fk FOREIGN KEY (o_num)
        REFERENCES bookstore.orders (o_num) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE bookstore.ordered_book
    OWNER to postgres;

-- Table: bookstore.sold

-- DROP TABLE bookstore.sold;

CREATE TABLE IF NOT EXISTS bookstore.sold
(
    s_id serial,
    isbn character varying COLLATE pg_catalog."default",
    date_sold date,
    qty integer,
    CONSTRAINT sold_pkey PRIMARY KEY (s_id),
    CONSTRAINT isbn_fk FOREIGN KEY (isbn)
        REFERENCES bookstore.book (isbn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE bookstore.sold
    OWNER to postgres;

-- Table: bookstore.wrote

-- DROP TABLE bookstore.wrote;

CREATE TABLE IF NOT EXISTS bookstore.wrote
(
    isbn character varying COLLATE pg_catalog."default" NOT NULL,
    a_id integer NOT NULL,
    CONSTRAINT wrote_pkey PRIMARY KEY (isbn, a_id),
    CONSTRAINT a_id_fk FOREIGN KEY (a_id)
        REFERENCES bookstore.author (a_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT isbn_fk FOREIGN KEY (isbn)
        REFERENCES bookstore.book (isbn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE bookstore.wrote
    OWNER to postgres;