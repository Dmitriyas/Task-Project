@isTest
public class Test_CheckBoxTrigger {
    @isTest public static void SelectCheckbox() {
        List<List_Of_Products__c> testProducts = new List<List_Of_Products__c> {new List_Of_Products__c(Name = 'Product 1', Amount__c = 5), 
    																			new List_Of_Products__c(Name=  'Product 2'),
        																		new List_Of_Products__c(Name = 'Product 3', Amount__c = 10),
        																		new List_Of_Products__c(Name = 'Product 4'),
        																		new List_Of_Products__c(Name = 'Product 5', Amount__c = 20),
        																		new List_Of_Products__c(Name = 'Product 6')
            																		};
                                                                            
        Database.SaveResult[] TestProductsSaveResult = Database.Insert(testProducts, true);
        
        for(Database.SaveResult sv : TestProductsSaveResult) {
            System.assert(sv.isSuccess());
        }        
        
        
        List<List_Of_Products__c> productsWithSelectedCkeckbox = [SELECT Id, Name, Amount__c, In_Stock__c 
                                                                  FROM List_Of_Products__c 
                                                                  WHERE In_Stock__c = true];
        List<List_Of_Products__c> productsWithNotSelectedCkeckbox = [SELECT Id, Name, Amount__c, In_Stock__c 
                                                                     FROM List_Of_Products__c 
                                                                     WHERE In_Stock__c = false];
                
        System.assertEquals(3, productsWithSelectedCkeckbox.size());
        System.assertEquals(3, productsWithNotSelectedCkeckbox.size());
        
        for(List_Of_Products__c product : productsWithSelectedCkeckbox) {
            System.assert(product.Amount__c != 0);
            System.assert(product.Amount__c > 0);            
            System.assertNotEquals(null, product.Amount__c);
        }
        
        for(List_Of_Products__c product : productsWithNotSelectedCkeckbox) {
            System.assert(product.Amount__c == 0);                        
            System.assertNotEquals(null, product.Amount__c);
        }                                                                  
    } 

}