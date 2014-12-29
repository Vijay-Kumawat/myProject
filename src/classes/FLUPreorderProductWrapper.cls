/*
* Description	:	This is wrapper class for products.
* 
* Created By    :	
*
* Created Date  :	09/21/2013
*
* Version       :	V_1.0 - Created 
*/

public class FLUPreorderProductWrapper {
	
	//Variables
    public String productFamily {get; set;}
    public List<Product2> productList {get; set;}
    
    //Constructor
    public FLUPreorderProductWrapper(String productFamily , List<Product2> products) {
    	
    	//Set the default property
    	this.productFamily = productFamily;
    	this.productList = products;
    }
}