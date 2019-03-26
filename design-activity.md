# Design Activity

Question | Answer
---     | ---
What classes does each implementation include? Are the lists the same?|Implementation A includes class `CartEntry`, `ShoppingCart`, and `Order`. Implmentation B also includes the same classes.
Write down a sentence to describe each class.|`CartEntry` represents each time a customer add an item into a cart. For example, customer can add two books (price of $2.00 per book). This is considered one cart entry. `ShoppingCart` represents the customer's final shopping list, including all the items added to cart. `Order` represents the customer's final bill.
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.|`ShoppingCart` has multiple `CartEntry` instances stored in an array called `entries`.`Order` has the finalized `ShoppingCart` instance and use the information from that instance to calculate the final bill with sales tax. 
What data does each class store? How (if at all) does this differ between the two implementations?|`CartEntry` knows about one single product (its price and quantities). `ShoppingCart` knows about multiple `CartEntry` objects and stores them in an array called `entries`. `Order` knows about one single `ShoppingCart`. Implementation A reveals information about class `CartEntry` all the way down to the `Order` class when the `Order` class tries to calculate the final bill. Implementation B, however, hides the attributes of `CartEntry` class by adding a helper function `price` in the `ShoppingCart` class to calculate the total price of all the items in the cart. 
What methods does each class have? How (if at all) does this differ between the two implementations?|In implementation A, class `CartEntry` and class `ShoppingCart` only have public constructors. Class `Order` has a public constructor and handles all of the calculations of the final bill through `total_price` method.
Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
Does total_price directly manipulate the instance variables of other classes?
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Which implementation better adheres to the single responsibility principle?
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?