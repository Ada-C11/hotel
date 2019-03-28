What classes does each implementation include? Are the lists the same?
 A & B both contain: CartEntry, ShoppingCart, Order

Write down a sentence to describe each class.
  CartEntry--records the unit price and the quantity of each item
  ShoppingCart--keeps a list of all items 
  Order--applies sales tax and calculates the total cost of items
  
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  ShoppingCart is a container for instances of CartEntry. The Order class takes information given by both ShoppingCart and CartEntry to output the end details.

What data does each class store? How (if at all) does this differ between the two implementations?
  CartEntry--unit price & quantity of every item added to cart
    B stores the total price by item, whereas A calculates the total by item in the Order class
  ShoppingCart--contains just instances of cart entries
  Order--stores the total cost of the entire order

What methods does each class have? How (if at all) does this differ between the two implementations?
  A-CartEntry: initialize
  B-CartEntry: initialize, price
  A-ShoppingCart: initialize
  B-ShoppingCart: initialize, price
  Order: initialize, total price
  
Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
  Both implementations compute the total cost with tax, but in A, more of the calculations are done in the Order class, whereas the prices are totaled first in the lower level classes and then calculated as a whole in Order.

Does total_price directly manipulate the instance variables of other classes?
  Neither manipulate instance variables of other classes
  
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
  The attributes of each cart entry would need to change; if the quantity of an item is over a certain amount, the unit price changes, or perhaps there could be a new bulk price attribute.
    Implementation B is easier to modify

Which implementation better adheres to the single responsibility principle?
  A better adheres to the single responsibility principles, however, B is more loosely coupled.
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
