trigger CheckboxTrigger on List_Of_Products__c (before insert, before update) {
		if(Trigger.isBefore) {
        for(List_Of_Products__c product : Trigger.New) {
            if(product.Amount__c > 0) {
                product.In_Stock__c = true;
            } else {
                product.Amount__c = 0;
                product.In_Stock__c = false;
            }
        }
    }
}