What classes does each implementation include? Are the lists the same?

	  Implementation A  
	  - CartEntry  
	  - ShoppingCart     
	  - Order 
	
	  Implementation B 
	  - CartEntry   
	  - ShoppingCart  
	  - Order 
	
	  Yes, lists are the same.

Write down a sentence to describe each class. 

	  Implementation A  
	  - CartEntry (model)
		   Stores state of unit_price and quantity when
		   intialized as instance variables. 
	  - ShoppingCart (model)
	  		Appears to hold instances of CartEntry in an instance   
	  		variable array entries, which is initialized as empty.
	  - Order (controller)
	  		Creates instance of ShoppingCart and can calculate  
	  		total price including sales tax by iterating  
	  		through ShoppingCart.entries array and using methods    
	  		that are specific to the object in the array.
	
	  Implementation B 
	  - CartEntry (model)
		   Stores state of unit_price and quantity and   
		   knows how to calculate price given its state.   
	  - ShoppingCart (model)
	  		Holds instance of CartEntry (or any class with .price  
	  		method) in entries array and can calculate the cost   
	  		of all the entries in the ShoppinCart.
	  - Order (controller)
	  		Creates instance of ShoppingCart and can calculate  
	  		total price including sales tax by calling .price   
	  		on the ShppingCart instance. 
	  		
How do the classes relate to each other? 

	  Implementation A  
	  - CartEntry 
	  - ShoppingCart has many CartEntries    
	  - Order has a ShoppingCart.
	
	  Implementation B 
	  - CartEntry 
	  - ShoppingCart has many CartEntries    
	  - Order has a ShoppingCart.
	 
What data does each class store?    
How (if at all) does this differ between the two implementations?
			
				
	  Implementation A  
	  - CartEntry 
	  		@unit_price
	  		@quantity 
	  - ShoppingCart
	  		@entries     
	  - Order 
	  		@cart
	
	  Implementation B 
	  - CartEntry 
	  		@unit_price
	  		@quantity 
	  - ShoppingCart
	  		@entries     
	  - Order 
	  		@cart
	
	No difference. 
	
What methods does each class have?    
How (if at all) does this differ between the two implementations?

	  Implementation A  
	  - CartEntry  
	  		none
	  - ShoppingCart   
	  		none  
	  - Order 
	  		total_price
	
	  Implementation B 
	  - CartEntry 
	  		price
	  - ShoppingCart  
			price 
	  - Order 
	  		total_price 
	 
	 Implementation B: each step of total price is calculated  
	 a little bit in each class so that the class responsible   
	 for performing caculation based on the knowledge it has.   
	 
	 Implementation A: everything is done in one method in one   
	 class. That class knows about two other classes and   
	 the associated data.  
	 
Consider the Order#total\_price method.   
In each implementation: Is logic to compute the price  
delegated to "lower level" classes like ShoppingCart and   
CartEntry, or is it retained in Order?  

	  In implementation A all the logic is retained in Order  
	  while implementation B  delegates logic to   
	  lower level classes.
	  
Does total_price directly manipulate the instance  
variables of other classes? 
	
	  In implementation A YES,
	  while implementation B it does not.  
	  
If we decide items are cheaper if bought in bulk,    
how would this change the code? Which implementation   
is easier to modify?

	  In implementation A Order#total_price would need to be changed
	  while implementation B CartEntry#price would need to be modified.
	  Implentation B would be easier to modify. 
	  
Which implementation better adheres to the single   
responsibility principle?   

	  Implementation B 

Which implementation is more loosely coupled?    

	  Implementation B 
	  
	  
	  
Describe in design-activity.md what changes you would need to  
make to improve this design, and how the resulting design   
would be an improvement.

The following methods in Booker should be modified to delegate logic to lower level classes:  
1)  get\_cost\_of\_booking(reservation:)   
2)  calculate\_cost\_of\_booking(reservation:, room:, percent_discount: 0)

get\_cost\_of\_booking(reservation:) should be removed as it is just calling reservation.price 

calculate\_cost\_of\_booking(reservation:, room:, percent_discount: 0) is a   
little more tricky. This reservation price should be set in reservation not in Booker,   
so I will modify the method signature to adapt it.


  