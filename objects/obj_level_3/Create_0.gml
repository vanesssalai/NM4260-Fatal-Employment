event_inherited();

intro = instance_create_depth(0, 0, 10000, obj_level_intro_3);
intro.intro_dialogue = [
	{name: "ANNOUNCEMENT", message: "...Hello? Is anyone still alive? ...Please. If you can hear this... answer. Ive been calling out for nearly an hour and nobody, Oh my god. Youre still here. You actually made it. I... I cant believe it. I thought this whole floor was gone."},
	{name: "ANNOUNCEMENT", message: "Okay. Okay... listen. This is it. The final floor. The exit is somewhere on this level, but so are the ones who... didnt make it. And theyre faster now. Smarter, too. I dont know how, I dont want to know how."},
	{name: "ANNOUNCEMENT", message: "We managed to scrape together enough power for one last upgrade. Just one. After this, Ive got nothing left to give you except moral support and maybe a prayer if the Wi,Fi still works."},
	{name: "ANNOUNCEMENT", message: "Option 1: speed. Basically, youll run faster, like when someone says, ‘Quick question? at 5:59pm. Use it to outrun zombies, deadlines, or your own bad decisions."},
	{name: "ANNOUNCEMENT", message: "Option 2: extended reach. It lets you interact with items, doors, anything...without having to get right up close. Honestly, if I were you... Id take anything that keeps distance between you and whatevers crawling around up here."},
	{name: "ANNOUNCEMENT", message: "Option 3: it makes certain objects and NPCs give off a little sound when youre close. A heads,up."},
	{
        type: "choice",
		prompt: "",
        choices: [
            {
                text: "Speed , Increase base speed",
                response: [
                    {name: "ANNOUNCEMENT", message: "There you go! Hope this helps you ><"}
                ],
                callback: method(self, function() {
                    if (instance_exists(obj_player)) {
                        obj_player.move_speed *= 1.1;
						obj_player.base_move_speed *= 1.1;
                        show_debug_message("Player sight radius increased to 200");
                    }
                })
            },
            {
                text: "Extended Reach , Increase Item and Coworker talking distance",
                response: [
                    {name: "ANNOUNCEMENT", message: "There you go! Hope this helps you ><"}
                ],
                callback: method(self, function() {
                    if (instance_exists(obj_player)) {
                        obj_player.detect_range *= 1.5;
                    }
                })
            },
            {
                text: "Optimized Hearing , Increased zombie noise range and volume",
                response: [
                    {name: "ANNOUNCEMENT", message: "There you go! Hope this helps you ><"}
                ],
                callback: method(self, function() {
                    obj_object.nearby_sound = true;
					obj_unknown.nearby_sound = true;
					obj_office_worker_parent.nearby_sound = true;
                })
            }
        ]
    }
];

lock_instance = instance_find(obj_lock_3, 0);
num_zombies = 2;
num_workers = 6;
zombie_type = [obj_zombie];

worker_types = [
	obj_office_worker_sarah_2,
	obj_office_worker_liz,
	obj_office_worker_rachel_3,
	obj_office_worker_nathan_2,
	obj_office_worker_james_3,
	obj_office_worker_amie_2
];

password = lock_instance.password;

worker_items = [
    {
        quest_id: "help_folder_2",
        quest_title: "Someone sane",
        passcode_position: 4,
        intro_dialog: [
            {name: "Sarah", message: "Hey! Sorry, could you help me grab the [folder] with the office floor plan inside?"},
            {name: "Sarah", message: "I left it in the office somewhere, and I need it to send an email."},
            {name: "Sarah", message: "Last I saw it, it was in the [meeting room], probably hiding under something."}
        ],
        subquests: [
            {
                item_name: "Folder",
                item_qty: 1,
                description: "Help Sarah find her folder",
                progress_dialog: [
                    {name: "Sarah", message: "Thanks! Can I just say, whoever designed this floor plan sure is idiotic!"},
                    {name: "Sarah", message: "Who designs staircases that arent connected to each other? Now we have to unlock a new door to descend every floor."}
                ]
            }
        ],
        no_item_dialog: [
            {name: "Sarah", message: "Im sure the folder is around this floor somewhere! Let me know when you find it."}
        ],
        final_dialog: [
            {name: "Sarah", message: "Oh, and the 4th digit of the passcode is " + string_char_at(lock_instance.password, 4)}
        ]
    },
    {
        quest_id: "help_baseball",
        quest_title: "Fight the Zombies",
        passcode_position: 5,
        intro_dialog: [
            {name: "Rachel", message: "Hi again! Dont worry, Im not injured this time."},
            {name: "Rachel", message: "I remember theres [baseball bat] around the office, could you find it for me?"},
            {name: "Rachel", message: "Its in the [lounge], waiting for me to swing it like a pro if things get messy."}
        ],
        subquests: [
            {
                item_name: "Baseball Bat",
                item_qty: 1,
                description: "Search the Lounge for a baseball bat for Rachel",
                progress_dialog: [
                    {name: "Rachel", message: "Ha! The zombies will never get my drawing tablet now."},
                    {name: "Rachel", message: "Here, have some coffee, the lights might be broken, but at least the coffee machines still working!"}
                ],
                callback: method(self, function() {
                    obj_inventory.inv.item_add("Coffee", 1, spr_coffee, true);
                    show_debug_message("Rachel gave coffee!");
                })
            }
        ],
        no_item_dialog: [
            {name: "Rachel", message: "No baseball bat yet? I guess I could fight zombies with my fist, but Id much prefer having a weapon..."}
        ],
        final_dialog: [
            {name: "Rachel", message: "The 5th digit of the passcode is " + string_char_at(lock_instance.password, 5)+ ". Good luck getting out, I need to finish this drawing before I leave!"}
        ]
    },
    {
        quest_id: "help_bow",
        quest_title: "Waterrr pt 2.",
        intro_dialog: [
            {name: "James", message: "Im glad youve made it this far. Look at how much youve grown! Im so proud of you."},
            {name: "James", message: "Have you been hydrating yourself lately? Because I havent. Could you get another [bottle of water] for me?"},
            {name: "James", message: "I think theres one in the [collaboration space]."}
        ],
        subquests: [
            {
                item_name: "Bottle of Water",
                item_qty: 1,
                description: "James needs his water!",
                progress_dialog: [
                    {name: "James", message: "Times are tough, but its nothing a little meditation and support from people like you cant solve."},
                    {name: "James", message: "Have this healing pill. I like to take one after my daily self reflection!"},
                    {name: "James", message: "Just press [E] to use it!"}
                ],
                callback: method(self, function() {
                    obj_inventory.inv.item_add("Heal", 1, spr_heal_pill_1, true);
                    show_debug_message("James gave heal pill!");
                })
            }
        ],
        no_item_dialog: [
            {name: "James", message: "Good to see you hydrated and healthy! I, on the other hand, am not hydrated at all. Could you get me that bottle of water ASAP?"}
        ]
    },
    {
        quest_id: "help_cd_tablet",
        quest_title: "From your ex?",
        passcode_position: 1,
        intro_dialog: [
            {name: "Amie", message: "Hey! Thanks for finding my wallet last time... but I need your help again!"},
            {name: "Amie", message: "I lost the [CD] that my ex,boyfriend gifted me... please help me find it, I really love the playlist he made for me..."},
            {name: "Amie", message: "It should be in the [executive office], probably sulking over my carelessness."}
        ],
        subquests: [
            {
                item_name: "CD",
                item_qty: 1,
                description: "Search the Executive Office for Amie's CD",
                progress_dialog: [
                    {name: "Amie", message: "Oh, youre just the best!!"},
                    {name: "Amie", message: "Actually, I realised that I lost something else... its the [tablet] my ex,girlfriend gifted me!"},
                    {name: "Amie", message: "I dropped it in the [main office] while sprinting away from one of these stinky zombies...Please help me find it... I can't live without it!"}
                ]
            },
            {
                item_name: "Tablet",  // Make sure this matches your item spawner
                item_qty: 1,
                description: "Search the Main Office for Amie's tablet",
                progress_dialog: [
                    {name: "Amie", message: "Youre, youre a lifesaver!! What would I do without you? I think Im falling for you..."}
                ]
            }
        ],
        no_item_dialog: [
            {name: "Amie", message: "Please... youre the only one I can count on now..."}
        ],
        final_dialog: [
            {name: "Amie", message: "Oh, the 1st digit of the passcode is " + string_char_at(lock_instance.password, 1) + ". See you again... ><"}
        ]
    },
    {
        quest_id: "help_medkit_2",
        quest_title: "Feeling Under the Weather",
        passcode_position: 3,
        intro_dialog: [
            {name: "Liz", message: "Hi, this is Liz... cough cough!"},
            {name: "Liz", message: "Oh, sorry! I didnt mean to cough on you, Im just sick. Dont worry , Im not turning into a zombie! Just the flu!"},
            {name: "Liz", message: "Could you get me the [medkit]? It has cough medicine inside."},
            {name: "Liz", message: "Last I saw it, it was in the [main office]... hiding from germs."}
        ],
        subquests: [
            {
                item_name: "Medkit",
                item_qty: 1,
                description: "Search the Main Office for a med kit for Liz",
                progress_dialog: [
                    {name: "Liz", message: "Thanks! I gotta get rid of this cough before my audit tomorrow... cough cough"}
                ]
            }
        ],
        no_item_dialog: [
            {name: "Liz", message: "Cough cough... Need medicine... cough cough"}
        ],
        final_dialog: [
            {name: "Liz", message: "Oh, the 3rd digit of the passcode is " + string_char_at(lock_instance.password, 3) + "... cough cough"}
        ]
    },
    {
        quest_id: "help_pretzel",
        quest_title: "Harmless Bribery?",
        passcode_position: 2,
        intro_dialog: [
            {name: "Nathan", message: "Oh, it you! Thanks for your help last time, I sent all my files over! Now my manager wants to go through my performance review with me in her office..."},
            {name: "Nathan", message: "Could you find some [pretzels] for me? She likes those... gotta butter her up best as I can."},
            {name: "Nathan", message: "Youll find them in the [pantry]."}
        ],
        subquests: [
            {
                item_name: "Pretzel",
                item_qty: 1,
                description: "Search the Pantry for Pretzels for Nathan",
                progress_dialog: [
                    {name: "Nathan", message: "Youre the best. Now even a zombie outbreak cant stop me from getting promoted!"}
                ]
            }
        ],
        no_item_dialog: [
            {name: "Nathan", message: "Nothing yet? I need those pretzels before my meeting with her, please."}
        ],
        final_dialog: [
            {name: "Nathan", message: "Oh, the 2nd digit of the passcode is " + string_char_at(lock_instance.password, 2) + "."}
        ]
    }
];

total_unknowns = instance_number(obj_unknown);

show_debug_message("Level 3 password: " + password);