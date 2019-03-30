## What classes does each implementation include? Are the lists the same?

Each implementation includes three classes:  ShoppingCart, CartEntry and Order.  The class lists are the same, but the way they're implemented are quite different.

## Write down a sentence to describe each class.

CartEntry:  An instance of CartEntry contains the unit price and unit quantity.  

ShoppingCart:  An instance of ShoppingCart contains many instances of CartEntry.

Order:  An instance of Order contains a single instance of ShoppingCart.

## How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.

CartEntry has a one-to-many relationship to ShoppingCart.  ShoppingCart has a one-to-one relationship with Order.

## What *data* does each class store? How (if at all) does this differ between the two implementations?

ShoppingCart contains an array of multiple cart entry objects.  Each CartEntry contains the unit price and unit quantity of that particular instance (both attributes are integers).  Order contains a single ShoppingCart object.

The data each class houses is the same in both implementations.

## What *methods* does each class have? How (if at all) does this differ between the two implementations?

In implementation A:

The only class with a method is Order.  Its total_price method calculates the order's total price by:

- Iterating over each CartEntry inside ShoppingCart.
- Multiplying each CartEntry's unit price and quanity
- Incrementing the sum by the product from above
- Calculating the sales tax
- Adding the sales tax to the existing sum

In implementation B

CartEntry has a method called "price".  It returns the product of its unit_price and quantity.

ShoppingCart has a method called "price".  It calls the "price" method inside CartEntry on each object inside its @entries array.  It increments the sum by the product returned by CartEntry's "price" method.

Order still has a method called "total_price".  It calls the "price" method stored inside ShoppingCart on its cart object, and assigns that value to "subtotal".  Then, it calculates the sales tax and adds it to the subtotal.

## Consider the Order#total_price method. In each implementation:

1. Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?

Its retained to Order in Implementation A.  The logic is delegated to "lower level" classes in Implementation B.

2. Does total_price directly manipulate the instance variables of other classes?

It directly manipulates the instance variables of other classes in Implementation A.  Implementation B's total_price method instead calls on a single method stored inside ShoppingCart (leaving the instance variable manipulations to their respective classes).

## If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?

We would need to add a conditional that adjusts the price based on the quantity of a CartEntry.  Implementation B is easier to modify because we only need to adjust the logic inside the "price" method inside CartEntry.  (Implementation A, meanwhile, would require adding that same logic inside a loop that iterates over each entry stored inside ShoppingCart.)

## Which implementation better adheres to the single responsibility principle?

Implementation B better adheres to the single responsibility principle.  It allows CartEntry to calculate the price of itself, ShoppingCart to calculate the sum total of all its CartEntry objects, and then Order to simply add the sales tax.

## Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?

Implementation B is more loosely coupled.  Order doesn't directly call upon attributes stored inside other classes (unlike Implementation A).  In other words, changes inside other classes are less likely to require changes inside Order.