**Oppotunity Quote with Line Items**

We created two components to meet the project needs: an Apex class (AccountOpportunityDataContact) and an LWC (accountOppQuoteComponent). The Apex class fetches open Opportunities, Quotes, and Quote Line Items for an Account in JSON format, which the LWC then uses to display data in the UI. This setup ensures streamlined data retrieval and display across Salesforce.

Below are the schema for the project.

![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/schema.png)

As after checking found Opportunity and Quote have Master-Details same as Quote and Quote Line Item have Master-Details so get all these records into single query.
-  ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/query.png)

Below components were used for this Project.
* Apex Class
  - AccountOpportunityDataController : This class is responsible for fetching open Opportunities, Quotes, and Quote Line Items for a specific Account.

* LWC Component
  - accountOppQuoteComponent : This component serves as the UI representation of the data fetched by the Apex class. It displays the retrieved information on the Account detail page, providing users with a clear view of associated Opportunities and Quotes.
 
The Component will show on the Account level as below.
-  ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/quote_line_records.png)

To Customer Validation we have added some validations.
-  **No Opportunity Quotes** : Validation message displayed if no quotes are associated with the account's opportunities.
    - ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/no_opp_quote.png)
-  **No Quote** : Validation message shown if there are opportunities but no quotes available.
    -  ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/no_quote.png)
- **No Quote Line** : Validation message triggered if there are quotes, but no line items associated with them.
  -  ![Alt text](https://github.com/lalitjanwa/OpportunityQuote/blob/main/images/no_quote_line.png)


