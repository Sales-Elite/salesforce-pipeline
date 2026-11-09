import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

export default class St49OnboardingProgress extends LightningElement {
    @api recordId;
    steps = [];

    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: 'ST49_Onboarding_Steps__r',
        fields: ['ST49_Onboarding_Step__c.Id', 'ST49_Onboarding_Step__c.Name', 'ST49_Onboarding_Step__c.ST49_Done__c', 'ST49_Onboarding_Step__c.ST49_Order__c'],
        sortBy: ['ST49_Onboarding_Step__c.ST49_Order__c']
    })
    wiredSteps({ data }) {
        if (data) {
            this.steps = data.records.map((r) => ({
                name: r.fields.Name.value,
                done: r.fields.ST49_Done__c.value === true,
                order: r.fields.ST49_Order__c.value
            }));
        }
    }

    get total() {
        return this.steps.length;
    }
    get hasSteps() {
        return this.total > 0;
    }
    get doneCount() {
        return this.steps.filter((s) => s.done).length;
    }
    get percent() {
        return this.total ? (this.doneCount / this.total) * 100 : 0;
    }
    get nextName() {
        const pending = this.steps.filter((s) => !s.done).sort((a, b) => (a.order ?? 1e9) - (b.order ?? 1e9));
        return pending.length ? pending[0].name : null;
    }
}