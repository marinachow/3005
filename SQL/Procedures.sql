-- PROCEDURE: bookstore.addauthor(character varying)
-- Adds an author to the db

-- DROP PROCEDURE bookstore.addauthor(character varying);

CREATE OR REPLACE PROCEDURE bookstore.addauthor(
	a_name character varying)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.author values(default, a_name)
$BODY$;

-- PROCEDURE: bookstore.addauthortobook(character varying, integer)
-- Adds an author to a book

-- DROP PROCEDURE bookstore.addauthortobook(character varying, integer);

CREATE OR REPLACE PROCEDURE bookstore.addauthortobook(
	isbn character varying,
	a_id integer)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.wrote values(isbn, a_id)
$BODY$;

-- PROCEDURE: bookstore.addbook(character varying, character varying, integer, numeric, integer, integer, integer)
-- Adds a book to the db

-- DROP PROCEDURE bookstore.addbook(character varying, character varying, integer, numeric, integer, integer, integer);

CREATE OR REPLACE PROCEDURE bookstore.addbook(
	isbn character varying,
	title character varying,
	num_pages integer,
	price numeric,
	pub_id integer,
	percentage integer,
	stock integer)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.book values(isbn, title, num_pages, price, pub_id, percentage, stock)
$BODY$;

-- PROCEDURE: bookstore.addbookorder(integer, character varying, integer)
-- Adds a book order to the db

-- DROP PROCEDURE bookstore.addbookorder(integer, character varying, integer);

CREATE OR REPLACE PROCEDURE bookstore.addbookorder(
	o_num integer,
	isbn character varying,
	o_count integer)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.ordered values(o_num, isbn, o_count)
$BODY$;

-- PROCEDURE: bookstore.addgenre(character varying)
-- Adds a genre to the db

-- DROP PROCEDURE bookstore.addgenre(character varying);

CREATE OR REPLACE PROCEDURE bookstore.addgenre(
	g_name character varying)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.genre values(g_name)
$BODY$;

-- PROCEDURE: bookstore.addgenretobook(character varying, character varying)
-- Adds a genre to a book

-- DROP PROCEDURE bookstore.addgenretobook(character varying, character varying);

CREATE OR REPLACE PROCEDURE bookstore.addgenretobook(
	isbn character varying,
	genre_name character varying)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.has_genres values(isbn, genre_name)
$BODY$;

-- PROCEDURE: bookstore.addpub(character varying, character varying, character varying, character varying, character varying)
-- Adds a publisher to the db

-- DROP PROCEDURE bookstore.addpub(character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE bookstore.addpub(
	bank_info character varying,
	pub_name character varying,
	address character varying,
	email character varying,
	phone_num character varying)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.publisher values(default, bank_info, pub_name, address, email, phone_num)
$BODY$;

-- PROCEDURE: bookstore.addsale(character varying, date)
-- Adds a sale to the db

-- DROP PROCEDURE bookstore.addsale(character varying, date);

CREATE OR REPLACE PROCEDURE bookstore.addsale(
	isbn character varying,
	date_sold date)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.sold values(default, isbn, date_sold)
$BODY$;

-- PROCEDURE: bookstore.addtocart(character varying, integer, integer)
-- Adds a book(s) to the cart, if the user already has that book in their cart, the quantity gets updated, otherwise a new item is added with the specified quantity

-- DROP PROCEDURE bookstore.addtocart(character varying, integer, integer);

CREATE OR REPLACE PROCEDURE bookstore.addtocart(
	book_isbn character varying,
	user_id integer,
	book_qty integer)
LANGUAGE 'plpgsql'
AS $BODY$
    begin
        if exists(select * from project.bookstore.cart where isbn = book_isbn AND u_id = user_id) then
			update project.bookstore.cart set qty = qty + book_qty where isbn = book_isbn and u_id = user_id;
		else
			insert into project.bookstore.cart values (book_isbn, user_id, book_qty);
		end if;
		update project.bookstore.book set stock = stock - book_qty where isbn = book_isbn;
    end;
            
$BODY$;

-- PROCEDURE: bookstore.adduser(character varying, character varying, boolean)
-- Adds a user to the db

-- DROP PROCEDURE bookstore.adduser(character varying, character varying, boolean);

CREATE OR REPLACE PROCEDURE bookstore.adduser(
	username character varying,
	u_info character varying,
	is_owner boolean DEFAULT false)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.user values(default, username, u_info, is_owner)
$BODY$;

-- PROCEDURE: bookstore.adduserorder(integer, boolean, boolean)
-- Links an order to a user with order info

-- DROP PROCEDURE bookstore.adduserorder(integer, boolean, boolean);

CREATE OR REPLACE PROCEDURE bookstore.adduserorder(
	u_id integer,
	is_outgoing boolean DEFAULT false,
	received boolean DEFAULT false)
LANGUAGE 'sql'
AS $BODY$
insert into project.bookstore.user_orders values(default, u_id, is_outgoing, received, CURRENT_DATE, CURRENT_TIME)
$BODY$;

-- PROCEDURE: bookstore.checkout(integer)
-- Checkouts the order by creating a user order, adding all the ordered items to ordered table, updating the sold table and emptying the cart

-- DROP PROCEDURE bookstore.checkout(integer);

CREATE OR REPLACE PROCEDURE bookstore.checkout(
	user_id integer)
LANGUAGE 'sql'
AS $BODY$
call project.bookstore.addUserOrder(user_id);
insert into project.bookstore.ordered select o_num, isbn, qty from project.bookstore.cart natural join (select o_num, u_id from project.bookstore.user_orders where u_id = user_id order by o_num desc limit 1) as table_b;
insert into project.bookstore.sold(isbn, date_sold, qty) select isbn, o_date, qty from project.bookstore.cart natural join (select o_num, u_id, o_date from project.bookstore.user_orders where u_id = user_id order by o_num desc limit 1) as table_b;
delete from project.bookstore.cart where u_id = user_id
$BODY$;
