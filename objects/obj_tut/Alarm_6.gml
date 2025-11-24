// Progress to use door stage after getting passcode
if (tutorial_stage == TUTORIAL_STAGE.GET_PASSCODE) {
    tutorial_stage = TUTORIAL_STAGE.USE_DOOR;
    tutorial_text = "Head to the door";
}