What classes does each implementation include? Are the lists the same?
- Classes in Implementation A
    - CartEntry
    - Shopping Cart
    - Order
- Classes in Implementation b
    - CartEntry
    - Shopping Cart
    - Order
- They utilize the same classes.

Write down a sentence to describe each class.
- Implementation A
    - The CartEntry class holds a unit price and a quantity.
    - The Shopping Cart class holds various cart entries
    - The Order class's initialize method creates a new instance of  a cart and calculates the total price of a cart with its entries.
- Implementation B
    - The CartEntry class holds a unit price and a quantity and has a method which calculates price.
    - The ShoppingCart class holds cart entries and caluclates the sum/price of those.
    - The Order class's initialize method creates a new instance of  a cart and calculates the subtotal price of a cart with its entries.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    - Cart Entry class creates a new instance of an entry in the cart in which unit prices and quantities of items are parameters at every initialization. The Shopping Cart class holds all of the cart entries as an array and totals that array. The Order class takes the Shopping cart and adds sales tax to it, giving the final total.

What data does each class store? How (if at all) does this differ between the two implementations?
    - CartEntry: In implementation A it stores price. In B it does not.
    - Shopping Cart: In B it stores price. In A it does not.
    - Order: B creates a new instance of cart in this class. A creates a new cart instance in the ShoppingCart class.

What methods does each class have? How (if at all) does this differ between the two implementations?
    - Each implementation has methods that calculate the price at various points in an order. (individual price of item, total price of cart, totlal price with tax added) In which class price is calculated differs between the two implementations.

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?
    - In implementation A logic to determine price is retained in Order. In implementation B that logic is delegated to ShoppingCart. Implementation A's total_price method manipulates the @entries array that holds instances of entry.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    - The code already accounts for unit price and quantity,so all that would need to change is the unit price fro bulk items. Implementation A would be easier to change.


Which implementation better adheres to the single responsibility principle?
    - Implementation A

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    - Implementation B