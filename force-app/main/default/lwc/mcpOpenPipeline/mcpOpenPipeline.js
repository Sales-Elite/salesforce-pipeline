import { LightningElement, api, wire } from 'lwc';
import getOpenOpportunities from '@salesforce/apex/MCP_OpenPipelineController.getOpenOpportunities';

const COLUMNS = [
    { label: 'Name', fieldName: 'url', type: 'url', typeAttributes: { label: { fieldName: 'Name' }, target: '_self' } },
    { label: 'Stage', fieldName: 'StageName' },
    { label: 'Amount', fieldName: 'Amount', type: 'currency' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date-local' }
];

export default class McpOpenPipeline extends LightningElement {
    @api recordId;
    columns = COLUMNS;
    rows = [];
    total = 0;
    error;
    loaded = false;

    @wire(getOpenOpportunities, { accountId: '$recordId' })
    wiredOpps({ data, error }) {
        if (data) {
            this.error = undefined;
            this.rows = data.map((o) => ({ ...o, url: '/' + o.Id }));
            this.total = data.reduce((s, o) => s + (o.Amount || 0), 0);
            this.loaded = true;
        } else if (error) {
            this.rows = [];
            this.error = "We couldn't load open opportunities right now. Please try again or contact your administrator.";
            this.loaded = true;
        }
    }

    get count() {
        return this.rows.length;
    }

    get hasRows() {
        return this.rows.length > 0;
    }
}