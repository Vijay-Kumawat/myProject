public class sampleCon {
    String country = null;
         
    public PageReference test() {
        return null;
    }
                
    public List<SelectOption> getItems() {List<SelectOption> options = new List<SelectOption>();
        SelectOption so1 = new SelectOption('US','<span title="United States">US</span>');
        so1.setEscapeItem(false);
        options.add(so1);
        SelectOption so2 = new SelectOption('Canada','<span title="The Great White North">Canada</span>');
        so2.setEscapeItem(false);
        options.add(so2);
        return options;
    }
                   
    public String getCountry() {
        return country;
    }
                    
    public void setCountry(String country) { this.country = country; }
}