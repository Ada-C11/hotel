What classes does each implementation include? Are the lists the same?
Implementation A:
classes: CartEntry, ShoppingCart, Order

Implementation B:
classes: CartEntry, ShoopingCart, Order


Write down a sentence to describe each class.
* CartEntry initializes each entry with price and quantity.
* ShoppingCart initializes an array that keeps track of entries.
* Order initializes ShoppingCart and returns the total price. 


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

Implementation A:
* CartEntry holds the information about each entry's price and quantity.
* ShoppingCart stores all entries, but needs to access CartEntry for price and quantity info.
* Order initializes ShoppingCart as the instance variable @cart, giving it access to @entries.
* From Order, total_price retrieves entries from ShoppigCart, unit_price and quantiry from CartEntry

Implementation B:
* CartEntry calculates each entry's price and quantity and makes it accessible through .price.
* ShoppingCart stores stores all entries, calculates their sum, and makes it accessible through .price.
* Order initializes ShoppingCart as @cart and retrieves price from ShoppingCart to calculate de total_price with tax.

What data does each class store? How (if at all) does this differ between the two implementations?

Implementation A:
CartEntry: @unit_price, @quantity
ShoppingCart: @entries
Order: @cart, SALES_TAX

Implementation B:
CartEntry: @unit_price, @quantity, .price(per item)
ShoppingCart: @entries
Order: SALES_TAX, @cart


What methods does each class have? How (if at all) does this differ between the two implementations?

Implementation A
CartEntry: initialize
ShoppingCart: inilialize
Order: initialize, total_price

Implementation B
CartEntry: initialize, price (per entry)
ShoppingCart: inilialize, price (total pre-tax)
Order: initialize, total_price (total with tax)

Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In implementation A, the logic is delegated to ShoppingCart(entries) and CartEntry(unit_price and quantity).
In implementation B, the logic is retained in Order.


Does total_price directly manipulate the instance variables of other classes?
It does in implementation A.

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
Implementation B would be easier to modify, since the code would only change in one place, probably .price in CartEntry.

Which implementation better adheres to the single responsibility principle?
Implementation B

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B