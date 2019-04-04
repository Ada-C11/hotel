**What classes does each implementation include? Are the lists the same?**
Both implementations have the same classes - CartEntry, ShoppingCart, Order

**Write down a sentence to describe each class.**
CartEntry class creates instances of entries that will go into ShoppingCart.
Shopping Cart class contains all instances of CartEntries.
Order class calculates the price of all items in the ShoppingCart, including tax.

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**
ShoppingCart contains CartEntry, 1:many, 1 ShoppingCart contains many CartEntries
Order contains ShoppingCart, 1:1
There is no inheritance.

**What data does each class store? How (if at all) does this differ between the two implementations?**
CartEntry stores the unit_price, quantity, (and price of item, B only)
ShoppingCart stores the cart entries (and total cost of entries in the cart before tax, B only)
Order stores the instance of ShoppingCart and total price of the entries in the car including tax.

**What methods does each class have? How (if at all) does this differ between the two implementations?**
CartEntry has an initializer, (B only has a method that will calculate price of the entry).
ShoppingCart has an initializer, (B only has a price method to calculate the price of all entries in the cart).
Order has an initializer and a both implementations have a total_price method.

**Consider the Order#total_price method. In each implementation:**
 - Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
 In A, Order is calculating total price, but in B it is just calling the price method in ShoppingCart and then adding sales tax.
 - Does total_price directly manipulate the instance variables of other classes?
In A, total_price does directly manipulate the instance variables of CartEntry when it calculates price.

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**
Implementation B, because you could just change the CartEntry price method.

**Which implementation better adheres to the single responsibility principle?**
Implementation B

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**
Implementation B is more loosely coupled, it knows less about other classes, particularly Order knows less about CartEntry.


**Changes to Hotel**
In my refactoring file I had wanted to include another parameter in Reservation so that when a block of rooms is created it would just say it was a block, but it could then be changed when that room was reserved. I assumed that I could just make that change from a method in ReservationManager, but thinking about it more that would mean that ReservationManager was manipulating the instance variables of another class. I figured out that I could write a method in Reservation that makes this change and I can just call that method from ReservationManager.

By making the above change, I'll have to refactor a number of methods in ReservationManager. This should streamline my methods in ReservationManager.