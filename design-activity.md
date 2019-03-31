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
Revisiting Hotel prompts: Now that we've got you thinking about design, spend some time to revisit the code you wrote for the Hotel project. For each class in your program, ask yourself the following questions:

Reservation class: 
1. What is this class's responsibility? (You should be able to describe it in a single sentence)
    1. Responsibility is to hold all the instance variables for reservation and  calculates the total cost of the trip. 
2. Is this class responsible for exactly one thing?
    1. Yes. 
3. Does this class take on any responsibility that should be delegated to "lower level" classes?
    1. No 
4. Is there code in other classes that directly manipulates this class's instance variables?
    1. Yes, ReservationManager creates an instance of Reservation, which requires all of the class' instance variables. The HotelBlock method in ReservationManager also directly uses all the instance variables from Reservation. 

ReservationManager class:
1. What is this class's responsibility? (You should be able to describe it in a single sentence.)
    1. It manages all instances of Reservation and HotelBlock reservations
2. Is this class responsible for exactly one thing?
    1. No
3. Does this class take on any responsibility that should be delegated to "lower level" classes?
    1. Yes, it creates a HotelBlock which could be a lower level class (I would need to create a new HotelBlock class)
4. Is there code in other classes that directly manipulates this class's instance variables?
    1. No.

-------------------------------
You might recall writing a file called refactor.txt. Take a look at the refactor plans that you wrote, and consider the following:

1. How easy is it to follow your own instructions?
    1. Easy to follow 
2. Do these refactors improve the clarity of your code?
    1. Yes
3. Do you still agree with your previous assessment, or could your refactor be further improved?
    1. I agree with them, but now I see larger changes (adding a HotelBlock class). The changes I suggested were smaller changes within the exiting classes (naming conventions and some logic changes)