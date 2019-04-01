- What classes does each implementation include?
 both have the same classes the same.
  - CartEntry
  - ShoppingCart
  - Order
- Write down a sentence to describe each class.
  - CartEntry has the instance 2 instance variables, Unit_price and quantity. each item that the user orders get instantiated in CartEntry and can keep track of it's price and quantity.
  - ShoppingCart has an empty array of entries as the instance variable.
  - Order has a constant variable (SALE_TAX) and is tightly coupled with the ShoppingCart Class.
- How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.
  - Implementation A:
  >Order is making a new instance of ShoppingCart each time it get instantiated so they are tightly coupled. ShoppingCart keeps an array of all the entries and each entry knows about its price and quantity from CartEntry.
  When Order calculates the total_price with its instance method, it needs to send a message to the CartEntry to get the price and quantity.
  - Implementation B:
  >The relationship between Order and ShoppingCart is still tightly coupled, but in this implementation each class has their own instance variable of calculating the price so when Order is calculating the Total_price it just need to know about the cart price and doesn't need to send a message to the CartEntry through ShoppingCart.
  These classes are loosely coupled.
- What data does each class store? How (if at all) does this differ between the two implementations?
  - Implementation A:
  >CartEntry keeps the data about quantity and unit price of each item. Shopping cart keeps the data about what items are in the cart and Order keeps the data about all the item in the cart and the sale tax and when calculating the total price it needs to reach out to CartEntry to be able to get the unit price and quantity of each item.
  - Implementation B:
  >CartEntry keeps the data about the quantity and unit price and the price of each entry. Shopping cart keeps all the entries and keeps the data about the total price of the cart and order can instantiate the ShoppingCart and calculate the total price.

- What methods does each class have? How (if at all) does this differ between the two implementations?
> In implementation A only Order has a total_price method but in implementation B the other two classes also have a price method.
- Consider the Order#total_price method. In each implementation:
  >In implementation A when calculating the total price Order needs to know about the price in lower level classes like CartEntry or ShoppingCart but in implementation B it doesn't care about the price of each item. it simply add the sale tax to the cart price. it doesn't need to reach out to the lower level classes.
- If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?
 >it would be easier to modify the code in implementation B as we can add a bulk price and ask the price method to consider it. non of the other classes needs to know about it as they only care about the price of the entry not the quantity or price of each item.
 - Which implementation better adheres to the single responsibility principle?
 >I think B, in this implementation each class has their own responsibilities and don't need to know about each other a whole lot which in the first implementation the Order class had to know about the CartEntry and has to calculate the price for the ShoppingCart.
 - Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?
 >The second one, in this one Order is not sending messages to CartEntry through the ShoppingCart to calculate the price.

 
