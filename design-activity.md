**Shopping cart example**

What classes does each implementation include? Are the lists the same?
    Implementation A includes CartEntry, ShoppingCart, and Order classes.
    Implementation B includes CartEntry, ShoppingCart, and Order classes.
    The lists are the same.

Write down a sentence to describe each class.
    Implementation A
        CartEntry: Handles the unit price and quantity
        ShoppingCart: Holds all cart entries
        Order: Creating new shopping cart and calculating total price
    Implementation B
        CartEntry: Handles the unit price, quantity, and calculates cart entry total
        ShoppingCart: Holds all cart entries and calculates cart subtotal
        Order: Creating new shopping cart and calculating total price

How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    Implementation A: Order uses CartEntry and ShoppingCart to calculate total and create cart
    Implementation B: Order user ShoppingCart to create new cart    

What data does each class store? How (if at all) does this differ between the two implementations?
    CartEntry: unit price and quantity
    ShoppingCart: entries
    Order: new shopping cart

What methods does each class have? How (if at all) does this differ between the two implementations?
    Implementation A
        CartEntry: no methods
        ShoppingCart: no methods
        Order: total price
    Implementation B
        CartEntry: price
        ShoppingCart: price
        Order: total price

**Consider the Order#total_price method. In each implementation:**
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    Implementation A: price is not delegated and is retained in Order
    Implementation B: price is delegated

Does total_price directly manipulate the instance variables of other classes?
    Implementation A: yes, entries, unit price, and quantity
    Implementation B: no

If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    If I'm understanding bulk correctly, then this would change the Cart Entry class and how it handles unit price based on quantity. Implementation B would be easier to modify.

Which implementation better adheres to the single responsibility principle?
    Implementation A: Not so good at this
    Implementation B: Does single responsibility better

Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    Implementation A: Not so loose
    Implementation B: Much more loose


**HOTEL REVISITED**
My Hotel class directly manipulates the instance variables of the Reservation class. For my refactor, I would like to remove this coupling and instead create a method (or two) in the Reservation class, so that Hotel knows fewer specifics about Reservation. This would affect the following methods in Hotel: add_reservation, list_reservations_by_date_range, and list_available_rooms.

