1. What classes does each implementation include? Are the lists the same?
    Implementation A and B include the same three classes: CartEntry, ShoppingCart, and Order. 

2. Write down a sentence to describe each class.
    CartEntry creates each item that will go into the shopping cart (with a unit_price and quantity). ShoppingCart keeps track of all items in the cart (in Implementation B it also determines the price of the cart before tax). Order creates an instance of ShoppingCart and determines the price of the whole cart. 

3. How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    In implementation A:
        CartEntry contains the items that will be held within ShoppingCart. So CartEntry is contained within ShoppingCart. Order creates an instance of ShoppingCart and determines the total price for that instance of ShoppingCart. 

4. What data does each class store? How (if at all) does this differ between the two implementations?
    CartEntry stores a unit_price and quantity for each entry. In Imp. B it also stores the base price for each entry based on those two things. 
    ShoppingCart stores all entries (presumably all instances of CartEntry). In Imp. B it also stores the subtotal of the entire cart.
    Order stores SALES_TAX, a new instance of ShoppingCart, and the total price of the cart after tax. 

5. What methods does each class have? How (if at all) does this differ between the two implementations?
    In CartEntry, there is an initialize method in both implementations, with the addition of a .price method in Implementation B. 
    In ShoppingCart, there is an initialize method in both implementations, with the addition of a .price method in Implementation B. 
    In Order, there is an initialize method and a .total_price method in both implementations. 

6. Consider the Order#total_price method. In each implementation:
- Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
- Does total_price directly manipulate the instance variables of other classes?
    For implementation A: 
        - logic for computing the price is retained in Order
        - Yes, total_price directly manipulates .unit_price and .quantity which are instance variables in CartEntry. 
    For implementation B:
        - logic for computing the base price (i.e. subtotal) is delegated to CartEntry and ShoppingCart
        - No, total_price does NOT directly manipulate the instance variables of other classes. 

7. If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    We would probably want to change CartEntry to have a @bulk_price instance variable instead of @unit_price. This is easier to change in Implementation B because there is only class where @unit_price is referred to (CartEntry). This would be trickier in Implementation A because @unit_price is referred to not only in CartEntry but also in Order. 

8. Which implementation better adheres to the single responsibility principle?
    Based off of the answers given above, I would say that Implementation B better adheres to SRP. Logic pertaining to certain classes is delegated to those classes, and instance variables are only ever referenced within their own class. 

9. Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    Implementation B! This is because instance variables are only ever used within the class itself and are wrapped in instance methods if they need to be called by another class. Like question #7 suggests, if things need to change (like @unit_price) it won't be too difficult because that instance variable is only ever used within one class. 

*******

Thoughts on my Hotel program:

- After reading the two implementations for the online shopping cart, I realized that my ReservationTracker is directly manipulating Reservation's instance variables in maaaany places. This wasn't something I had initially put in my refactor.txt file because I didn't even really think about it. 
- I think I will tackle this problem instead of the other things I mentioned in my refactor.txt because it most directly relates to this issue of SRP and loosely coupled classes. 
- To implement this, I will add more helper methods to my Reservation class that will do some of the work that ReservationManager is doing. This will reduce the amount that ReservationManager is directly manipulating Reservation's instance variables. 
- If I have time, I will also look to implement this to a HotelBlock class, since a lot of that direct manipulation from ReservationManager also appears when it works with blocks. If I don't complete this portion, I understand the logic of why this would make sense to implement and hopefully at a future date I can do so :). 