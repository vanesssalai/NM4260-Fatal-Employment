event_inherited();

intro = instance_create_depth(0, 0, -10000, obj_level_intro_2);
intro.intro_dialogue = [
    {name: "ANNOUNCEMENT", message: "Attention...any survivors still on the floor... This is still Rina from HR...If you made it past the 3rd floor, congratulations. That means youre still breathing... which puts you in the top 30% of the company right now."},
    {name: "ANNOUNCEMENT", message: "Listen up. As you continue moving through the floor, things are going to get worse. The zombies here... theyre faster, and some of them were managers...so they dont give up easily."},
    {name: "ANNOUNCEMENT", message: "Youll need every advantage you can get. Our systems detected a temporary energy spike in the buildings emergency equipment, and weve rerouted it to you. That means you get one upgrade before you proceed."},
    {name: "ANNOUNCEMENT", message: "Choose carefully. Once you pick it, theres no undo button... trust me, IT checked."},
    {name: "ANNOUNCEMENT", message: "Option one: Brighter eyes, brighter future. We can boost the power to your vests so it actually lights an astounding two more metres in front of you. Great for spotting zombies..."},
    {name: "ANNOUNCEMENT", message: "Option two: HR-approved resilience. We can give you one extra chance before you officially become lunch. Think of it as... extended medical leave. You still don’t want to get bitten, but hey...everyone deserves one free mistake"},
    {name: "ANNOUNCEMENT", message: "Option three: We optimize your hearing. Basically, we crank up every little sound around you...zombie footsteps, groans...Downsides? You’ll also hear... everything. Even James chewing if he’s still out there."},

    {
        type: "choice",
        prompt: "",
        choices: [
            {
                text: "Brighter Eyes - Increase sight radius",
                response: [
                    {name: "ANNOUNCEMENT", message: "There you go! Hope this helps you ><"}
                ],
                callback: method(self, function() {
                    if (instance_exists(obj_player)) {
                        obj_player.sight_radius = 350;
                        show_debug_message("Player sight radius increased to 200");
                    }
                })
            },

            {
                text: "HR Approved Resilience - Gain +1 max life",
                response: [
                    {name: "ANNOUNCEMENT", message: "There you go! Hope this helps you ><"}
                ],
                callback: method(self, function() {
                    if (instance_exists(obj_player)) {
                        obj_player.max_life += 1;
                        obj_player.life += 1;
                        show_debug_message("Player max health increased to " + string(obj_player.max_life));
                    }
                })
            },

            {
                text: "Optimized Hearing - Increased zombie noise range and volume",
                response: [
                    {name: "ANNOUNCEMENT", message: "There you go! Hope this helps you ><"}
                ],
                callback: method(self, function() {
                    with (obj_zombie) {
                        obj_zombie.audio_range_far += 50;
                        volume_far = 0.6;
                        volume_near = 1;
                        show_debug_message("Zombie audio range reduced");
                    }
                })
            }
        ]
    }
];


lock_instance = instance_find(obj_lock_2, 0);

num_zombies = 2;
num_workers = 5;

zombie_type = [ obj_zombie ];

worker_types = [
    obj_office_worker_rachel_2,
    obj_office_worker_nathan,
    obj_office_worker_sarah,
    obj_office_worker_Marcus,
    obj_office_worker_james_2
];

password = lock_instance.password;


worker_items = [

    {
        quest_id: "help_medkit_cd",
        quest_title: "Injured Coworker pt2",
		passcode_position: 4,
        intro_dialog: [
            {name: "Rachel", message: "Its you again! Could you find me another [medkit]?"},
            {name: "Rachel", message: "What happened this time?"},
            {name: "Rachel", message: "I may have had to fight a zombie again... Those things love my drawing tablet!"},
            {name: "Rachel", message: "The med kit’s in the [pantry], go before I dramatically faint!"}
        ],

        subquests: [
            {
                item_name: "Medkit",
                item_qty: 1,
                description: "Search the Pantry for a med kit for Rachel",
                progress_dialog: [
                    {name: "Rachel", message: "Thanks again! Youre the best."},
                    {name: "Rachel", message: "Oh, wait! One more thing, could you help me find my [CD]?"},
                    {name: "Rachel", message: "I lost it during the zombie fight, and now I can’t listen to my drawing playlist!"}
                ]
            },

            {
                item_name: "CD",
                item_qty: 1,
                description: "Search the Main Office for Rachels CD",
                progress_dialog: [
                    {name: "Rachel", message: "The codes 4th digit is " + string_char_at(lock_instance.password, 4)},
                    {name: "Rachel", message: "Here, have my coffee! Cant drink it while Im bleeding..."},
                    {name: "Rachel", message: "The higher ups are so obsessed with productivity, pressing [shift] will give you a speed boost!"},
                    {name: "Rachel", message: "Use it wisely..."},
                    {name: "Rachel", message: "Back to drawing for me, before my boss fires me!"}
                ],
                callback: method(self, function() {
                    obj_inventory.inv.item_add("Coffee", 1, spr_coffee, true);
                    show_debug_message("Amie gave coffee!");
                })
            }
        ],

        no_item_dialog: [
            {name: "Rachel", message: "Ill be drawing here while waiting for you!"}
        ]
    },


    {
        quest_id: "help_key_tablet",
        quest_title: "Missing Items",
		passcode_position: 3,
        intro_dialog: [
            {name: "Nathan", message: "Whoa! Hey! You’re not infected, right? ...Good. I need your help before the whole floor gets overrun."},
            {name: "Nathan", message: "Corporate emailed me, during the outbreak, reminding me that my performance review is ‘pending action items.’ So yeah, I... kinda can’t fail this quarter."},
            {name: "Nathan", message: "I dropped my office [key] while sprinting away from a zombie."},
            {name: "Nathan", message: "It should be somewhere in the [main office].I need them back please help."}
        ],

        subquests: [
            {
                item_name: "Keys",
                item_qty: 1,
                description: "Search the Main Office for Nathans office key",
                progress_dialog: [
                    {name: "Nathan", message: "Thank you so much!"},
                    {name: "Nathan", message: "I realised my [tablet] is also missing, could you help find it too?"},
                    {name: "Nathan", message: "The last time I saw it, it was sitting at a lonely corner somewhere in the [executive office]."}
                ]
            },

            {
                item_name: "Tablet",
                item_qty: 1,
                description: "Search the Executive Office for Nathans tablet",
                progress_dialog: [
                    {name: "Nathan", message: "Thanks!"}
                ]
            }
        ],

        no_item_dialog: [
            {name: "Nathan", message: "Im still waiting! If I fail my performance review, I could get fired!"}
        ],

        repeat_dialog: [
            {name: "Nathan", message: "Stay safe out there!"}
        ],

        final_dialog: [
            {name: "Nathan", message: "Now I can send my files over!"},
            {name: "Nathan", message: "The codes 3rd digit is " + string_char_at(lock_instance.password, 3)}
        ]
    },


    {
        quest_id: "help_design_folder",
        quest_title: "Lost Designs",

        intro_dialog: [
            {name: "Sarah", message: "Oh thank god, another survivor!"},
            {name: "Sarah", message: "Im Sarah from the design team. Listen, I need to find my folder."},
            {name: "Sarah", message: "It has all my client presentations. If I lose those files, I lose my job... assuming we survive this."},
            {name: "Sarah", message: "It should still be in the [meeting room] after I accidentally launched it mid-scream..."}
        ],

        subquests: [
            {
                item_name: "Folder",
                item_qty: 1,
                description: "Find Sarahs design folder in the meeting room",
                progress_dialog: [
                    {name: "Sarah", message: "Youre a lifesaver! Literally!"},
                    {name: "Sarah", message: "Hey, I have some supplies. What do you need more of right now?"}
					],
					callback: method(self, function() {
                    obj_inventory.inv.item_add("Coffee", 1, spr_coffee, true);
                    show_debug_message("Amie gave coffee!");
                }
                )
            }
        ],

        no_item_dialog: [
            {name: "Sarah", message: "Please hurry... I can hear them getting closer."}
        ],

        repeat_dialog: [
            {name: "Sarah", message: "Thanks again! Stay safe!"}
        ]
    },


    {
        quest_id: "help_server_keycard",
        quest_title: "IT Emergency",
		passcode_position: 2,
        intro_dialog: [
            {name: "Marcus", message: "You! IT emergency! Well, everythings an emergency right now, but still!"},
            {name: "Marcus", message: "I dropped my server room [keycard] when I was running from those... things."},
            {name: "Marcus", message: "Pretty sure it skidded somewhere in the [executive offices]."},
            {name: "Marcus", message: "I need to shut down the buildings systems before we evacuate. Fire protocols and all that."}
        ],

        subquests: [
            {
                item_name: "Keycard",
                item_qty: 1,
                description: "Search the Executive Office for Marcus server room keycard ",
                progress_dialog: [
                    {name: "Marcus", message: "Perfect! Now I can access the systems."},
                    {name: "Marcus", message: "Heres the 2nd digit for the exit door " + string_char_at(lock_instance.password, 2) + "."}
                ]
            }
        ],

        no_item_dialog: [
            {name: "Marcus", message: "Still searching? Be careful out there. Those zombies are getting more aggressive."}
        ],

        repeat_dialog: [
            {name: "Marcus", message: "Good luck getting out of here!"}
        ]
    },


    {
        quest_id: "help_bow_1",
        quest_title: "Hyrdation Reminder",
		passcode_position: 1,
        intro_dialog: [
            {name: "James", message: "Nice to see you again! How have you been?"},
            {name: "James", message: "I know times are hard right now, but peace of mind is the most important. Remember to take deep breaths and hydrate yourself."},
            {name: "James", message: "Actually... I'm feeling a little thirsty. Could you help find me a [bottle of water]?"}, 
            {name: "James", message: "There should still be one left in the [pantry], unless a zombie started meal prepping."}
        ],

        subquests: [
            {
                item_name: "Bottle of Water",
                item_qty: 1,
                description: "Search the Pantry for a bottle of water for James",
                progress_dialog: [
                    {name: "James", message: "You're perfect just the way you are. Here, have this healing pill as thanks."},
                    {name: "James", message: "Remember, mental wellness comes first!"}
                ],
                callback: method(self, function() {
                    obj_inventory.inv.item_add("Heal", 1, spr_heal_pill_1, true);
                })
            }
        ],

        no_item_dialog: [
            {name: "James", message: "No water for me yet? That's alright, let's meditate before you start searching again."}
        ],

        repeat_dialog: [
            {name: "James", message: "Meditation is the key to getting out..."}
        ],
		final_dialog: [
            {name: "James", message: "Now I can send my files over!"},
            {name: "James", message: "The codes 3rd digit is " + string_char_at(lock_instance.password, 1)}
        ]
    }

];


/// UNKNOWN COUNT
total_unknowns = instance_number(obj_unknown);

show_debug_message("Level 2 password: " + password);

if (keyboard_check_pressed(ord("L")))
{
    show_debug_message("----- NPC LIVE CHECK -----");
    show_debug_message("Workers: " + string(instance_number(obj_office_worker_parent)));
    show_debug_message("Silhouettes: " + string(instance_number(obj_unknown)));
    show_debug_message("Total NPCs: " +
        string(instance_number(obj_office_worker_parent) + instance_number(obj_unknown)));
}
