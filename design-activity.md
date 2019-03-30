<ol>
<li>
What classes does each implementation include? Are the lists the same?

    The classes in each implementation are CartEntry, ShoppingCart, and Order. The list is the same for both.
</li>

<li>Write down a sentence to describe each class.

    - CartEntry: This class stores information about individual items in the shopping cart. (This class instantiates a CartEntry object, keeping track of its unit price and quantity. Implementation B also enables the CartEntry object to calculate its own price.)
    - ShoppingCart: An instance of ShoppingCart stores information about the items placed in the shopping cart. (This class instantiates a ShoppingCart object, which establishes an array called @entries. In Implementation B, it also contains the behavior to calculate the price of each item in @entries.)
    - Order: The Order class calculates the total price of the shopping cart order. (This class instantiates an Order object, which instantiates an instance of ShoppingCart and stores it in @cart. It also has a SALES_TAX constant and can calculate the total_price of all items in @cart)
</li>

<li>How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    The classes relate to each other via object composition (not inheritance). Order has a ShoppingCart which has many CartEntry objects.
</li>

<li>What data does each class store? How (if at all) does this differ between the two implementations?
    Instances of CartEntry store the unit_price and quantity of that instance. ShoppingCart is presumably intended to store instances of CartEntry. Order stores the SALES_TAX; instances of Order (stored in @cart) store instances of ShoppingCart. This is the same in both implementations.
</li>

<li>What methods does each class have? How (if at all) does this differ between the two implementations?
    All three classes have an initialize method in both implementations.

    CartEntry has #attr_accessors in A and a price method in B.

    ShoppingCart has an #attr_accessor in A and price method in B.

    Order has a #total_price method in both implementations. However, in A, the method loops through the entries in @cart to calculate the price, whereas in B, this functionality is located within the price method of the ShoppingCart class instead. Implementation B's #total_price method simply calls the #price method in ShoppingCart.
</li>

<li>Consider the Order#total_price method. In each implementation:
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
    This logic is retained in Order in Implementation A. It is delegated to ShoppingCart in Implementation B, which further calls upon each CartEntry object to calculate its own price.
</li>

<li>
Does total_price directly manipulate the instance variables of other classes?
    In Implementation A, #total_price directly accesses the instance variables of the CartEntry class, via the @entries instance variable of the ShoppingCart class. 

    In Implementation B, no instance variables are directly accessed or manipulated by #total_price.
</li>

<li>If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    We'd need to implement code to check if the quantity meets the bulk minimum and apply the discount if true. 

    Implementation B would be easier to modify.
</li>

<li>Which implementation better adheres to the single responsibility principle?
    Implementation B
</li>

<li>Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    Implementation B is more loosely coupled because the Order class knows less about the ShoppingCart class. It only knows the method name #price in B whereas in A, it knows how to loop through the data in the ShoppingCart class and access the instance variables of the CartEntry objects.
</li>
</ol>