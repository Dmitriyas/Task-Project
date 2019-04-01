@isTest
public class TestHelperListOfProducts {
    @isTest public static List<List_Of_Products__c> getProductList() { 
        List<List_Of_Products__c> listOfProducts = new List<List_Of_Products__c> {	
            								new List_Of_Products__c(Name = 'Iphone 5s', Amount__c = 20, Price__c = 150, Type__c = 'SmartPhone', Release_Date__c = date.parse('05/01/2018'), Added_Date__c = date.parse('05/05/2018')), 
    										new List_Of_Products__c(Name = 'Samsung Galaxy Note 3', Amount__c = 17, Price__c = 700, Type__c = 'SmartPhone', Release_Date__c = date.parse('02/01/2018'), Added_Date__c = date.parse('01/02/2019')),  
                                            new List_Of_Products__c(Name = 'Iphone Xs', Amount__c = 6, Price__c = 299, Type__c = 'SmartPhone', Release_Date__c = date.parse('05/04/2018'), Added_Date__c = date.parse('05/22/2018')),
           									new List_Of_Products__c(Name = 'Acer 2784', Amount__c = 10, Price__c = 3193, Type__c = 'Laptop', Release_Date__c = date.parse('05/19/2018'), Added_Date__c = date.parse('05/22/2018'))};
		    return listOfProducts;
    }

}