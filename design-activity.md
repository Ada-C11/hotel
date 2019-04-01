**What classes does each implementation include? Are the lists the same?**

A includes CartEntry, ShoppingCart, and Order. B includes the same classes.

**Write down a sentence to describe each class.**

CartEntry represents an object within a cart that has a unit price and a quantity, and uses these attributes to calculate a price. ShoppingCart stores a list of CartEntry instances and can calculate the total price of those instances. Order initializes a new ShoppingCart and calculates a price including sales tax.

**How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.**

An Order has one ShoppingCart, and one ShoppingCart can have one or many (or zero) CartEntry objects.

**What data does each class store? How (if at all) does this differ between the two implementations?**

There is no difference between the two implementations. CartEntry stores a unit_price and a quantity. ShoppingCart stores an array called entries. Order stores a cart, which is an instance of ShoppingCart.

**What methods does each class have? How (if at all) does this differ between the two implementations?**

In A, CartEntry has an attr_accessor for unit_price and quantity. B's CartEntry does not have any attr_accessors, but it does have a price method. In A, ShoppingCart has an attr_accessor for entries. B's ShoppingCart does not have any attr_accessors, but it does have a price method. In both A and B, Order has a total_price method.

**Consider the Order#total_price method. In each implementation:**

**Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?**

**Does total_price directly manipulate the instance variables of other classes?**

In A, the logic to compute the price is not delegated to "lower level" classes, but it is delegated to those classes in B. In A, total_price does directly manipulate the instance variables of other classes, but it doesn't do so in B. 

**If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?**

There would need to be changes to the code for the CartEntry class that would probably involve a conditional statement revolving around the value of @quantity. B is easier to modify because the only change that would need to be made would be in CartEntry, whereas in A you'd probably have to change CartEntry and Order.

**Which implementation better adheres to the single responsibility principle?**

B

**Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?**

B

**Hotel Redesign Activity**

In my Hotel class, Hotel#reserve_block_room calls on instance variables of both Room and HotelBlock and also modifies them. To improve this design, I need to do several things:

* Wrap the "block.available_rooms.include?(room)" in the conditional (line 170) in a method within HotelBlock.

* Utilize Room#add_reservation instead of writing "room.reservations << block_res" on line 174 (I must have just forgotten about that method when writing the code).

* Write a wrapper method to replace "block.available_rooms.delete" on line 175. The helper method should be a HotelBlock method that can just do the deletion without stepping through the available_rooms instance variable first.

These changes would make this method less susceptible to changes, because if the names of the instance variables in Room or HotelBlock were to change, there should be no reason that the code in this method should break because those instance variables would no longer be referred to directly here.