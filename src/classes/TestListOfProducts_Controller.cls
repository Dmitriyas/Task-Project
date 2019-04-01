@isTest(seeAllData=true)
public class TestListOfProducts_Controller {
    // rest the output to the page of the specified number of records (10)
    @isTest static void testProductPage() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
                
        ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);        
        System.assertEquals(10, controller.getProduct().size());
    }
    
    // test Pagination 
    @isTest static void testPaginationFunctions() {
		List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc); 
        
        controller.setNumberOfItemsOnPage = new ApexPages.StandardSetController(Database.getQueryLocator(
                'SELECT Id, Name, Type__c, Amount__c, Price__c, Added_date__c, Release_Date__c, In_Stock__c FROM List_Of_Products__c ORDER BY Name ASC LIMIT 50'));
        controller.setNumberOfItemsOnPage.setPageSize(10);
         
        System.assert(controller.Next);
        System.assert(!controller.Previous);
        
        controller.Next();
        System.assert(controller.Previous);
        System.assert(controller.Previous);
        
        controller.First();
        controller.Last();
        controller.Previous();        
    }
    
    // test Sorting 
	@isTest static void testSortingByName() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc); 
        
        Test.startTest();
        controller.sortByName();
        Test.stopTest();
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Name ASC LIMIT 10];
        
        System.assertEquals(productsFromOrg, controller.setNumberOfItemsOnPage.getRecords());
    }    
    
    @isTest static void testSortingByType() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc); 
        
        Test.startTest();
        controller.sortByType();
        Test.stopTest();
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Type__c ASC LIMIT 10];
        
        System.assertEquals(productsFromOrg, controller.setNumberOfItemsOnPage.getRecords());
    }
    
    @isTest static void testSortingByPrice() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc); 
        
        Test.startTest(); 
        controller.sortByPrice();
        Test.stopTest();
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Price__c ASC LIMIT 10];
        
        System.assertEquals(productsFromOrg, controller.setNumberOfItemsOnPage.getRecords());
    }
    
    @isTest static void testSortingByAmount() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc); 
        
        Test.startTest();
        controller.sortByAmount();
        Test.stopTest();
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Amount__c ASC LIMIT 10];
        
        System.assertEquals(productsFromOrg, controller.setNumberOfItemsOnPage.getRecords());
    }
    @isTest static void testSortingByReleaseDate() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc); 
        
        Test.startTest();
        controller.sortByReleaseDate();
        Test.stopTest();
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Release_Date__c ASC LIMIT 10];
        
        System.assertEquals(productsFromOrg, controller.setNumberOfItemsOnPage.getRecords());
    }
    @isTest static void testSortingByAddedDate() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc); 
        
        Test.startTest();
        controller.sortByAddedDate();
        Test.stopTest();
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC LIMIT 10];
        
        System.assertEquals(productsFromOrg, controller.setNumberOfItemsOnPage.getRecords());
    }
    
    // Test adding new empty record (trigger an error message: 'Please fill in at least a Name field!')
    @isTest static void testAddingNewEmptyRecord() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        
        controller.newProduct = new List_Of_Products__c();
        
        Test.startTest();
        controller.addNewProduct();
        Test.stopTest();        
        
        System.assertEquals(null, controller.productSaveResult);
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
    		System.assertEquals(' Please fill in at least a Name field!', msg.getSummary());
    		System.assertEquals(ApexPages.Severity.FATAL, msg.getSeverity()); 
		}
        
        List<List_Of_Products__c> productsFromOrgAfterAddNewRecord = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        
        // Check that the number of records has not changed. The new record was not saved.
        System.assertEquals(productsFromOrg, productsFromOrgAfterAddNewRecord);
    }
    
    // Test сreating a new record with all the restrictions. Must be successfully saved.
    @isTest static void testAddingNewValidRecord() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        
        controller.newProduct = new List_Of_Products__c(Name = 'Test Product', Amount__c = 10, Price__c = 200, Type__c = 'Smart Phone', 
                                                    Release_Date__c = date.parse('05/01/2018'), Added_Date__c = date.parse('05/05/2018'));
        Test.startTest();
        controller.addNewProduct();
        Test.stopTest();

        System.assert(controller.productSaveResult.isSuccess());
                
        List<List_Of_Products__c> productsFromOrgAfterAddNewRecord = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        
        // сheck that the number of records has changed. The new record was saved
        System.assertNotEquals(productsFromOrg, productsFromOrgAfterAddNewRecord);
        System.assertEquals(productsFromOrg.size() + 1, productsFromOrgAfterAddNewRecord.size());
    }
    
    // test "Add" & "Delete" popups
    @isTest static void testPopups() {
        ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
        
        controller.showAddPopup();
        System.assertEquals(true, controller.displayAddPopup);
        
        controller.closeAddPopup();
		System.assertEquals(false, controller.displayAddPopup);

		controller.showDeletePopup();
        System.assertEquals(true, controller.displayDeletePopup);
        
        controller.closeDeletePopup();
        System.assertEquals(false, controller.displayDeletePopup);
    }   
    
    // test throwing an error when we try to delete not identified record
    @isTest static void testDeletingProduct_Error() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        controller.productId = null;
        
        Test.startTest();
        controller.deleteProduct();
        Test.stopTest();
        
        System.assertEquals(null, controller.productDeleteResult);
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
    		System.assertEquals('productId == null!', msg.getSummary());
    		System.assertEquals(ApexPages.Severity.FATAL, msg.getSeverity()); 
		}
        
        List<List_Of_Products__c> productsFromOrgAfterAddNewRecord = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        
        // check that the number of records has not changed. The record wasn't deleted
        System.assertEquals(productsFromOrg, productsFromOrgAfterAddNewRecord);
    }
    
    // test successfull deleting record
    @isTest static void testDeletingProduct_Success() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
        
        List<List_Of_Products__c> productsFromOrg = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        
        List_Of_Products__c productToDelete = productsFromOrg[0];
        
        controller.productId = productToDelete.Id;
        
        Test.startTest();
        controller.deleteProduct();
        Test.stopTest();
        
        System.assertNotEquals(null, controller.productDeleteResult);
        System.assert(controller.productDeleteResult.isSuccess());
        
        List<List_Of_Products__c> deletedProduct = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      Added_date__c, Release_Date__c, In_Stock__c 
                                                      FROM List_Of_Products__c WHERE Id =: productToDelete.Id];
        
        System.assertEquals(0, deletedProduct.size());
        
        List<List_Of_Products__c> productsFromOrgAfterDelete = [SELECT Id, Name, Type__c, Amount__c, Price__c, 
                                                      		Added_date__c, Release_Date__c, In_Stock__c 
                                                      		FROM List_Of_Products__c ORDER BY Added_Date__c ASC];
        
        System.assertNotEquals(productsFromOrg, productsFromOrgAfterDelete);
        System.assertEquals(productsFromOrg.size(), productsFromOrgAfterDelete.size() + 1);        
    }
    
    // test search by Added Date
    @isTest static void testSearchByAddedDate() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
                
    	
    	controller.searchAddedDate = date.parse('05/05/2018');
        controller.searchTitle = null;
        
        Test.startTest();
        controller.searchProduct();
        Test.stopTest();
        
        List<List_Of_Products__c> foundProduct = controller.getProduct();
        
        System.assertEquals(1, foundProduct.size());
        
        System.assertEquals('Iphone 5s', foundProduct[0].Name);
        System.assertEquals(20, foundProduct[0].Amount__c);
        System.assertEquals(150, foundProduct[0].Price__c);
        System.assertEquals('SmartPhone', foundProduct[0].Type__c);
        System.assertEquals(Date.parse('05/01/2018'), foundProduct[0].Release_Date__c);
        System.assertEquals(true, foundProduct[0].In_Stock__c);        
    }
    
    // test search by product name of part of product name (title)
    @isTest static void testSearchByProductTitleOrItsPart() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
                
    	
    	controller.searchAddedDate = date.parse('05/22/2018'); 
        controller.searchTitle = 'er';
        
        Test.startTest();
        controller.searchProduct();
        Test.stopTest();
        
        List<List_Of_Products__c> foundProduct = controller.getProduct(); 
        
        System.assertEquals(1, foundProduct.size());
        
        System.assertEquals('Acer 2784', foundProduct[0].Name);
        System.assertEquals(10, foundProduct[0].Amount__c);
        System.assertEquals(3193, foundProduct[0].Price__c);
        System.assertEquals('Laptop', foundProduct[0].Type__c);
        System.assertEquals(Date.parse('05/19/2018'), foundProduct[0].Release_Date__c);
        System.assertEquals(true, foundProduct[0].In_Stock__c);
    }
    
    // test search by both product name(or its part) and added date
    @isTest static void testSearchProductByNameAndAddedDate() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
                
    		
    	controller.searchAddedDate = date.parse('05/22/2018');
        controller.searchTitle = 'ne';
        
        Test.startTest();
        controller.searchProduct();
        Test.stopTest();
        
        List<List_Of_Products__c> foundProduct = controller.getProduct();
        
        System.assertEquals(1, foundProduct.size());
        
        System.assertEquals('Iphone Xs', foundProduct[0].Name);
        System.assertEquals(6, foundProduct[0].Amount__c);
        System.assertEquals(299, foundProduct[0].Price__c);
        System.assertEquals('SmartPhone', foundProduct[0].Type__c);
        System.assertEquals(Date.parse('05/04/2018'), foundProduct[0].Release_Date__c);
        System.assertEquals(true, foundProduct[0].In_Stock__c);
        
        
    }
    
    // test empty search request
    @isTest static void testEmptySearchRequest() {
        List<List_Of_Products__c> products = TestHelperListOfProducts.getProductList();
        Database.SaveResult[] saveProductsResult = Database.insert(products, true);
        
    	ApexPages.StandardController sc = new ApexPages.StandardController(new List_Of_Products__c());
        ListOfProducts_Controller controller = new ListOfProducts_Controller(sc);
                    		
    	controller.searchAddedDate = null;
        controller.searchTitle = null;
        
        Test.startTest();
        controller.searchProduct();
        Test.stopTest();
        
        System.assertEquals(10, controller.getProduct().size());
        
        List<List_Of_Products__c> foundProduct = controller.getProduct();
        System.assertEquals(10, foundProduct.size());
    }

}