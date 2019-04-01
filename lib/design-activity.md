<!-- What classes does each implementation include? Are the lists the same? -->

* The same.


<!-- Write down a sentence to describe each class. -->

Implementation A: 
* CartEntry - Initialized instance variables for unit_price, and quantity.
* ShoppingCart - Initialized instance variables for entries, set default to an array.
* Order - Has constant of SALES_TAX. Initializes an instance variable set to equal a new ShoppingCart class. This Class also has a method to calculate total_price through each cart entries unit price and quantity.


Implementation B: 
* CartEntry -  Initialized instance variables for unit_price, and quantity. This Class also has a method to calculate price.
* ShoppingCart - Initialized instance variables for entries, set default to an array. This Class also has a method to calculate price.
* Order - Has constant of SALES_TAX. Initializes an instance variable set to equal a new ShoppingCart class. This Class also has a method to calculate total_price through calling the price of the entire cart class instance.


<!-- How do the classes relate to each other? -->

Implementation A: CartEntry Class is passed into the ShoppingCart instance of entries, an array. Order Class passes a new ShoppingCart class into an instance of cart. In Order Class, each entry within the array of Shopping cart is looped through for each entries unit_price and quantity (attributes of CartEntry class).

Implementation B: CartEntry class has attributes unit_price and quantity, and has a method of price. ShoppingCart has instances of entries, and can return the sum of itself with the method price. Order has instances of carts, assigned to new instances of the ShoppingCart class. Order can calculate it's total_price by calling the price method on the instance of the ShoppingCart class.


<!-- What data does each class store? How (if at all) does this differ between the two implementations? -->

The data in the classes are the same, except Implementation A includes attr_accessors for attributes of CartEntry and ShoppingCart.


<!-- What methods does each class have? How (if at all) does this differ between the two implementations? -->

Implementation A has the Order Class as a "master" class, attaining the prices of related classes CartEntry and ShoppingCart to then calculate the total order price in the only method to calculate price within the Order Class. Implementation B includes price methods within each class, which removed extra responsibility from the Order class. 


<!-- Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? -->

Implementation A does not delegate computation to "lower level" classes and retains it in Order. Implementation B does not do this. 


<!-- Does total_price directly manipulate the instance variables of other classes? -->

Implementation A does manipulate the instance variables of other classes by passing through each entry (ShoppingCart Class attributes) and then each entry's unit_price and quantity (CartEntry Class attributes). Implementation B does not do this.


<!-- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify? -->

Implementation B would be easier to modify, and the code would not need to be modified as the price for each entry is already calculated within this method. 
 

<!-- Which implementation better adheres to the single responsibility principle? -->

Implementation B.

<!-- Which implementation is more loosely coupled? -->
Implementation B.

