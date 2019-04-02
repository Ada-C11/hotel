Question | Answer
:------------- | :-------------
What classes does each implementation include? | Both implementations include CartEntry, ShoppingCart, and Order. 
Are the lists the same?| The lists are the same
Write down a sentence to describe each class.| CartEntry tracks the quantity and unit price of an item in a cart. ShoppingCart holds a collection of entries. Order calculates the total price of all the items in a cart with tax.
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.| ShoppingCart has many CartEntries. Order has one ShoppingCart.
What data does each class store? How (if at all) does this differ between the two implementations?| In both implementations, CartEntry stores unit price and quantity, ShoppingCart stores entries, and Order stores a shopping cart.
What methods does each class have? How (if at all) does this differ between the two implementations?| In the first implementation, Order uses the @unit_price instance variable of each CartEntry to calculate the total price. Neither CartEntry nor ShoppingCart have any instance methods. In the second implementation, both CartEntry and ShoppingCart have their own price method.
Consider the Order#total_price method. In each implementation:
Question | Answer
:------------- | :-------------
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?| In the first implementation, it is retained in order. In the second implementation, it is delegated to lower level classes.
Does total_price directly manipulate the instance variables of other classes?| In the first implementation, total_price directly accesses instance variables from CartEntry. In the second implementation, it does not.
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?| This would chance the code because the price can no longer be calculated by multiplying quantity by unit price. The second implementation is easier to modify.
Which implementation better adheres to the single responsibility principle?| The second implementation better adheres to SRP.
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?| The second implementation is more loosely coupled, since the first creates a lot of dependencies by chaining methods in the total_price method.