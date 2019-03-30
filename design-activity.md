1. What classes does each implementation include? Are the lists the same?

    Implementation A: 
        - CartEntry
        - ShoppingCart
        - Order
    Implementation B:
        - CartEntry
        - ShoppingCart
        - Order

    Yes, the lists are the same.

2. Write down a sentence to describe each class.
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

    Implementation A:

    - CartEntry
        Creates a new object of the CartEntry class and accessor methods for unit_price and quantity.
    - ShoppingCart
        Creates a new object of the ShoppingCart class and the accessor method for entries.
    - Order
        Creates a new object of the Order class that "contains" an object of the ShoppingCart class. 
        It calculates the price for each entry in the shopping cart, totalizes the whole cart value and returns the total amount plus taxes. 
        
    The class Order manipulates data in the classes CartEntry and ShoppingCart to calculate the total_price.

    Implementation B

    - CartEntry
        Creates a new object of the CartEntry class.
        Calculates price multiplying the unit_price by quantity.
    - ShoppingCart
        Creates a new object of the ShoppingCart class.
        Calculates the price for all the entries stored in the collection @entries by adding up the price per each entry.
    - Order    
        Creates a new object of the Order class that "contains" an object of the ShoppingCart class.
        Calculates the total price by taking the total price per cart and adding the tax value to it.

    Each class manipulates their own data to make their part on the calculation of the total_price independently. 
        

3. What data does each class store? How (if at all) does this differ between the two implementations?

    Implementation A: 
        - CartEntry
            -> unit_price
            -> quantity
        - ShoppingCart
            -> collection of entries
        - Order
            -> cart that contains the entries 
            -> calculation of the price per each entry 
            -> the total price for all entries
            -> the total price including taxes for all entries

    Implementation B:
        - CartEntry
            -> unit_price
            -> quantity
            -> price per entry
        - ShoppingCart
            -> collection of entries
            -> the total value for all the entries
        - Order
            -> cart that contains the entries 
            -> the total value of the cart
            -> the total price including taxes

4. What methods does each class have? How (if at all) does this differ between the two implementations?

    Implementation A:
        - CartEntry
            * initialize
            * accessor unit_price and quantity
        - ShoppingCart
            * initialize
            * accessor entries
        - Order
            * initialize
            * total_price

    Implementation B:
        - CartEntry
            * initialize
            * price
        - ShoppingCart
            * initialize
            * price
        - Order
            * initialize
            * total_price

    The difference between the two is that in implementation A there is direct access to all the data, while in implementation B the classes have access specifically to the portion of data pertaining the price.


5. Consider the Order#total_price method. In each implementation:

    5.1. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

        - Delegation of logic to ShoppingCart and CartEntry happens in implementation B.

    5.2. Does total_price directly manipulate the instance variables of other classes?

        - Manipulation of instance variables of other classes happen in implementation A.


6. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

    - We need to determine how many items are considered "bulk" and add a conditional statement for quantity to where the price per entry is calculated. 
       
        if quantity >= bulk 
            discount = unit_price * 0.10
            unit_price -= discount
        end

    - Implementation B will make this change easier because it will affect the price right after the entry is created and not at the end when iterating through each entry in the cart. 


7. Which implementation better adheres to the single responsibility principle?

    - Implementation B: because it handles the state and behavior of the instances of each class.

8. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

    - Implementation B is more loosely coupled.
