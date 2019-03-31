Evaluating Responsibility: 
Q. What classes does each implemenation include?  Are the lists the same?
A. Both implementations include the following classes: CartEntry, ShoppingCart, and Order.

Q. Write down a sentence to describe each class.
A. Each CartEntry has an unit_price and quantity; these would be the products that are being placed into the cart.  Each ShoppingCart has entries; this would be the the cart that holds all the products collected so far.  Each Order has a shopping cart and is responsible for calculating the total price of all the entries within the cart, along with the added sales tax. 

Q. How do the classes related to each other?
A. An Order has a one to one relationship with a ShoppingCart and a ShoppingCart has a one to many relationship with CartEntry.  These are related by composition.

Q. What data does each class store?  How (if at all) does this differ between the two implementations?
A. 

Q. What methods does each class have?  How (if at all) does this differ between the two implementations?
A. Implemenation A: CartEntry has attr_accessor for unit_price and quantity.  ShoppingCart has attr_accessory for entries.  Order has a total price method.  Implementation B: None of the classes have attr_accessors.  CartEntry and ShoppingCart now have price methods.  Order still has a total price method.

Consider the Order#total_price method.  In each implementation:
Q. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
A.  In implementation A, logic to compute the price is retained solely in the Order class.  It asks CartEntry, what is your unit price and quantity and then takes the information to calculate the total price.  In implementation B, the Order asks the ShoppingCart for the price (and ShoppingCart in turn asks the various CartEntries for the price).  In Implementation B, ShoppingCart, does not know the nuances of calculating the prices for each CartEntry and the ShoppingCart.
Q. Does total_price directly manipulate the instance variables of other classes?
A.  Total_price directly manipulates the instance variables of CartEntry in implementation A.  It reads the unit_price and quantity to calculate the price of the entry.

Q. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
A. In implementation B, we would alter the price method of the CartEntry class.  We would add a loop that says something like if quantity is greater than x, subtract this amount from the price.  We could make a similar change in Implemenation A, but this would end up being more work and we would end up with messier code as we would have a conditional inside of the each loop.

Q. Which implemenation better adheres to the single responsibility principle?
A. Implemenation B better adheres to the single responsibility principle.

Q. Which implementation is more loosely coupled?
A.  Implemenation B is more loosely coupled.  It asks "what" rather than "how."

