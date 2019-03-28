`What classes does each implementation include? Are the lists the same?`

Each implementation includes the classes CartEntry, ShoppingCart, and Order.

`Write down a sentence to describe each class.`

CartEntry represents the unit price and quantity of each item being added to the shopping cart.
ShoppingCart contains a list of items and their associated quantities.
Order calculates the total price for all the items in the shopping cart.

`How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.`

Each Order has a ShoppingCart, and a ShoppingCart has many CartEntry objects.

`What data does each class store? How (if at all) does this differ between the two implementations?`

In both implementations, a CartEntry stores an unit price and a quantity, a ShoppingCart contains an array of CartEntry objects, and an Order holds one ShoppingCart object and a constant representing sales tax in some magical area that is much cheaper than Seattle.

`What methods does each class have? How (if at all) does this differ between the two implementations?`

in Implementation A, only Order has a method (total_price). In Implementation B, all three classes have methods: CartEntry has a price method, as does ShoppingCart, and Order has a total_price method.

`Consider the Order#total_price method. In each implementation:`
`Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?`

In A, Order is the only class that calculates a price. In B, each class calculates a price for its own data.

`Does total_price directly manipulate the instance variables of other classes?`

In A, total_price accesses data held in the @unit_price and @quantity for each entry in @cart.entries. In B, each class is responsible for calculating a price, and total_price only asks for the result of ShoppingCart's price method.

`If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?`

The CartEntry class would have to incorporate a bulk rate (probably a constant) for item quantities over a certain number, and the price method would have to use the bulk rate in its calculations when item quantities met the pricing threshold. Implementation B would be easier to change in this way because the price method could be changed in CartEntry to account for different pricing levels.

`Which implementation better adheres to the single responsibility principle?`

Implementation B. The classes in B are each responsible for knowing their own price methods, and one class doesn't need to dive into another's instance variables to perform any calculations.

`Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?`

B, again, because it doesn't require the Order class to know anything about the state of ShoppingCart in order to calculate total_price. It would be easy to change ShoppingCart or CartEntry without needing to change anything about Order.
