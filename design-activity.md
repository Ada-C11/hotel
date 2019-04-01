-What classes does each implementation include? Are the lists the same?
Both implementations include CartEntry, ShoppingCart and Order classes. 

-Write down a sentence to describe each class.
CartEntry class has unit_price and quantity instance variables for items. ShoppingCart class has entries instance variable which will have array of CartEntry instances. Order class initializes an instance of a ShoppingCart class and returns a total price. 

-How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
Order class has a ShoppingCart instance, and ShoppingCart class has a CartEntry instance. 

-What data does each class store? How (if at all) does this differ between the two implementations?
CartEntry class stores a unity price and quantity of an entry. ShoppingCart class stores array of CartEntry class instances. And Order class stores an instance of a ShoppingCart class. Both implementations store same data for all the classes. 

-What methods does each class have? How (if at all) does this differ between the two implementations?
Implementation A has a total_price method in Order class which does all the calculations of an order. However, implementation B has price methods in CartEntry and ShoppingCart classes in addition to the total_price method in Order class. 

-Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
In implementation B the price computation logic is delegated to ShoppingCart and CartEntry classes. However, in implementation A price computation is retained in Order class. 

-Does total_price directly manipulate the instance variables of other classes?
Implementation A's total_price method directly manipulates the instance variables of ShoppingCart and CartEntry classes.

-If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
If items are cheaper depending on the quantity, we will need to check quantity before calculating the price. Implementation B is easier to modify since other classes have separate price methods that can be modified. 

-Which implementation better adheres to the single responsibility principle?
Implementation B better adheres to the single responsibility principle as its classes consist of both behavior and state. 

-Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
Implementation B is more loosely coupled. 