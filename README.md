# COMP3005finalProject

To run the code:
1. Open a Query Tool in the database
2. Create the tables by running the code in the DDL.sql file
3. Create the procedures by runnning the code in the Procedures.sql file
4. Create the functions by running the code in the Functions.sql file
5. Create the triggers by running the code in the Triggers.sql file
6. Create the views by running the code in the Views.sql file

To test the DB:
1. Use bookstore.adduser(username character varying, u_info character varying, is_owner boolean DEFAULT false) to create the first user, which is the owner of the store
2. Use bookstore.addpub(bank_info character varying, pub_name character varying, address character varying, email character varying, phone_num character varying) procedure to create a publisher
3. Use the bookstore.addbook(isbn character varying, title character varying, num_pages integer, price numeric, pub_id integer, percentage integer, stock integer) procedure to create books in the DB
4. Use bookstore.addtocart(book_isbn character varying, user_id integer, book_qty integer) to simiulate adding the book to cart
5. Use bookstore.checkout(user_id integer) to simulate a checkout
6. Check that the stock went down by the quantity of books ordered with "select stock from bookstore.book where isbn = 'insert isbn here'"
7. Keep simulating checkouts until the stock goes below 10, which tiggers the trigger function to order the amount of book sold in the last month
8. Use any of the add procedures to add more data to the DB
