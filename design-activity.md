1. What classes does each implementation include? Are the lists the same?
    1. Implementation A: CartEntry, ShoppingCart, Order 
    2. Implementation B: CartEntry, ShoppingCart, Order 
    3. Yes, each implementation has 3 classes which have the same names 
2. Write down a sentence to describe each class.
    1. Implementation A:
        1. CartEntry class: Initialized with a unit price and a quantity.
        2. ShoppingCart class: Initialized with an empty array called @entries.
        3. Order class: Initialized with a new instance of cart. It has a method called total_cost which calculates the total cost of all the items in the cart and adds sales tax.  
    2. Implementation B:
        1. CartEntry class: Initialized with a unit price and a quantity, it has a price method which returns the unit price * quantity
        2. ShoppingCart class: Initialized with an empty array called @entries, it has a method price, which returns the total cost of the items in the cart using the price method from CartEntry class 
        3. Order class: Initialized with a new instance of cart. It has a total_price method which returns the total price of the cart using the price method from CartEntry. 
3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    1. Implementation A: CartEntry and ShoppingCart hold data that Order uses to calculate the total price. 
    2. Implementation B. CartEntry has data and a price method that ShoppingCart uses to calculate the total price of the items in the cart. Order uses the total price method from Shopping cart to calculate the total cost of the order. 
4. What data does each class store? How (if at all) does this differ between the two implementations?
    1. Implementation A. 
        1. CartEntry: unit price, quantity 
        2. ShoppingCart: entries array 
        3. Order: sum 
    2. Implementation B.
        1. CartEntry: unit price, quantity 
        2. ShoppingCart: entries array 
        3. Order: sum 
5. What methods does each class have? How (if at all) does this differ between the two implementations?
     1. Implementation A. 
        1. CartEntry: none
        2. ShoppingCart: none 
        3. Order: total_price 
    2. Implementation B.
        1. CartEntry: price
        2. ShoppingCart: price 
        3. Order: total_price
    3. In Implementation A, only Order has methods and all calculations are done in that class. In B, all the classes have methods that relate to the data stored in that method. 
6. Consider the Order#total_price method. In each implementation:
    1. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
        1. In Implementation A, the logic is all in the Order class.
        2. In Implementation B, the logic is delegated to the lower level classes
    2. Does total_price directly manipulate the instance variables of other classes?
        1. In Implementation A, the total_price method directly manipulates the instance variables from the other classes
        2. In Implementation B, the total_price method uses the price method from the other classes and doesn't directly manipulate the other classes' instance variables. 
7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    1. If items are cheaper if bought in bulk, we could add a bulk price method to the CartEntry class. This would be easier to modify in Implementation B, since the price is determined for each cart item in that class. 
8. Which implementation better adheres to the single responsibility principle?
    1. Implementation B better adheres to the single responsibility principle. CartEntry calculates the price of items in the cart, ShoppingCart calculates the sum of all the items in the cart, and order calculates the total order including tax. In Implementation A, this is all done in the Order class (the lower level classes just hold the data).
9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    1. Implementation B is more loosely couples because it doesn't directly manipulate an instance variable from a lower level, instead it calls on a method from the other classes.

-------------------------
Revisiting Hotel - changes to make: 

For the design activity I originally tried moving the hotel_block method into its own class, HotelBlock. 

I found that this caused my code to become more tightly coupled than it was before refactoring since it needed to know about information from the ReservationManager class to be able to create a block like if any of the rooms in the block were already booked from a traditional reservation. I decided not to keep those changes. Instead, I refactored my code using the instructor feedback and notes I had made in the refactor.txt file. 
