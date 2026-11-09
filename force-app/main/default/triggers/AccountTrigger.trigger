trigger AccountTrigger on Account (before insert, before update) {
    AccountTriggerHandler.setLt2Flag(Trigger.new);
}