**What classes does each implementation include? Are the lists the same?**
- Implementation A includes: CartEntry, ShoppingCart, Order 
- Implementation B inclus the same classes as A 

**Write down a sentence to describe each class**
- CartEntry stores the unit price and quantity of items 
- ShoppingCart stores an array of CartEntry instances 
- Order calculates the total cost of all items in the ShoppingCart

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper** 
-Order has a ShoppingCart, ShoppingCart has many Cart entries , and CartEntry doesn't rely in the other classes

**What data does each class store? How (if at all) does this differ between the two implementations?**
- Both implementations have initialize methods in all clasess. In A, CartEntry and ShoppingCart only store states as they 
onft have methos. Order has the total price methos. In B, CartEntry and ShoppingCart both have a price ethod and Order has
Total price method 

**Consider the Order#total_price method. In each implementation:**
**Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**
- In implentation A, logic to compute price is retained in orde. In B the logic to compute price is delegated to other classes
at a "lower level"

**Does total_price directly manipulate the instance variables of other classes?** 
- In A total_price manipulates the instance variables in CartEntry by multipliying the unit price and quantity. In B,total_price 
does not directly manipulate the intance variables of other clases 

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**
- If we decide itemas are cheaper in bulk, code in CartEntry class should change (possible add a conditionl). Implentation B 
is easier to modify since we would be working directly with CartEntry and making small adjusments, feels A will be a little mess 

**Which implementation better adheres to the single responsibility principle?**
- Implementation B 

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**
- Implementation B is more loosely coupled, Changing the functionaly in one class (CartEntry) does not affect or cause change in 
other classses, classes in B call on the methos of the other classes instead of directly manipulate their state
