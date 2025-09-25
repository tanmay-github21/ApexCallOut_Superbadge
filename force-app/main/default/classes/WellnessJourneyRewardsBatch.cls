global class WellnessJourneyRewardsBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
    
	/*WellnessJourneyRewardsBatch rewardsBatch= new WellnessJourneyRewardsBatch();
ID jobId=database.executeBatch(rewardsBatch,200);
System.debug('Job ID'+'\t'+jobId);
list<map<string,Object>> usersListMap= new list<map<string,Object>>();
map<string,Object> user1= new map<string,Object>();
map<string,Object> user2= new map<string,Object>(); 
user1.put('userId','0051t000003XyzA');
user1.put('fullName','Tanmoy Dash');
user1.put('email','tanmay.trailhead@Gmail.com');
user1.put('username','tanmay.dash26');

user2.put('userId','0052t000003XyzA');
user2.put('fullName','Alice Michele');
user2.put('email','alice.michele@Gmail.com');
user2.put('username','alice.michele84');

usersListMap.add(user1);
usersListMap.add(user2);

*/
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
    
        Date startDate = getStartDate();                
        Date endDate = getEndDate();
		System.debug('Batch Class start time'+'\t'+startDate+'\n'+'Batch CLass end time'+'\t'+endDate);
        String query = 'SELECT Id,Name,OwnerId, Owner.Name, Owner.Email, Owner.Username FROM Wellness_Journey__c WHERE Status__c = \'Complete\' AND Completion_Date__c >= :startDate AND Completion_Date__c <= :endDate ORDER BY OwnerId, Completion_Date__c';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Wellness_Journey__c> scope) {
        Map<Id, Integer> userGoalCountMap = new Map<Id, Integer>();
        Set<Id> uniqueUserId = new Set<Id>();
        List<Map<String, Object>> usersListMap = new List<Map<String, Object>>();
        for (Wellness_Journey__c journey : scope) {
            userGoalCountMap.put(journey.OwnerId, 0);
        } 
        for (Wellness_Journey__c journey : scope) {
        
            Integer goalCount = userGoalCountMap.get(journey.OwnerId);
            goalCount++;
            userGoalCountMap.put(journey.OwnerId,goalCount);

            if(userGoalCountMap.get(journey.OwnerId)>=12 && !uniqueUserId.contains(journey.OwnerId)){
            Map<String, Object> userObj = new Map<String, Object>();

                uniqueUserId.add(journey.OwnerId);
                userObj.put('userId',journey.OwnerId);
                userObj.put('fullName',journey.Owner.Name);
                userObj.put('email',journey.Owner.Email);
                userObj.put('username',journey.Owner.Username);
                usersListMap.add(userObj);
            }
            
        }
        //Serialize JSON
        String jsonBody=JSON.serialize(usersListMap);
        SYstem.debug('Calling Rest Service');
        Integer responseCode = RewardsCalloutService.submitUsersForRewardCallout(jsonBody);
        System.debug('Response received from Rest service class: ' + responseCode);        
    }

    global void finish(Database.BatchableContext BC) {
        // Perform finish operations
    }



    // Helper methods to get the start and end date of the quarter
    private Date getStartDate() {
        Date today = Date.today();
        
        Integer currentYear = today.year();
        Integer currentMonth = today.month();
        
        Integer previousQuarterStartMonth = ((currentMonth - 1) / 3) * 3 + 1 - 3;
        
        if (previousQuarterStartMonth <= 0) {
            previousQuarterStartMonth += 12;
            currentYear--;
        }
        
        Date previousQuarterStartDate = Date.newInstance(currentYear, previousQuarterStartMonth, 1);
        return previousQuarterStartDate;
    }

    private Date getEndDate() {
    Date previousQuarterStartDate = getStartDate();
    Date previousQuarterEndDate = previousQuarterStartDate.addMonths(3).addDays(-1);
        return previousQuarterEndDate;
    }
}