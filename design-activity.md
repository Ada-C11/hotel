What classes does each implementation include? Are the lists the same?
    They both include a CartEntry, ShoppingCart, and Order class.

Write down a sentence to describe each class.
    CartEntry instances represent a product to be purchased and stores the quantity and price.
    ShoppingCart holds a list of CartEntry instances
    Order creates a shopping cart

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    Order has one shopping cart and shopping cart has many cart entries

What data does each class store? How (if at all) does this differ between the two implementations?
    CartEntry stores the unit price and quantity of each product an instance represents
    ShippingCart holds an array of CartEntries 

What methods does each class have? How (if at all) does this differ between the two implementations?
    They all have initialize methods in both implementations.
    Each method in Implementation B has a price method that does certain calculations based on the info it has access to. Meanwhile, Implementation A combines all these calculations into one method in the Order class

Consider the Order#total_price method. In each implementation:
    Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
        Implementation A - retained in Order
        Implementation B - delegated to "lower level" classes


    Does total_price directly manipulate the instance variables of other classes?
        Implementation A - yes
        Implementation B - no

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    Implmentation B is easier to modify because only the price method in CartEntry needs to be changed. A conditional could be added that states if @quantity is >= a certain number then subtract a certain portion from each unit price.

Which implementation better adheres to the single responsibility principle?
    Implementation B because each class knows and does the bare minimum that it needs to. Order will eventually need to calculate the total price but it doesn't have to have the mechanisms to do that at each layer within it the way it does in Implementation A. It can pull the subtotal from the other classes but it doesn't need to know how exactly that subtotal is generated, which is what's happening in Implementation B.

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    Implementation B is more loosely coupled because there is some communication happening between the classes but each is manipulating its own data. In Implementation A Order reaches into the other classes to directly access their instance variables. If something were to change in the lower classes then that would change Order too.
