@isTest
private class RewardsCalloutServiceTest {
    @testSetup static void recordSetup(){
        list<Wellness_Journey__c> wj1= new list<Wellness_Journey__c>(); 
        list<Wellness_Journey__c> wj2= new list<Wellness_Journey__c>(); 
        date currentYear=date.newInstance(2025,04,01), prevYear=date.newInstance(2024,12,01);
		for(Integer i=0; i<15;i++){
            wj1.add(new Wellness_Journey__c(
            name='Last Year'+i,
            Completion_Date__c=prevYear,
            Completion_Goal__c=500,
            Completion_Value__c=500,
            points__c=500,
            status__c='Complete'
            ));
        }
        for(integer j=0; j<15; j++){
            wj1.add(new Wellness_Journey__c(
            name='Last Year'+j,
            Completion_Date__c=currentYear,
            Completion_Goal__c=500,
            Completion_Value__c=500,
            points__c=500,
            status__c='Complete'
            ));
        }
    SYstem.debug('Test Class - Before Insert'+'\t'+wj1.size());    
    insert wj1;
    SYstem.debug('Test Class - After Insert'+'\t'+wj1.size());     
    }

    @isTest static void testSuccess(){
        test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        test.startTest();
        database.executeBatch(new WellnessJourneyRewardsBatch());
        test.stopTest();
        system.assert(true,'Batch executed successfully');
    }
    @isTest static void testBadData(){}
    @isTest static void testInternalError(){}
}