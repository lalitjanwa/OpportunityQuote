/**
* @File Name : AccountOpportunityDataController.cls
* @Description : This class is for accountOppQuoteCompoent to pass Opportunity, Quote and Quote Line Data to Component.
* @Author :
* @Last Modified By : Lalit Janwa
* @Last Modified On : 10-27-2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 26, 2024 |   | Initial Version
**/

public class AccountOpportunityDataController {
	/**
	* @description This Method is use to get Opportunity With Quote and Quote Line Items.
	* @author Lalit Janwa | 10-27-2024 
	* @param accountId 
	* @return List<Opportunity> 
	**/
	@AuraEnabled(cacheable=true)
	Public static List<Opportunity> getOpportunitiesWithQuotesAndItems(String accountId)
	{	
		return [SELECT Id, Name, StageName, Amount, CloseDate, Type,
						(SELECT Id, Name, QuoteNumber, TotalPrice, Status, Email, Contact.Name, ExpirationDate,
							(SELECT Id, ServiceDate, 
									ListPrice, Product2.Name, 
									Quantity, UnitPrice, totalPrice
							   FROM QuoteLineItems) 
						FROM Quotes)
				FROM Opportunity 
				WHERE AccountId = :accountId AND StageName NOT IN ('Closed Won', 'Closed Lost') LIMIT 50000];
	}
}
