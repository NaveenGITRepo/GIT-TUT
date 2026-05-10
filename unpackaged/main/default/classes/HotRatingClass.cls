public with sharing class HotRatingClass {
    public HotRatingClass() {

    }

    public static void updateHotAccountAmounts(List<Account> newList, Map<Id, Account> oldMap) {
        Set<Id> hotAccountIds = new Set<Id>();

        // Step 1: Identify accounts that changed from non-Hot to Hot
        for (Account acc : newList) {
            Account oldAcc = oldMap.get(acc.Id);
            if (acc.Rating == 'Hot' && oldAcc.Rating != 'Hot') {
                hotAccountIds.add(acc.Id);
            }
        }

        if (hotAccountIds.isEmpty()) return;

        // Step 2: Query Opportunities related to these Accounts
        Map<Id, Decimal> accountIdToTotalAmount = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT AccountId, SUM(Amount) totalAmount
            FROM Opportunity
            WHERE AccountId IN :hotAccountIds
            GROUP BY AccountId
        ]) {
            Id accId = (Id)ar.get('AccountId');
            Decimal total = (Decimal)ar.get('totalAmount');
            accountIdToTotalAmount.put(accId, total);
        }

        // Step 3: Prepare list of Accounts to update
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : hotAccountIds) {
            
            accountsToUpdate.add(new Account(Id = accId ,Total_Opportunity_Amount__c = accountIdToTotalAmount.get(accId) != null ? accountIdToTotalAmount.get(accId) : 0 ));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}