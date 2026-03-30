global with sharing class accountcontactsoapapi {

    webservice static Id insertaccountcontact(string customername,boolean isaccount){

if(isaccount == true)
{
    account acc =  new account(Name = customername);
    insert acc;
    return acc.Id;
}
else {

    contact con = new contact(LastName = customername);
    insert con;
    return con.Id;
}
    }
    
}