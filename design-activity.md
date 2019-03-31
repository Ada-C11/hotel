What classes does each implementation include? Are the lists the same?
- Each implementation includes three classes. 
1. CartEntry
2. ShoppingCart
3. Order
Write down a sentence to describe each class.
- CartEntry: this tracks each item wanting to be purchased and includes how many/price. 
- ShoppingCart: this tracks all items in one shopping cart.
- Order: this tracks ShoppingCart and its total price including sales tax. 
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
- ShoppingCart should store multiple CartEntries while Order stores the ShoppingCart in order to calculate the total price. 
What data does each class store? How (if at all) does this differ between the two implementations?
- CartEntry: unit price, quantity
- ShoppingCart: entries
- Order: Cart(ShoppingCart instance), total_price

What methods does each class have? How (if at all) does this differ between the two implementations?
- CartEntry: price (2)
- ShoppingCart: price (2)
- Order: total_price (Both)
- Implementation B adds a price instance method for CartEntry and ShoppingCart which is used to calculate total_price in Order. Implementation 2 does not directly modify a different classes' instance variable. 
Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
- It is delegated in Implementation B. 
Does total_price directly manipulate the instance variables of other classes?
- It does not directly manipulate the instance variable of other classes in Implementation B. 
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
- If items are cheaper in bulk, the CartEntry class would need to be modified in Implementation B. 
Which implementation better adheres to the single responsibility principle?
- Implementation B better adheres to the SRP.
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
- Implementation B.