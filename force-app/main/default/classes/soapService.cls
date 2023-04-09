
/*
    SOAP services must be global and methods and variables must use the webservice access modifier to be included in the .wsdl
*/
global class soapService {
    
    webservice Integer num = 50;

    webservice static String get50AccountNames() {
        List<Account> accounts = [SELECT Name FROM Account LIMIT 50];

        String ret = '';
        for (Account a : accounts) {
            ret += a.Name + ', ';
        }

        return ret;
    }
}