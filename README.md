# APIs in Apex

## What is an API?

- API stands for Application Program Interface
    - This is the interface that a program uses to talk to another program
- In the most common context, this is referring to a web API

## What is a web API?

- A server that can handle a request using some protocol and deliver a response
- The way to format the request is detailed by the API
- There are a number of protocols that exist to do this, but we're going to talk about 2

# HTTP

- Stands for HyperText Transfer Protocol
- You may also see https which just adds Secure on the end of the acronym
- It's a protocol (methodology) for sending hypertext documents over the internet
- Hypertext document is just a document that has the ability to link to another hypertext document
    - Two examples that are relevant to us: HTML and JSON
- Stateless; which means that server is not going to keep any information about the request
    - EX:
        - Say you want to calculate 5 + 5
        - You make a server call using HTTP to calculate 5 + 5
        - The server takes in the parameters 5 and 5 and adds them
        - The server can then do whatever it wants to that RESULT, but not store any info about the request
        - The server then responds with 10
        - If we make the same request again, the server doesn't have info about the last request
        - Server takes in parameters 5 and 5 and adds them again
        - Server responds with 10
- 2 parts: the Request and the Response
- Request is built by the client and the response is built by the server

## Request

Has these parts to it:

- HTTP method (aka verb)
- URL target (endpoint)
- HTTP version
- Headers (extra information to help the server with the request)
- Body (optional, contains some resource)

## Response

Has these parts to it:

- HTTP version
- Status Code (ex: 404)
- Status Message (ex: Not Found)
- Headers (info to detail what happened)
- Body (optional, contains some resource)
    - The vast majority of responses DO contain a body

## Why use HTTP?

- Flexible (can use a huge variety of data formats (images, JSON, HTML, text files, etc))
- Secure (can be used in conjunction with authentication to enforce secure usage)
- Lightweight (doesn't cause a lot of overhead or use a ton of bandwidth)
- Simple (compared to other protocols, HTTP is VERY easy to use)
- Extensible (you can change the headers to get a different result from the server)
- Common (most people use an API that supports HTTP for these reasons here)

## HTTP Methods (Verbs)

There are more than what I'm listing here, but these are the most common:

- GET: Retrieves a resource at an endpoint
- POST: Creates a new resource at an endpoint OR updates a resource
- PUT: Completely overwrites a resource at an endpoint (meaning it can create OR update)
- DELETE: Removes a resource at an endpoint
- PATCH: Details instructions for partial update of a resource at an endpoint
    - EX: We have an endpoint for a particular user
        - A PATCH can just specify the username that should be changed instead of the whole resource

### Idempotency

> `Idempotent` means that duplicate requests will NOT make lasting changes on the server.

In English, if a method is `idempotent`, if we make that request 2 or more times in a row, it will be the same as if we only make that request once.

Idempotent Methods

---

- GET
- PUT
- DELETE

POST is NOT idempotent because if it's meant to create a resource, a duplicate POST call will create an additional resource to the one already created. PATCH is NOT idempotent because depending on how PATCH is implemented, it could do something similar.

## HTTP Status Codes

These codes give information about the response. They come in 5 series:

- 100-199 : Informational
    - EX: 102 Processing - Server is still working on the response and it isn't ready
- 200-299 : Successful
    - The meaning of success depends on what you were trying to do
    - EX: 200 OK - We did the thing successfully
- 300-399 : Redirection
    - EX: 301 Moved Permanently - The endpoint is moved to a different endpoint
        EXx2: https://www.mysite.com/api/endpoint1 is being used
            - You decide to change this the /api/endpoint2 instead
            - Whenever client would request from /api/endpoint1, you give a 301 status code
            - You'd also respond with the new endpoint: /api/endpoint2
- 400-499 : Client Error
    - EX: 401 Unauthorized - The user is not authenticated and cannot access the resource
- 500-599 : Server Error
    - EX: 500 Internal Server Error - Some error occurred on the server; typically an unhandled exception

# SOAP

- Stands for Simple Object Access Protocol

Even though it says "simple", it is anything but "simple"

- SOAP uses a special file called a .wsdl
- In order to use an API that is implemented with SOAP, we must reference this file to make the request
- This is actually pretty hard
    - wsdl files are complex and very lengthy
    - Luckily, Salesforce has a handy feature that makes it easier
    - In the Apex Classes tab, there is a wsdl2Apex feature
- SOAP can ONLY respond in XML

## Benefits of SOAP

- Doesn't require HTTP
- Can be implemented in any language and used on any platform
- Because of its age and long-time security benefits, many businesses use SOAP API
    - It is somewhat common for B2B requests to be made with SOAP