What classes does each implementation include? Are the lists the same?
Yes the list is the same, each implementation has a CartEntry, ShoppingCart, and Order.


Write down a sentence to describe each class.
CartEntry is each product with its price, Shopping Cart holds all the products, and Order is the total with salestax for all the entries.


How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
In implementation A, CartEntry holds the unit price and quantity of each product, ShoppingCart just holds the entries of products. The price is then calculated through a string of messages from ShoppingCart to CartEntry in Order's total_price method. In implementation B, Cart Entry has a price method that Shopping Cart uses to find it's own total and then Order call's on ShoppingCart's price method in it's total_price method. 

What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry stores unit_price and quantity. ShoppingCart stores entries. Order holds the ShoppingCart. This does not change much between implemetations. 

What methods does each class have? How (if at all) does this differ between the two implementations?
In implementation A, all the methods are in Order. In implementation B, all three classes have a price method that helps each class find the total for its zone of responsibility.


Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In implementation A, the price computation is retained in Order. In implementation B, it is delegated to the lower level classes.


Does total_price directly manipulate the instance variables of other classes?
In implementation A, total_price does have to manipulate the instance variable of the ShoppingCart class. In implementation B, total_price does not have to.  


If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
It would be easier in implementation B because we could change the price and quanitity in the CartEntry class's price method. In implementation A, it would be difficult because the methods are tied to different classes and needed to be changed in multiple places.


Which implementation better adheres to the single responsibility principle?
Implementation B adheres to the single responsibility principle. The methods in each class are more related to the class they belong to than in implementation A.


Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B is more loosely coupled because Order does not need to know how price of each entry is computated. That is found in CartEntry which is more related to its responsibility. 


Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe in design-activity.md what changes you would need to make to improve this design, and how the resulting design would be an improvement.

Yes, the booker class in my original hotel takes on too many responsibillities that can be delegated to classes with more direct information. One example of this is the add_to_room method in booker. This method directly edits an instance variable of the Room class by adding a given reservation to that room's reservation list. This would be better as a method in the Room class where a reservation is added to the room's list and the booker class does not need to know how this is done. This design would be more loosely coupled. 
