public class AccountDeleteHandler {
    
    
    public static void deleteaccount(list<account>accdelete){
        
      set<id>accIds =  new set<id>();
        
        list<contact>conupd = new list<contact>();
        
        if(!accdelete.isEmpty()){
            
            for(account acc : accdelete){
                
                accIds.add(acc.Id);
                
            }
        }
        
        if(!accIds.isEmpty()){
            
            list<contact>existcontact = [select lastname,accountId  from contact where accountId in :accIds];
            
            for(contact con : existcontact){
                
                con.accountId = null;
                
                conupd.add(con);
                
            }
            
            if(!conupd.isEmpty()){
                
                update conupd;
            }
            
        }
        
    }

}