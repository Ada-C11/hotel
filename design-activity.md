1. What classes does each implementation include? Are the lists the same?

  Both implementations include the following classes: CartEntry, ShoppingCart, Order

  The lists are the same in both classes

2. Write down a sentence to describe each class.

  Implementation A:
  CartEntry: Dictates the attributes an item needs to be put in the cart.
  ShoppingCart: Stores in entries array, the entries from CartEntry (An assumption since there is no method in ShoppingCart that invokes CartEntry and there is not an inheritance relationship between the two classes either.)
  Order: Sums up all entries in ShoppingCart and applies Sales Tax to calculate total price.

  Implementation B:
  CartEntry: Dictates the attributes an item needs to be put in the cart and returns the unit_price of items times quantity.
  ShoppingCart: Sums up all of the entries in Cart.
  Order: Applies the Sales Tax to the price method from ShoppingCart to calculate total_price.


3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

    Implementation A:
    Order relies on both ShoppingCart and CartEntry to calculate the total price. It has access to the unit_price and quantity instance variables in CartEntry and to the entries array in ShoppingCart.

    ShoppingCart relies on CartEntry to populate its entries array.

    Implementation B:
    CartEntry has the unit_price and quantities of each item and caluclates the price.
    ShoppingCart relies on entries from CartEntry.
    Order relies on ShoppingCart to sum up all the entries in the cart so it can apply sales tax and calculate the total price.

4. What data does each class store? How (if at all) does this differ between the two implementations?

    Implementation A:
    CartEntry: unit_price and quantity
    ShoppingCart: entries []
    Order: sales_tax, unit_price, quantity, entries []

    Implementation B:
    CartEntry: unit_price, quantity, price method.
    ShoppingCart: entries[], method to sum entries.
    Order: sales_tax, total_price method.


5. What methods does each class have? How (if at all) does this differ between the two implementations?

    Implementation A:
    CartEntry: initialize
    ShoppingCart: initialize
    Order: initialize, total_price

    Implementation B:
    CartEntry: initialize, price
    ShoppingCart: initialize, price
    Order: initialize, total_price

6. Consider the Order#total_price method. In each implementation:
  6a. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

    In implementation A, all the logic to calculate total_price is handled by the Order class.
    In implementation B, part of the logic is delegated to both CartEntry (to get the price of an item by mulitplying its unit_price with its quantity) and ShoppingCart (sum up the price of all the items in the entries array). The Order class then just applied the Sales Tax to the sum from ShoppingCart.

  6b. Does total_price directly manipulate the instance variables of other classes?

      In Implementation A: total_price does directly manipulate the instance variable of ShoppingCart and CartEntry.
      In Implementation B: total_price does not directly manipulate he instance variable of ShoppingCart and CartEntry.

7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

    The code would need to be modified in CartEntry in Implementation B.

8. Which implementation better adheres to the single responsibility principle?

   Implementation B.

9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

  Implementation B.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Hotel Revisited

  In Reservation class I was checking the size of the block, populating the array that holds room numbers of rooms booked in blocks, and calculating the total_cost of the reservation (both for a single room reservation and a block reservation) in the initialize method. 
  
  In the refactor, I made additional methods in the class and moved those calculations and checks into the methods. As a result of this, the initialize method looks much cleaner and easier to read. 

  I was also passing the variables @total_cost and @room_blocks as parameters in the initialize. I realized I did not need to do that because neither the price nor the room_blocks is needed in as an argument in an instance of Reservation. 

  I also tidied up my code in FrontDesk class by using each loops instead of for loops and dividing up the responsibilty of the make_reservation method between two new helper methods that check whether we are trying to book a room already booked and for date overlaps for room bookings.



