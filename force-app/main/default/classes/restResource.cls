
/*
    If I have an api that is https://www.mysite.com/api, the mapping is what comes at the end of this
    In this case, the endpoint to this resource is:
    https://wise-shark-uizz3p-dev-ed.trailblaze.my.salesforce.com/services/apexrest/learning
*/
@restResource(urlMapping='/learning')
global class restResource {
    
    /*
        In the class, we can use http annotations to specify which method should be ran when the endpoint receives a 
        particular HTTP method
        EX: @httpGet, @httpPut, @httpPatch, @httpDelete, @httpPost

        Can use each 1 only ONCE per class
    */

    @httpGet
    global static String get50AccountNames() {
        List<Account> accounts = [SELECT Name FROM Account LIMIT 50];

        String ret = '';
        for (Account a : accounts) {
            ret += a.Name + ', ';
        }

        return ret;
    }
}