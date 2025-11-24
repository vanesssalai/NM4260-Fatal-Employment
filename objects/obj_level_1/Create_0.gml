event_inherited();

if (!instance_exists(obj_minimap)) {
    var minimap = instance_create_depth(0, 0, -1000, obj_minimap);
    minimap.set_level_dimensions(4200, 2125, 352, 940);
}

intro = instance_create_depth(0, 0, -10000, obj_level_intro_1);
intro.intro_dialogue = [
    {name: "ANNOUNCEMENT", message: "Testing testing..."},
    {name: "ANNOUNCEMENT", message: "Hello employees, This is Rina from HR...yes the one who used to beg everyone to fill in your timesheets. I am sure you have noticed but our office is currently overrun with zombies."},
    {name: "ANNOUNCEMENT", message: "Unfortunately due to the outbreak, the buildings power grid has been compromised. Lifts and lights are out of service."},
    {name: "ANNOUNCEMENT", message: "Thankfully, as per company policy Section 7.1A, some employees were issued glow-in-the-dark safety vests last quarter!"},
    {name: "ANNOUNCEMENT", message: "Additionally, all employees must exit via the emergency stairs"},
    {name: "ANNOUNCEMENT", message: "Please make your way out of the building in an orderly fashion."},
    {name: "ANNOUNCEMENT", message: "AND MOST IMPORTANTLY-"},
    {name: "ANNOUNCEMENT", message: "Q4 reporting is due this week, so please submit your documents before evacuating."},
    {name: "ANNOUNCEMENT", message: "Remember: Zombies are temporary, but your performance review is permanent."},
    {name: "ANNOUNCEMENT", message: "Have a productive day ahead! (> ᴗ < )"}
];

total_delay = intro.black_screen_duration + intro.fade_duration + 30;

lock_instance =  obj_lock_1;

password_length = lock_instance.password_length;

num_zombies = 2;
num_workers = 3;
zombie_type = [obj_zombie];

worker_types = [
    obj_office_worker_amie,
    obj_office_worker_james,
    obj_office_worker_rachel
];

password = lock_instance.password;

password_length = string_length(password);
completion_dialogue_shown = false;

complete_dialogue = [
    {name: "", message: "Ive collected the full passcode, now lets go down to the next floor"}
];

worker_items = [
    {
        quest_id: "help_diar",
        quest_title: "Boyfriends Gift",
        passcode_position: 1,
        intro_dialog: [
            {name: "Amie", message: "Oh,hi. Im Amie, the new intern."},
            {name: "Amie", message: "I know this isnt the right time, but... I lost my [Diar wallet]."},
			{name: "Amie", message: "I had it when I was grabbing coffee in the [main office], then I put it down... somewhere...on top of a couch?"},
            {name: "Amie", message: "My boyfriend gave it to me before all this chaos. If you see it... could you let me know? Its kind of my last comfort."}
        ],
        subquests: [
            {
                item_name: "Diar Wallet",
                item_qty: 1,
                description: "Search the Main Office for Amies diar wallet",
                progress_dialog: [
                    {name: "Amie", message: "You found it! I thought it was gone forever. Thank you."}
                ]
            }
        ],
        no_item_dialog: [
            {name: "Amie", message: "Still nothing? Oh god... I cant stop thinking about it. Please, I cant go out there by myself..."}
        ],
        final_dialog: [
            {name: "Amie", message: "The first digit is: " + string_char_at(lock_instance.password, 1)},
            {name: "Amie", message: "And, um... dont tell anyone I was crying."}
        ]
    },
    {
        quest_id: "help_keycard",
        quest_title: "Fallen keycard",
		passcode_position: 2,
        intro_dialog: [
            {name: "James", message: "Hey, easy there! Are you okay? Please, stay calm... and drink some water if you can."},
            {name: "James", message: "I know everythings falling apart, but well figure it out , I promise."},
            {name: "James", message: "Oh, one more thing , can you bring me a [keycard]?"},
			{name: "James", message: "I lost mine...Im pretty sure it fell somewhere on the [meeting room] floor, maybe under a chair, maybe under the table, who knows."},
			{name: "James", message: "I need it to enter rooms to grab my files later."}
        ],
        subquests: [
            {
                item_name: "Keycard",
                item_qty: 1,
                description: "Search the Meeting Room for James keycard",
                progress_dialog: [
                    {name: "James", message: "Good work. Thanks buddy!"},
                    {name: "James", message: "The second digit of the next-level passcode is " + string_char_at(obj_level_1.password, 2)}
                ]
            }
        ],
        no_item_dialog: [
            {name: "James", message: "Still empty-handed? Dont push your luck out there."}
        ],
        repeat_dialog: [
            {name: "James", message: "Stay safe out there!"}
        ]
    },
    {
        quest_id: "medkit_1",
        quest_title: "Injured Coworker",
				passcode_position: 3,
        intro_dialog: [
            {name: "Rachel", message: "Oh hey! This is Rachel from design team! "},
            {name: "Rachel", message: "Could you find a [medkit] for me? I fought a zombie who stole my drawing tablet and now my legs bleeding..."},
			{name: "Rachel", message: "Oh dont worry, I won the fight! No one can take my drawings away from me hehehe"},
			{name: "Rachel", message: "The medkits in the [main office]... probably where I launched it earlier."}
        ],
        subquests: [
            {
                item_name: "Medkit",
                item_qty: 1,
                description: "Search the Main Office for a med kit for Rachel",
                progress_dialog: [
                    {name: "Rachel", message: "Thanks! I feel much better now."},
					{name: "Rachel", message: "The third digit of the next-level passcode is " + string_char_at(obj_level_1.password, 3)}
                ]
            }
        ],
		no_item_dialog: [
            {name: "Rachel", message: "Please hurry, its getting numb..."}
        ],
        repeat_dialog: [
            {name: "Rachel", message: "Thanks again for the help. Be careful!"}
        ]
    }
];

total_unknowns = instance_number(obj_unknown);

show_debug_message("Level 1 password: " + password);