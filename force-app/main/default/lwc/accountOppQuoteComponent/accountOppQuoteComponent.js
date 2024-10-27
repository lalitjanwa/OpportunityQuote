import { LightningElement, wire, api } from 'lwc';
import fetchOpportunitiesWithQuotesAndItems from '@salesforce/apex/AccountOpportunityDataController.getOpportunitiesWithQuotesAndItems';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountOppQuoteComponent extends LightningElement {
    @api recordId;
    opportunitiesWithQuotesAndItems;
    firstOpp;

    //columns for the Quote Line Items
    columns = [
        { label: 'Product Name', fieldName: 'productName' },
        { label: 'Service Date', fieldName: 'ServiceDate', type: 'date' },
        { label: 'Quantity', fieldName: 'Quantity', type: 'phone' },
        { label: 'Unit Price', fieldName: 'UnitPrice', type: 'currency' },
        { label: 'Total Price', fieldName: 'TotalPrice', type: 'currency' },
    ];
    
    // wire property to fetch Opportunity, Quote and Quote Line Items
    @wire(fetchOpportunitiesWithQuotesAndItems, { accountId: '$recordId' })
    wiredOpportunities({ error, data }) {
        if (data) {
            this.opportunitiesWithQuotesAndItems = JSON.parse(JSON.stringify(data));
                
            //loop to set first Quote for each Opportunity and Product Name inside Quote Line Items.
            this.opportunitiesWithQuotesAndItems.forEach(opp => {
                opp.firstQuoteId = null;
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
                        if (!opp.firstQuoteId && quote.Id) {
                            opp.firstQuoteId = quote.Id; // Assign the first quote name
                        }
                    });
                }
                if (! this.firstOpp && opp.Id) {
                    this.firstOpp = opp.Id; // Assign the first quote name
                }
            });
        } else {
            // Error toast to show error when get any issue in fatching data.
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Error in loading Opportunity Data, Contact your Administrator for more details !',
                variant : 'error'
            });
            this.dispatchEvent(event);
        }
    }


}
