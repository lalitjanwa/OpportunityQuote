import { LightningElement, wire, api } from 'lwc';
import fetchOpportunitiesWithQuotesAndItems from '@salesforce/apex/AccountOpportunityDataController.getOpportunitiesWithQuotesAndItems';

export default class AccountOppQuoteComponent extends LightningElement {
    @api recordId;
    opportunitiesWithQuotesAndItems;
    firstOpp;

    columns = [
        { label: 'Product Name', fieldName: 'productName' },
        { label: 'Service Date', fieldName: 'ServiceDate', type: 'date' },
        { label: 'Quantity', fieldName: 'Quantity', type: 'phone' },
        { label: 'Unit Price', fieldName: 'UnitPrice', type: 'currency' },
        { label: 'Total Price', fieldName: 'TotalPrice', type: 'currency' },
    ];
    
    @wire(fetchOpportunitiesWithQuotesAndItems, { accountId: '$recordId' })
    wiredOpportunities({ error, data }) {
        if (data) {
            try{
            this.opportunitiesWithQuotesAndItems = JSON.parse(JSON.stringify(data));

            this.opportunitiesWithQuotesAndItems.forEach(opp => {
                opp.firstQuoteName = null;
                if(opp.Quotes){
                    opp.Quotes.forEach(quote => {
                        if(quote.QuoteLineItems){
                            quote.QuoteLineItems = quote.QuoteLineItems.map(item => {
                                return {
                                    ...item,
                                    productName: item.Product2 && item.Product2.Name ? item.Product2.Name : ''
                                };
                            });
                        }
                        if (!opp.firstQuoteName && quote.Id) {
                            opp.firstQuoteName = quote.Id; // Assign the first quote name
                        }
                    });
                }
                if (! this.firstOpp && opp.Id) {
                    this.firstOpp = opp.Id; // Assign the first quote name
                }
            });
            console.log('this.opportunitiesWithQuotesAndItems ');
            console.log(this.opportunitiesWithQuotesAndItems);
            } catch(ex){
                console.log(ex);
            }
        }
    }


}