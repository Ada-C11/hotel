What classes does each implementation include? Are the lists the same?

Each implementation includes the following classes:
CartEntry
ShoppingCart
Order

Yes, the lists are the same.

Write down a sentence to describe each class.
Implementation A:
CartEntry - this class tracks the unit price and quantity of an item.
ShoppingCart - this class tracks the items added to the shopping cart in an array.
Order - This order takes all the items entered into the ShoppingCart class and calculates the order's total including sales tax.

Implementation B:
CartEntry - similar to Imp A, this also tracks the unit price and quantity of an item.  In addition, it calculates the price for the items.
ShoppingCart - same as Imp A but this class also calculates the sum of each entry into the ShoppingCart.
Order - calculates order's total including sales tax.

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

In both Implementations, the CartEntry and ShoppingCart are used in the Order to calculate the total for all the items.

What data does each class store? How (if at all) does this differ between the two implementations?

Implmentation A:
CartEntry - unit price and quantity of item
ShoppingCart - all items added
Order - sales tax, ShoppingCart items, total price for an order

Implementation B:
CartEntry - same as A but also price of total quantity of each item
ShoppingCart - same as A but also sum of all the items added
Order - same as A

What methods does each class have? How (if at all) does this differ between the two implementations?

Implementation A:
CartEntry - initialize method
ShoppingCart - initialize method
Order - initialize method, total_price method

Implmentation B:
CartEntry - initialize method, price method (differs from A)
ShoppingCart - initialize method, price method (differs from A)
Order - initialize, total_price method

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

In Implementation A, it is retained in the Order but in Implementation B, it is delegated to "lower level" classes.

Does total_price directly manipulate the instance variables of other classes?

No, in both implementations, it is only providing the total for the order.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

I would think that the CartEntry class would be the easiest to change to reflect a cheaper price for bulk items.  If the changes are made in this class, it would be equally easier to modify.

Which implementation better adheres to the single responsibility principle?

Implementation A better adheres to the single responsibility principle because in Implementation B, all items are being tracked in addition to the price.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled

Implementation B is more loosely coupled.