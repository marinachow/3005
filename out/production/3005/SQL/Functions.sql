-- FUNCTION: bookstore.calculatebooklastmonthsales(character varying)
-- Funtion to calculate the sum of book sales in the last month for one specified book

-- DROP FUNCTION bookstore.calculatebooklastmonthsales(character varying);

CREATE OR REPLACE FUNCTION bookstore.calculatebooklastmonthsales(
	book_isbn character varying)
    RETURNS integer
    LANGUAGE 'sql'
    COST 100
    IMMUTABLE STRICT PARALLEL UNSAFE
AS $BODY$
 SELECT sum(qty) from bookstore.sold where book_isbn = isbn and date_sold >= (current_date - interval '1' month);
$BODY$;

ALTER FUNCTION bookstore.calculatebooklastmonthsales(character varying)
    OWNER TO postgres;
