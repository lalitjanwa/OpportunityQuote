/**
* @File Name : AccountOpportunityDataController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 26, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 26, 2024 |   | Initial Version
**/

public class AccountOpportunityDataController {
	@AuraEnabled(cacheable=true)
	Public static List<Opportunity> getOpportunitiesWithQuotesAndItems(String accountId)
	{		
		return [SELECT Id, Name, StageName, Amount, 
						(SELECT Id, Name, TotalPrice, Status, Email, Contact.Name,
							(SELECT Id, ServiceDate, 
									ListPrice, Product2.Name, 
									Quantity, UnitPrice, totalPrice
							   FROM QuoteLineItems) 
						FROM Quotes)
				FROM Opportunity 
				WHERE AccountId = :accountId AND StageName NOT IN ('Closed Won', 'Closed Lost')];
	}
}