    Q)What classes does each implementation include? Are the lists the same?
    A)implementationA has class CartEntry, ShoppingCart, Order.
      implementationB has class CartEntry, ShoppingCart, Order.
      The lists are the same

    Q)Write down a sentence to describe each class.
    A) CartEntry stores the unit price and quantity of a cart entry and returns the price.
      ShoppingCart stores the entries and calculates the total cart price.
      Order creates a new shopping cart and returns the cart price with sales tax included.

    Q)How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
    A) an Order contains a ShoppingCart and ShoppingCart contains CartEntries.

    Q)What data does each class store? How (if at all) does this differ between the two implementations?
    A)CartEntry contains unit price and quantity. ShoppingCart contains entries. Order contains cart. implementationA has accessors for the cart entry and ShoppingCart.

    Q) What methods does each class have? How (if at all) does this differ between the two implementations?
    A) in implementationA there is only a method in class Order called total_price. in implementationB there are price methods in all classes.

    Q)Consider the Order#total_price method. In each implementation:
        Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?
        Does total_price directly manipulate the instance variables of other classes?
    A) in implementationA the price is only delegated in one class Order. in implementationB it is spread out, price methods occur in CartEntry and ShoppingCart and a total_price is calculated in Order. total_price does manipulate the instance variables of other classes.

    Q)If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
    A) We would have to add a bulk discount method. implementationB

    Q)Which implementation better adheres to the single responsibility principle?
    A) implementationB

    Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
    A) implementationB
