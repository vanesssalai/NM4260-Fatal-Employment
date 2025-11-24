// Progress to get passcode stage after minimap toggle
if (tutorial_stage == TUTORIAL_STAGE.TOGGLE_MINIMAP) {
    tutorial_stage = TUTORIAL_STAGE.GET_PASSCODE;
    tutorial_text = "Talk to Rina again";
}