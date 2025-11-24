event_inherited();

if (!instance_exists(obj_minimap)) {
    var minimap = instance_create_depth(0, 0, -1000, obj_minimap);
    minimap.set_level_dimensions(3125, 500, 896, 609);
}

intro = instance_create_depth(0, 0, -10000, obj_level_intro_tut);
intro.intro_dialogue = [
    {name: "", message: "Im so excited! Its my first day at work in a big company full of outstanding-"},
    {name: "", message: "Hold on...a... corridor? Seriously? Thats not exactly the grand entrance I imagined."},
	{name: "", message: "Is this even the right floor? Ugh. This building is way more confusing than the brochure made it sound."},
	{name: "", message: "Hold on... theres someone at the end. Maybe they can tell me whats going on."},
	{name: "", message: "Alright. Lets head over."}
];

lock_instance = obj_lock_tut;
password_length = lock_instance.password_length;
password = lock_instance.password;
password_length = string_length(password);
completion_dialogue_shown = false;

// Tutorial stages enum
enum TUTORIAL_STAGE {
    NONE = 0,
    MOVEMENT = 1,
    APPROACH_NPC = 2,
    TALK_TO_NPC = 3,
    PICKUP_ITEM = 4,
    RETURN_ITEM = 5,
    TOGGLE_QUESTS = 6,
    TOGGLE_MINIMAP = 7,
    GET_PASSCODE = 8,
    USE_DOOR = 9,
    WALK_TO_DOOR = 10,
    COMPLETE = 11
}

// Tutorial state
tutorial_stage = TUTORIAL_STAGE.NONE;
tutorial_text = "";

// Track if player has moved
player_has_moved = false;

// Track intro dialogue completion
intro_dialogue_complete = false;

npc_proximity_reached = false;
npc_talk_distance = obj_player.detect_range +100; 

first_npc_interaction_done = false;

item_name_to_pickup = "Keys";
item_picked_up = false;

item_returned = false;
second_npc_talk_done = false; // Track second talk completion
third_npc_talk_done = false;

quest_toggled = false;

minimap_toggled = false;

door_unlocked = false;

worker_items = [
    {
        quest_id: "help_tut",
        quest_title: "Tutorial",
        passcode_position: 1,
        intro_dialog: [
            {name: "Rina", message: "Ah, there you are. You must be the new staff member they mentioned"},
            {name: "Rina", message: "Listen, people in this company can... let's say high-maintenance. Better get the hang of things early before you end up on their list of, uh… turtles. Don't ask. Long story."},
            {name: "Rina", message: "Anyway, see those [keys] beside me? Could you pick it up for me, I sprained my back a while back, I could not bend down for the life of me!"},
            {name: "Rina", message: "Just walk over and press [SPACE]."}
        ],
        subquests: [
            {
                item_name: "Keys",
                item_qty: 1,
                description: "Fetch the Keys",
                progress_dialog: [
                    {name: "Rina", message: "Thanks! That's a relief."},
                    {name: "Rina", message: "Now, you'll need to keep track of tasks around here. Press [Q] to open your Quest Tracker."}
                ]
            }
        ],
        no_item_dialog: [
            {name: "Rina", message: "Go on... the keys are right there."}
        ],
        final_dialog: [
            {name: "Rina", message: "Now let me show you the minimap."},
            {name: "Rina", message: "Press [M] to toggle it. It'll help you navigate around here."}
        ],
		repeat_dialog: [
			{name: "Rina", message: "Youre all set now!"},
			{name: "Rina", message: "Youll also be given a company-issued glow-in-the-dark vest. Blackouts happen quite often around here..."},
			{name: "Rina", message: "Now, go to the door at the end of the corridor, and enter the passcode: [123]. Thats the only door with a fixed code, the [rest change daily]."},
			{name: "Rina", message: "And [no one knows the full password], if you need to move around different levels, youll need to ask around"},
			{name: "Rina", message: "Good luck at work!"}
		]
    }
];

alarm[10] = 1;