public class ListOfProducts_Controller {
    
   @TestVisible private String sortOrder = 'Name';
   @TestVisible private Integer size = 10;
    
   @TestVisible private ApexPages.StandardSetController setNumberOfItemsOnPage {
        get {
            if(setNumberOfItemsOnPage == null) { 
                setNumberOfItemsOnPage = new ApexPages.StandardSetController(
                    Database.getQueryLocator('SELECT Id, Name, Type__c, Amount__c, Price__c, Added_date__c, Release_Date__c, In_Stock__c FROM List_Of_Products__c' + soqlWhere + 'ORDER BY ' + sortOrder + ' ASC LIMIT 100'));
                setNumberOfItemsOnPage.setPageSize(size);                
            }
            return setNumberOfItemsOnPage;
        }
        set;        
    }
    // list of products displays to VF page
    public List<List_Of_Products__c> getProduct() {
        return (List<List_Of_Products__c>) setNumberOfItemsOnPage.getRecords();
    }
    
    private void RerenderPage() {
        this.setNumberOfItemsOnPage = null;
    }  
    
    
     public Date searchAddedDate {get; set;} 
     public String searchTitle {get; set;}
    
     private String soqlWhere = ' ';
        
    public void searchProduct() {
        if(searchAddedDate != null && searchTitle != null) {
            // if user fill up both of search fields
        	searchTitle = String.escapeSingleQuotes(searchTitle.trim());
            
            soqlWhere = ' WHERE Added_Date__c =: searchAddedDate AND Name LIKE ' + '\'%' + searchTitle + '%\'' + ' ';
            this.RerenderPage();
            
        } else if (searchAddedDate != null && searchTitle == null) {
            // if user fill up only Added Date search field
            soqlWhere = ' WHERE Added_Date__c =: searchAddedDate ';
            this.RerenderPage();
                       
        } else if (searchAddedDate == null && searchTitle != null) {
            // if user fill up only Product Name search field
            searchTitle = String.escapeSingleQuotes(searchTitle.trim());
            
            soqlWhere = ' WHERE Name LIKE ' + '\'%' + searchTitle + '%\'' + ' ';            
            this.RerenderPage(); 
            
        } else if(searchAddedDate == null && searchTitle == null) { 
            // if search fields are empty - "soqlWhere" variable dont change and = ' '
            this.RerenderPage();
        }        
    }	
    
    // sort by all fields
    public void sort(string change) {
        this.sortOrder = change;
        this.RerenderPage();
    }
    public void sortByName() {
        this.sort('Name');        
    }
	public void sortByAmount() {
        this.sort('Amount__c');        
    }      
    public void sortByPrice() {
        this.sort('Price__c');        
    }
    public void sortByType() {
        this.sort('Type__c');
    }  
    public void sortByAddedDate() {
        this.sort('Added_Date__c');
    }
    public void sortByReleaseDate() {
        this.sort('Release_Date__c');        
    } 
    
    //pagination
    public Boolean Next {
        get {
            return setNumberOfItemsOnPage.getHasNext();
        }
        set;
    }
    public Boolean Previous {
        get {
            return setNumberOfItemsOnPage.getHasPrevious();
        }
        set;
    }
    
    public void First() {
        setNumberOfItemsOnPage.first();
    }
    public void Previous() {
        setNumberOfItemsOnPage.previous();
    }
    public void Next() {
        setNumberOfItemsOnPage.next();
    }
    public void Last() {
        setNumberOfItemsOnPage.last();
    }
    
     // add New Record Popup
    public Boolean displayAddPopup {get; set;}
    
    public void closeAddPopup() {
        displayAddPopup = false;
    }
    public void showAddPopup() {
        displayAddPopup = true;
    }
    
    // delete record popup
    public Boolean displayDeletePopup {get; set;}
    
    public void closeDeletePopup() {
        displayDeletePopup = false;
    }
    public void showDeletePopup() {
        displayDeletePopup = true;
    }
    
 

    // add New record
    public List_Of_Products__c newProduct {get; set;}    
    public Date added_date {get; set;}
    public Date release_date {get; set;}    
    
    public ListOfProducts_Controller(ApexPages.StandardController controller) {       
        newProduct = (List_Of_Products__c)controller.getRecord();      
    }
    
   @TestVisible private transient Database.SaveResult productSaveResult;
    public void addNewProduct() {       
        
        if(newProduct.Name == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Please fill in at least a Name field!'));
			return;            
        }
        
        newProduct.Release_Date__c = release_date;        
        newProduct.Added_Date__c = added_date;
        
    	try{
        	productSaveResult = Database.insert(newProduct, true);
        }
    	catch(DMLException e) {	// catch validation rule
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, e.getDmlMessage(0)));            
        }
        catch(Exception ex) { // catch other possible exceptions
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, ex.getMessage()));            
        }
        
        this.RerenderPage();
        this.closeAddPopup();
        newProduct = new List_Of_Products__c();
        
    }
    
    
    
       
     // delete record
    @TestVisible private transient Database.DeleteResult productDeleteResult;
    public Id productId {get; set;}
    
    public void deleteProduct() {
        
        if(productId == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'productId == null!'));
            return;
        }
        
        List<List_Of_Products__c> productToDelete = [SELECT Id FROM List_Of_Products__c WHERE Id =: productId];
        
        if(productToDelete.size() > 0) {
            productDeleteResult = Database.delete(productToDelete[0], true);
        }
        if(productDeleteResult.isSuccess()) {
            this.RerenderPage();
			this.closeDeletePopup();            
        }
    }
    
    
}