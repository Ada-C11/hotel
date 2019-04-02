1. Both implementations include a CartEntry, ShoppingCart and Order class but the methods within them differ.
 2. - CartEntry creates instances of items to add to the cart and defines the price and quantity of the item.
 - ShoppingCart creates an array that holds the cart entries.
 - Order creates an instance of ShoppingCart and finds the total price of the cart items, including tax.
 3. ShoppingCart contains many instances of CartEntry
 4. In implementation A, CartEntry only stores the unit price and quantity of items. In implementation B, it also can store the total price of an item based on quantity. ShoppingCart in implementation only stores an array of cart entries but in implementation B it also stores the sum price of all of the entries. Order stores the total price of the cart with tax.
 5. Implementation A has only initialize methods for all classes except Order, which includes a total_price method. Implementation B has a price method for ShoppingCart and CartEntry.
 6. - In implementation A the logic to compute the price is retained in Order but delegated to lower level classes in implementation B.
 - It does manipulate but does not change the instance variables of other classes in implementation A.
 7. Implementation B would be easier to modify.
 8. Implementation B better adheres to the single responsibility principle.
 9. Implementation B is more loosely coupled. 

