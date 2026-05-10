public with sharing  class testdeployclass {
    
    
    public static list<account>getdetails(){


return [select Id,Name,Type,Rating from  account  with user_mode  limit 10];






}

}