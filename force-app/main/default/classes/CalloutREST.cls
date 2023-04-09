public class CalloutREST {
    
    /*
        REST
        - Stands for REpresentational State Transfer
        - NOT a protocol, it uses HTTP as its protocol
        - REST is an architecture for a server to handle HTTP requests
            - May also hear it refered to as a RESTful API
        - Principles of REST:
            - Client-server architecture implemented through HTTP
            - Uniform interface (send back data in a standardized format)
                - EX: If your server stores data as text, if the response is a JSON, format as JSON
                    - If the response is an IMG, format it as an IMG
            - Statelessness (requests are independent of one another)
            - Layered system
                - EX: The system may have many underlying processes
                    - Authentication, a database, validation, etc
                    - The client should be unaware of these processes and should only interface with the API layer
            - Cacheability (allow caching of commonly accessed and/or static resources)
        
        - Some benefits of REST:
            - Very common
            - Easy to write and consume
            - Supports many kinds of data formats (because it uses HTTP)
            - Flexible and scalable
    */


    public static void queryPokemon(String pkmName) {
        pkmName = pkmName.toLowerCase();

        // Create the class that sends the request
        Http sender = new Http();

        // Create the request itself (populate endpoint, method, body, headers)
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pkmName);
        request.setMethod('GET');

        // Send the request and store the response
        HttpResponse response = sender.send(request);

        if (response.getStatusCode() != 200) { return; }

        // Can create a parser to manually dig through the response
        JSONParser parser = JSON.createParser(response.getBody());

        // Can create a JSON map (as objects in JS are essentially just maps)
        Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());

        while (parser.nextToken() != null) {

            /*
                A token is a point of interest in the JSON file
                It can be one of these possible enums:
                FIELD_NAME (key), END_OBJECT, END_ARRAY, START_ARRAY, START_OBJECT, NOT_AVAILABLE, or the data type of a value
                Data type values:   VALUE_FALSE, VALUE_TRUE, VALUE_EMBEDDED_OBJECT, 
                                    VALUE_STRING, VALUE_NULL, VALUE_NUMBER_INT, VALUE_NUMBER_FLOAT
            */
            if (parser.getCurrentToken() != JSONToken.FIELD_NAME) {continue;}

            switch on parser.getText() {
                
                when 'ability' {
                    parser.nextValue();
                    parser.nextValue();
                    System.debug('Ability: ' + parser.getText());
                }
                when 'base_experience' {
                    parser.nextValue();
                    System.debug('Base EXP Yield: ' + parser.getText());
                }
                when 'species' {
                    parser.nextValue();
                    parser.nextValue();
                    System.debug('Pokemon Name: ' + parser.getText());
                }
            }
        }

        // If a JSON file has bad/no landmarks to orient yourself, you may use a map strategy instead
        String name = (String)jsonMap.get('name');
        Integer exp = Integer.valueOf(jsonMap.get('base_experience'));
        List<Object> abilities = (List<Object>)jsonMap.get('abilities');

        // In this case, this is too much. Just use the parser
        for (Object ability : abilities) {
            String jString = JSON.serialize(ability);
            Map<String, Object> abilityMap = (Map<String, Object>)JSON.deserializeUntyped(jString);
            jString = JSON.serialize(abilityMap.get('ability'));
            Map<String, Object> abilityData = (Map<String, Object>)JSON.deserializeUntyped(jString);
            System.debug('Ability: ' + abilityData.get('name'));
        }
    }
}