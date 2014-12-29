public class ProductCalculator {

    Integer qty; Integer price; Integer total;
   
    public PageReference calculateTotal() {
        system.debug('calculate total called' );
        calcTotal();
        return null;
    }  
   
    public Integer calcTotal()
    {
        total = qty * price;
        system.debug('total is: ' + total);
        return total;
    }
  
    public Integer getQuantity() {
        return qty;
    }
   
    public void setQuantity(Integer q) {
       qty = q;
    }
   
     public Integer getProdPrice() {
        return price;
    }
   
    public void setProdPrice(Integer p)
    {
        price = p;
    }
   
     public Integer getProdTotal() {
        return total;
    }
   
    public void setProdTotal(Integer t)
    {
        total = t;
    }
   
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Product1','Product 1'));
        options.add(new SelectOption('Product2','Product 2'));
        options.add(new SelectOption('Product3','Product 3'));
        return options;
    }

  
    String[] prod = new String[]{};
  
    public String[] getProduct() {
        return prod;
    }
   
    public void setProduct(String[] prod)
    {
        this.prod = prod;
    }

    String ProductType;
    List<Product2> products;
   
    public List<Product2> getProducts() {
        if(products == null)
            products = [select id, name from Product2 Limit 1];
        return products;
    }

}