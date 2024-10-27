**Oppotunity Quote with Line Items**

We created two components to meet the project needs: an Apex class (AccountOpportunityDataContact) and an LWC (accountOppQuoteComponent). The Apex class fetches open Opportunities, Quotes, and Quote Line Items for an Account in JSON format, which the LWC then uses to display data in the UI. This setup ensures streamlined data retrieval and display across Salesforce.

Below are the schema for the project.

![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/schema.png)

Below components were used for this Project.
* Apex Class
  - AccountOpportunityDataController

* LWC Component
  - accountOppQuoteComponent
 
The Component will show on the Account level as below.
-  ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/quote_line_records.png)

To Customer Validation we have added some validations.
-  **No Opportunity Quotes**
    - ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/no_opp_quote.png)
-  **No Quote**
    -  ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/no_quote.png)
- **No Quote Line**
  -  ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/no_quote_line.png)


