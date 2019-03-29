Q: What classes does each implementation include? Are the lists the same?

A: Both implementations include the same classes: CartEntry, ShoppingCart, and Order.

Q: Write down a sentence to describe each class.
How do the classes relate to each other? 

A: CartEntry is responsible for each entry in a ShoppingCart. ShoppingCart is responsible for all CartEntries in an Order. Order calculates the total price with sales tax for all CartEntries in a ShoppingCart.

Q: What data does each class store? How (if at all) does this differ between the two implementations?

A: CartEntry stores information about the unit price and quantity for each entry in a ShoppingCart.
ShoppingCart stores all instances of CartEntries per order, and Order stores an instance of ShoppingCart, as well as sales tax information and total price. With Imp B, the lower classes also store information about price per respective class instance.

Q: What methods does each class have? How (if at all) does this differ between the two implementations?

A: Each class has an initialize method, and in both implementations the Order class has a total_price method. The difference between the two implementations is that instead of using attr_accessors to access price information outside of the lower classes, Imp B has price methods within each class.

Q: Consider the Order#total_price method. In each implementation: Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? Does total_price directly manipulate the instance variables of other classes?

A: In Imp A, the logic to compute price is retained in order, and the total_price method directly manipulates the instance variables of the lower classes, whereas in Imp B, the logic to compute price is delegated to lower level classes.

Q: If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

A: I believe Imp B would be easier to modify, because you could simply add a conditional to the price method within CartEntry to reflect a lower price if the quantity per unit exceeds x.

Q: Which implementation better adheres to the single responsibility principle?

A: Imp B, because each lower-level class is responsible for calculating its own price, and therefore the Order class doesn't have to access or manipulate instance variables of other classes, and simply calculates the sales tax.

Q: Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

A: B!