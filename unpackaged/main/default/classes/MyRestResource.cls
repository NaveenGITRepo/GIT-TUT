@RestResource(urlMapping='/RestAccount/*')
global with sharing class MyRestResource {

    @HttpDelete
    global static void doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
    }
  
    @HttpGet
    global static list<account> doGet() {
      list<account>acc = [select id,name,phone  from account limit 10];
      return acc;
    }
  
  @HttpPost
    global static id doPost(String name,
        String phone) {
        Account account = new Account();
        account.Name = name;
        account.Phone = phone;
        
        insert account;
        return account.Id;
    }
}