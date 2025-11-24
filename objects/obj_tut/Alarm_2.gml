// Progress to return item stage
if (tutorial_stage == TUTORIAL_STAGE.PICKUP_ITEM) {
    tutorial_stage = TUTORIAL_STAGE.RETURN_ITEM;
    tutorial_text = "Press SPACE to return " + item_name_to_pickup + "";
}