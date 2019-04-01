# What classes does each implementation include? Are the lists the same?
Both include: CartEntry, ShoppingCart, Order
# Write down a sentence to describe each class.
A1. CartEntry: identifying attr_accessor components; initialize instance variables for unit_price/quantity
A2. ShoppingCart: initialize :entry/set default to an array
A3. Order: constant of SALES TAX; new instance of @cart, sales tax at 0.07. includes method to calculate total_price/init price/quantities
B1. CartEntry: initialized instance variables for unit_price/quantities and includes method for calculating price
B2. ShoppingCart: Initialize instance variables for all entries/set default to an array and includes method to calculate price
B3. Order: constant of SALES_TAX/ initialized instance variables set equal to new ShoppingCart class, includes method to calculate total price
# How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Ultimately this code would be used for a shopping situation. In A: CartEntry Class is passed into ShoppingCart and its instances of arrays. Order class passes a new ShoppingCart class into an instance of cart. In Order Class, each entry in the array of Shopping cart is passed (looped) through for each entries unit_price/quantity of the attributes of CartEntry class. In B: CartEntry class has attributes unit_price/quantity/ has a method of price. ShoppingCart has instances of entries, and can return the sum of itself with the method price. Order has instances of carts, assigned to new instances of the ShoppingCart class. Order can calculate it's total_price by calling the price method on the instance of the ShoppingCart class.
 # What data does each class store? How (if at all) does this differ between the two implementations? 
 The data in both classes are the same minus A includes the attr_accessors of both CartEntry/ShoppingCart
 # What methods does each class have? How (if at all) does this differ between the two implementations?
 A has the Order class as the Parent class, getting prices of related classes for CartEntry/ShoppingCart. It can calculate the total price in the method to calculate it in the Order class. B works price in differently within classes as it uses it in each one, taking away the extra responsibility from Order.
 # Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
 Implementation A does not delegate computation to "lower level" classes and retains it in Order. Implementation B does the opposite of this. 
# Does total_price directly manipulate the instance variables of other classes?
Implementation A does manipulate the instance variables of other classes by passing through each entry [ShoppingCart Class attribute] then, each entry's unit_price/quantity [CartEntry Class attributes]. Implementation B does the opposite of this.
# If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
B would definitely be easier to modify because each entry can be easily calculated per method.
# Which implementation better adheres to the single responsibility principle?
B
# Which implementation is more loosely coupled?
Definitely B 