# Hotel
## Design Activity

**What classes does each implementation include? Are the lists the same?**
Both implementations use classes: CartEntry, ShoppingCart, and Order; both lists are the same.

**Write down a sentence to describe each class.**
For both:
CartEntry - Keeps track of one particular item: its price & quantity to be purchased.
ShoppingCart - Holds all instances of CartEntry.
Order - Instantiates a ShoppingCart and calculates the total price of order.

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**
For both:
Each Order has 1 ShoppingCart (one-to-one relationship),
and each ShoppingCart has many (or one, or none) CartEntry (one-to-many relationship).

**What data does each class store? How (if at all) does this differ between the two implementations?**
For both:
CartEntry - @unit_price & @quantity of each distinct item.
ShoppingCart - an array of CartEntry instances named @entries.
Order - an instance of ShoppingCart named @cart, and SALES_TAX
Implementation A has attr_accessor for CartEntry & ShoppingCart for read/write access from outside of the class, while implementation B does not.

**What methods does each class have? How (if at all) does this differ between the two implementations?**
Both: Each class has an initialize class and Order has `total_price`
In addition, Implementation B has a `price` method for each CartEntry and ShoppingCart. The logic of calculating total order price is broken down by calling ShoppingCart's `price` which in turn calls CartEntry's `price`.

**Consider the Order#total_price method. In each implementation:**
**Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**
In implementation A, this logic is retained in Order, whereas in implementation B, it is delegated to lower level classes.

**Does total_price directly manipulate the instance variables of other classes?**
In implementation A, total_price directly manipulates instance variables of other classes (through attr_accessor).
Implementation B does not.

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**
Implementation B seems easier and cleaner to modify, as you can update CartEntry to be priced at bulk price if a certain quantity is met, while all other methods that rely upon it run as usual, still only knowing about themselves.
In implementation A however, we need to make the change in two places. We may want to update implementation A's CartEntry to provide attr_accessor for bulk pricing's unit_price and quantity. We will also need to update the logic for Order's `total_price` by adding conditionals for bulk pricing. 

**Which implementation better adheres to the single responsibility principle?**
Implementation B appears more neatly compartmentalized. The usage of helper method `price` appropriately returns total price of each entry,allowing CartEntry to calculate and access its own total price; likewise for ShoppingCart. 
In implementation A, these calculations are done through attr_accessor, jumbled together in Order's `total_price`.

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**
Implementation B is more loosely coupled. Each class only knows about itself.

Metz ch. 4 would also agree on the basis of not granting read/write access unnecessarily (keeping things hidden so they won't inadvertently get broken by future changes). Brownie points: Implementation B uses explicit returns.

**Updates to Hotel**
Having a DateRange class that can validate a given date range, can check for overlap, and can calculate the number of nights stayed makes sense, as these responsibilities are directly pertinent to DateRange's attributes, and are currently interspersed as additional responsibilities of other classes. Having DateRange as its own class will also come in handy in implementing of block-booking (which will require the same functionalities), to keep my code DRY. The resulting code would better adhere to the single-responsibility principle.