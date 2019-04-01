##### Activity: Evaluating Responsibility

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

#####Revisiting Hotel
<ol>
<li>What is this class's responsibility?
You should be able to describe it in a single sentence.
    - Manager: This class manages the data structure and behaviors of all reservations.
    - Reservation: The Reservation class makes reservation objects, which includes calculating the length and base cost of the stay.
</li>

<li>Is this class responsible for exactly one thing?
    - Manager: yes, I think so
    - Reservation: yes
</li>

<li>Does this class take on any responsibility that should be delegated to "lower level" classes?
    - Manager: no
    - Reservation: no
</li>

<li>Is there code in other classes that directly manipulates this class's instance variables?
    - manager: yes; the ck_avail method accesses the ckout_date and ckin_date attributes of specific instances of reservation (for example: res_last.ckout_date)
    - reservation: no
</li>

<li>Based on the answers to each set of the above questions, identify one place in your Hotel project where a class takes on multiple roles, or directly modifies the attributes of another class. Describe what changes you would need to make to improve this design, and how the resulting design would be an improvement.

    See Line 52 in manager prior to changes.
    The ck_avail method accesses the ckout_date and ckin_date attributes of specific instances of reservation (for example: res_last.ckout_date). This makes Manager tightly coupled to Reservation. To improve this design, I need to move the logic that checks a requested date range against the check-in and check-out dates of existing reservation instances to the Reservation class. Then I can call that method in the Manager class and pass it two reservations to check, instead of accessing the reservations' attributes directly.

    Similarly, Line 33 of Manager directly accesses the date_range_string_array attribute of a reservation object. To decouple this, I need to make a method in Reservation called "includes_date" to check check if the date passed into list_reservations_for_date is included in that room's date_range_string_array. This method will return true/false.
    
</li>
</ol>