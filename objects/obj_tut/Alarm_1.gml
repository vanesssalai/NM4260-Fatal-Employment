// Progress to pickup item stage after talking to NPC
if (tutorial_stage == TUTORIAL_STAGE.TALK_TO_NPC) {
    tutorial_stage = TUTORIAL_STAGE.PICKUP_ITEM;
    tutorial_text = "Walk over to the Keys";
}