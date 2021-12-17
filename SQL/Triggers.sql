-- FUNCTION: bookstore.incomingbookorder()

-- DROP FUNCTION bookstore.incomingbookorder();

CREATE OR REPLACE FUNCTION bookstore.incomingbookorder()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
	declare
		 book_isbn varchar = NEW.isbn;
	begin
		if NEW.isbn is NULL then
			raise exception'isbn is null';
		end if;
		if (select stock from bookstore.book where isbn = book_isbn) < 10 then
			call bookstore.addToBookStock(book_isbn);
		end if;
		return NEW;
	end;
$BODY$;

ALTER FUNCTION bookstore.incomingbookorder()
    OWNER TO postgres;

-- Trigger: addstock

-- DROP TRIGGER addstock ON bookstore.sold;

CREATE TRIGGER addstock
    AFTER INSERT
    ON bookstore.sold
    FOR EACH ROW
    EXECUTE FUNCTION bookstore.incomingbookorder();