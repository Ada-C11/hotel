- What classes does each implementation include? Are the lists the same?

Both implementations have `CartEntry`, `ShoppingCart`, and `Order` classes.

- Write down a sentence to describe each class.

`CartEntry` keeps track of individual items in the cart.

`ShoppingCart` keeps track of all items in the cart.

`Order` keeps track of the total price for all items in the cart.

- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

Each order has one shopping cart which can have zero, one, or many entries.

- What **data** does each class store? How (if at all) does this differ between the two implementations?

`CartEntry` stores `unit_price` and `quantity`

`ShoppingCart` stores an array of `CartEntry` objects

`Order` stores a `ShoppingCart` object and `SALES_TAX`

Both implementations store the same data in each class.

- What **methods** does each class have? How (if at all) does this differ between the two implementations?

`CartEntry` has initialize methods in both implementations, and a price method in implementation B.

`ShoppingCart` has initialize methods in both implementations, and a price method in implementation B.

`Order` has initialize and total_price methods in both implementations.

- Consider the `Order#total_price` method. In each implementation:
    - Is logic to compute the price delegated to "lower level" classes like `ShoppingCart` and `CartEntry`, or is it retained in `Order`?

    In implementation B, logic to compute the price is delegated to lower level classes, whereas this is not done in implementation A.

    - Does `total_price` directly manipulate the instance variables of other classes?

    Yes, it does in implementation A. It does not in implementation B.

- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

A condition would need to be added to check the quantity and modify the unit price when the quantity is over a certain number. This would be easier to modify in implementation B. In implementation B, the `CartEntry#price` method can be directly modified, whereas in implementation A, `Order#total_price` would need to be modified. 

- Which implementation better adheres to the single responsibility principle?

Implementation B better adheres to the single responsibility principle. In implementation A, `Order#total_price` is doing all the work of calculating all prices when this can be delegated to the lower level classes. 

- Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Implementation B is more loosely coupled. 

---

**Identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe what changes you would need to make to improve this design, and how the resulting design would be an improvement.**

My Booking class is performing multiple roles. Booking#find_reservation could have its functionality moved to Reservation. This would loosen the currently tight coupling.