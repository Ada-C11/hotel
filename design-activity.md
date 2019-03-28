## Activity: Evaluating Responsibility


***


**What classes does each implementation include? Are the lists the same?**


Both Implementation A and B contain classes CartEntry, ShoppingCart, and Order. Both lists are the same.

**Write down a sentence to describe each class.**

In Implementation A, Class Order is responsible for calculating total price based on information in the ShoppingCart and cost of each item in CartEntry. Whereas in Implementation B, ShoppingCart is responsible for calculating the total cost of all items in its cart and asks CartEntry how much each item costs. Class order simply asks the ShoppingCart for its total cost.

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

In Both Implementations, Class Order has a ShoppingCart (1 to 1), and the ShoppingCart has an array of CartEntries (1 to many). 

**What data does each class store? How (if at all) does this differ between the two implementations?**

Classes in both implementations store the same data. Class Order stores @cart, a ShoppingCart and SALES_TAX. ShoppingCart stores @entries, an array of CartEntry objects. CartEntry stores @unit_price and @quantity. The main difference is that in Implementation A, ShoppingCart and CartEntry both have attr_accessors for all the data they store. Where as in Implementaion B, there is no attr_accessors.


**What methods does each class have? How (if at all) does this differ between the two implementations?**

In Implementation A, the only method is in class Order, which calculates the entire cost of the order using information from each class. In Implementation B, each class has a price or total price method. Order's total price method asks ShoppingCart for its price, which in turn asks each CartEntry, their price. 

**Consider the Order#total_price method. In each implementation:**
* Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
* Does total_price directly manipulate the instance variables of other classes?

Implementation A: Logic is all done in Order, nothing is delegated to lower classes. total_price directly manipulates the instance variable in other classes
Implementation B: Logic is delegated to lower level classes, and total_price does not manipulate instance variables in other classes.

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

Implementation A: More logic would need to be added to total_price, it would also have to know even more about CartEntry, such as what constitutes bulk for each item.
Implementation B: CartEntry price would need to be updated to include bulk price, but no other changes would be needed. Much easier to modify than A

**Which implementation better adheres to the single responsibility principle?**

Implementation B adheres to the single responsibility principle, class order is responsible for calculating total cost of the shopping cart but not cost of each item in the cart. In A, Order also needs to calculate the cost of each individual item.

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

Implementation B is more loosely coupled because Order knows way less about the other 2 classes. It only knows how to call the price method, and knows nothing about CartEntry of anything about the instance variables in ShoppingCart. Attr_accessors are never used.



