/**
* @File Name : AccountOpportunityDataControllerTest.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : October 27, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | October 27, 2024 |   | Initial Version
**/
@isTest
public class AccountOpportunityDataControllerTest {

    @isTest
    static void testGetOpportunitiesWithQuotesAndItems() {
        //Step 1: Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting', // Not closed
            Amount = 10000,
            CloseDate = Date.today(),
            AccountId = testAccount.Id
        );
        insert testOpportunity;

        Quote testQuote = new Quote(
            Name = 'Test Quote',
            Pricebook2Id = System.Test.getStandardPricebookId(),
            OpportunityId = testOpportunity.Id,
            Status = 'Draft',
            Email = 'test@example.com'
        );
        insert testQuote;

        // Create a test Product
        Product2 testProduct = new Product2(Name = 'Test Product', IsActive = true);
        insert testProduct;

        // Create a PricebookEntry for the product in the standard pricebook
        PricebookEntry standardPricebookEntry = new PricebookEntry(
            Pricebook2Id = System.Test.getStandardPricebookId(),
            Product2Id = testProduct.Id,
            UnitPrice = 2500,
            IsActive = true
        );
        insert standardPricebookEntry;

        QuoteLineItem testQuoteLineItem = new QuoteLineItem(
            QuoteId = testQuote.Id,
            PricebookEntryId = standardPricebookEntry.Id,
            Product2Id = [SELECT Id FROM Product2 LIMIT 1].Id, // Assuming there's at least one Product2 record
            Quantity = 2,
            UnitPrice = 2500,
            ServiceDate = Date.today()
        );
        insert testQuoteLineItem;

        // Step 2: Call the method to be tested
        System.Test.startTest();
        List<Opportunity> opportunities = AccountOpportunityDataController.getOpportunitiesWithQuotesAndItems(testAccount.Id);
        System.Test.stopTest();

        // Step 3: Assertions
        System.assertNotEquals(null, opportunities, 'Expected non-null list of opportunities');
        System.assertEquals(1, opportunities.size(), 'Expected exactly one opportunity');
        
        Opportunity opp = opportunities[0];
        System.assertEquals(testOpportunity.Id, opp.Id, 'Expected the opportunity ID to match');
        System.assertEquals(1, opp.Quotes.size(), 'Expected exactly one quote associated with the opportunity');

        Quote quote = opp.Quotes[0];
        System.assertEquals(testQuote.Id, quote.Id, 'Expected the quote ID to match');
        System.assertEquals(1, quote.QuoteLineItems.size(), 'Expected exactly one quote line item associated with the quote');

        QuoteLineItem quoteLineItem = quote.QuoteLineItems[0];
        System.assertEquals(testQuoteLineItem.Product2Id, quoteLineItem.Product2Id, 'Expected the quote line item product ID to match');
        System.assertEquals(2, quoteLineItem.Quantity, 'Expected the quote line item quantity to match');
        System.assertEquals(2500, quoteLineItem.UnitPrice, 'Expected the quote line item unit price to match');
    }
}