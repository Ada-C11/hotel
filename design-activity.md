1. What classes does each implementation include? Are the lists the same?
    1. Implementation A: CartEntry, ShoppingCart, Order 
    1. Implementation B: CartEntry, ShoppingCart, Order 
    1. Yes, each implementation has 3 classes which have the same names 
1. Write down a sentence to describe each class.
    1. Implementation A:
        1. CartEntry class: Initialized with a unit price and a quantity.
        1. ShoppingCart class: Initialized with an empty array called @entries.
        1. Order class: Initialized with a new instance of cart. It has a method called total_cost which calculates the total cost of all the items in the cart and adds sales tax.  
    1. Implementation B:
        1. CartEntry class: Initialized with a unit price and a quantity, it has a price method which returns the unit price * quantity
        1. ShoppingCart class: Initialized with an empty array called @entries, it has a method price, which returns the total cost of the items in the cart using the price method from CartEntry class 
        1. Order class: Initialized with a new instance of cart. It has a total_price method which returns the total price of the cart using the price method from CartEntry. 
1. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    1. Implementation A: CartEntry and ShoppingCart hold data that Order uses to calculate the total price. 
    1. Implementation B. CartEntry has data and a price method that ShoppingCart uses to calculate the total price of the items in the cart. Order uses the total price method from Shopping cart to calculate the total cost of the order. 
1. What data does each class store? How (if at all) does this differ between the two implementations?
    1. Implementation A. 
        1. CartEntry: unit price, quantity 
        1. ShoppingCart: entries array 
        1. Order: sum 
    1. Implementation B.
        1. CartEntry: unit price, quantity 
        1. ShoppingCart: entries array 
        1. Order: sum 
1. What methods does each class have? How (if at all) does this differ between the two implementations?
     1. Implementation A. 
        1. CartEntry: none
        1. ShoppingCart: none 
        1. Order: total_price 
    1. Implementation B.
        1. CartEntry: price
        1. ShoppingCart: price 
        1. Order: total_price
    1. In Implementation A, only Order has methods and all calculations are done in that class. In B, all the classes have methods that relate to the date stored in that method. 
1. Consider the Order#total_price method. In each implementation:
    1. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    1. Does total_price directly manipulate the instance variables of other classes?
1. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
1. Which implementation better adheres to the single responsibility principle?
1. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?