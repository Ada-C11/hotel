1. What classes does each implementation include? Are the lists the same?

Both Implementation includes the following classes:
- CartEntry
- ShoppingCart
- Order
The two lists are the same.

2. Write down a sentence to describe each class.
- CartEntry class defines the object "CartEntry" representing a product with unit_price and quantity.
- ShoppingCart class defines the object "ShoppingCart", shopping cart can have multiple entries
- Order class defines the object "Order" and this object has an instance of cart and a total_price of all cart entries

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
- ShoppingCart class keeps track of all entries, each instance of entry is stored in class CartEntry.
- Order class stores an instance of ShoppingCart. An order instance has a total price calculated by taking each entry unit price multiplies with the entry's quantity.

4. What data does each class store? How (if at all) does this differ between the two implementations?
- The CartEntry class stores an entry and the entry's unit price and quantity. In implementation A, this class only store the state of an entry (unit price and quantity). In implementation B, this class stores both state(unit price and quantity) and behavior(price)
- The ShoppingCart class stores different entries.In A, this class only store the state of an cart (a collections of entries). In B, this class stores both state(a collections of entries) and behavior or cart(price of all entries)
- The Order class stores the total price of a cart. In A, the order class handle the calculation of total price while in B, the order class only call the price method from cart class.


5. What methods does each class have? How (if at all) does this differ between the two implementations?
A has 1 method total_price in class Order. This method uses the unity price and quantity from entry and the number of entries from class ShoppingCart to calculate the total price of an order. This is different from implementation B as B has 3 methods: 
    - 1st method: price in class CartEntry
    - 2nd method: price in class ShoppingCart - price per cart is calculated by calling the price method in CartEntry
    - 3rd method: price in class Order - total price is calculate by calling the price method in ShoppingCart

6. Consider the Order#total_price method. In each implementation:
    a. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order? 
        - In A, the logic to compute the price is retained in Order
        - In B, the logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry

    b.Does total_price directly manipulate the instance variables of other classes?
        -In A, the total_price directly manipulate the instance variables
        -In B, the total_price indirectly manipulate the instance variables
9. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
- If items are cheaper if bought in bulk, we need to change the price of the item to a discount price and implementation B is easier to modify since we can just add logic to the price method (i.e, if quantity meets the bulk requirement then use discount price)
10. Which implementation better adheres to the single responsibility principle? Implementation B
11. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled? Implementation B

Activity:
In my hotel application, the ReservationTracker class is doing the bulk of the work. Some of the behaviors such as checking if reservation/block dates are overlap or checking if reservation has the same dates as a block should be part of the Reservation class or HotelBlock class instead of the ReservationTracker class. To make this update, I moved the is_overlap? and same_daterange? methods from ReservationTracker class to Reservation class and HotelBlock class.