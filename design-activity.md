What classes does each implementation include? Are the lists the same?
  Each implementation has a CartEntry, ShoppingCart, and Order class.
Write down a sentence to describe each class.
  CartEntry hold the unit prices and quantities of grocery items.

  Shopping Cart holds "entries", or items in the cart.

  Order creates a new instance of ShoppingCart and calculates the total price of the items in the cart.
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

  Order uses the entries from the ShoppingCart class to calculate the total price. The entries in the shopping cart class are instances of CartEntry.
What data does each class store? How (if at all) does this differ between the two implementations?
  CartEntry stores the unit price and quantity of items.
  ShoppingCart stores an array of cart entries.
  Order stores the SALES_TAX constant and an instance of ShoppingCart
What methods does each class have? How (if at all) does this differ between the two implementations?
  In Implementation B, CartEntry has a "price" method that calculates the @unit_price variable times the @quantity variable.

  In Implementation B, ShoppingCart also has a "price" method. This method calls the "price" method from CartEntry within it (and calculates the sum of the entries in the cart).

  In Implementations A and B, Order has a total_price method. In Implementation A, we iterate over each instance of Cart to calculate the price of each CartEntry. Then we use our SALES_TAX constant to get the total.

  In Implementation B, we can get the subtotal by calling the "price" method on cart. Then we use our SALES_TAX constant to get the total.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  In Implementation A, the logic to compute the price is retained in Order. In Implementation B, the logic is delegated to the lower level classes.
Does total_price directly manipulate the instance variables of other classes?
  No
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Which implementation better adheres to the single responsibility principle?
  We would have to add a conditional to calculate a lower price if the quantity of each CartEntry is above a certain number. I think Implementation A would be easier to modify because we only call those variables once. I think Implementation A adheres better to that principle because we're only giving the responsibility of calculating price to one class.
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? Implementation A is more loosely coupled? Maybe?



HOTEL REFACTOR

I know that I needed to add a Date_Range class. I was doing lots of weird things with dates that ended up making my classes really tightly coupled. Making a date_range.rb also helped move a lot of my conditional statements out of my methods. I could do all that work in advance, which made my tests a lot easier too. 

My Block class and my Hotel_Manager class are really tightly coupled. 
  I moved my create_block and reserve_from_block methods out of my block class and into my Hotel_Manager class. While I was doing this, I got rid of a lot of instance variables that I didn't really need/were making my blocks of code really reliant on each other (but also not because a lot of the time it didn't work? Anyway.)

  Adding inheritance also helped. I shied away from it at the beginning, but having the inheritance cut down on creating unnecessary data structures.
