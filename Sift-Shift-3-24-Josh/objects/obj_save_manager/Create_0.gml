// Function to load data from the save file
function load() 
{
	// Load the data in the file into a buffer
	var buff = buffer_load("idle.sav");
	var buff_str = buffer_read(buff, buffer_string);
	
	// Parse the buffer data
	global.save_buffer = json_parse(buff_str);
	
	// Move data from the save buffer to the save structure
	global.save.bank = global.save_buffer.bank;
	global.save.enemy_num = global.save_buffer.enemy_num;
	global.save.enemy_diff = global.save_buffer.enemy_diff;
	global.save.enemy_hp = global.save_buffer.enemy_hp;
	global.save.enemy_augments = global.save_buffer.enemy_augments;
	
	show_debug_message(global.save.enemy_hp);
	
	// With the save buffer, check which cards should be unlocked
	for(var i = 0; i < 8; i++)
	{
		// If the save buffer says it should be unlocked, use the quick_unlock function
		if(global.save_buffer.card_unlocks[i]) 
		{
			obj_card_dock.cards[i].quick_unlock();
		}
	}
	
	// Set up the unlock button
	with(obj_button_unlock) {
		setup();
	}
	
	// Find how much time has been since the last save
	var since_last_save = date_second_span(date_current_datetime(), global.save_buffer.last_save);
	
	// Reset the dps amount
	global.dps = 0;

	// Build up a baseline dps from the cards
	with(obj_card)
	{
		// Only add the cards' dps if they're unlocked
		if(flipped)
		{
			global.dps += dps; 
		}
	}

	// Multiply the dps by the amount provided by the cards
	with(obj_card)
	{	
		// Only use the card if it's unlocked
		if(flipped)
		{
			// Only use the multiplier if it has a stat buff and the correct stat
			if(stat_buff && stat_type == "dps_mult")
			{
				global.dps *= stat_value;
			}
		}
	}
	
	// Find how much damage should have been done since the last save
	var damage_done = global.dps * since_last_save;
	
	// Find the current amount of hp the enemy the save buffer is describing has
	var curr_hp = global.save.enemy_hp[global.save.enemy_diff];
	
	// Make a temporary variable to track how many enemies should have died between last save and right now
	var enemies_killed = 0;
	
	// While the amount of damage done is over the amount of health the current simulated enemy would have, make more enemies
	while(damage_done >= curr_hp && damage_done > 0) 
	{
		// Increment the amount of enemies killed between saves
		enemies_killed++;
		
		// Subtract the simulated enemy's health from the total amount of damage done
		damage_done -= curr_hp;
		
		// Simulate a new enemy's health
		// At level 0, it starts at 5, moves up to at 1 per enemy defeated, and then that amount goes up by 1 each enemy past 6
		if(global.save.enemy_diff == 0)
		{
			var add = min(4, global.save.enemy_num[global.save.enemy_diff]);
			var n = max(0, global.save.enemy_num[global.save.enemy_diff] - 4);
	
			var sum = (n * (n + 1)) / 2;
	
			curr_hp = 5 + add + sum;
		}
		else
		{
			// Regular enemies' hp goes up by 10 after the first enemy defeated and then that amount goes up by 1
			// For every difficulty past the initial, the increase is multiplied by 10
			if(global.save.enemy_num[global.save.enemy_diff] != 0)
			{
				// Build the sum of all numbers above and including 10 and the number of this enemy defeated to add to the hp
				var n = 9 + global.save.enemy_num[global.save.enemy_diff];
				var sum = (n * (n + 1)) / 2;
				sum -= 45;
				
				// Add 100 to reach the basic health level
				curr_hp = 100 + sum;
		
				curr_hp *= power(10, global.save.enemy_diff - 1);
			}
			else // Add 100 to reach the basic health level
			{
				curr_hp = 100;
		
				curr_hp *= power(10, global.save.enemy_diff - 1);
			}
		}
	}
	
	// Subtract the remaining amount of damage from the hp
	curr_hp -= damage_done;
	
	// Find how much gold the simulated enemy would be worth
	var gold = 5;
	gold *= power(10, global.save.enemy_diff);
	
	// Add that amount of gold per enemy defeated to the bank
	if(enemies_killed > 0) {
		global.save.bank += gold * enemies_killed;
	}
	
	// If the bank has more than 5 billion gold, the game has been won
	if(global.save.bank >= 5000000000) {
		global.won = true;
	}
	
	// Save the amount of hp the simulated enemy would have
	global.save.enemy_hp[global.save.enemy_diff] = round(curr_hp);
	
	// Create an instance of the away popup to display
	var popup = instance_create_layer(room_width / 2, room_height / 2, "Popups", obj_away_popup);
	
	// Set up the popup's information
	with(popup) {
		setup(since_last_save, enemies_killed, gold * enemies_killed);
	}
}

// Function to save data to a file
function save() {
	if(instance_exists(obj_tutorial))
	{
		exit;
	}
	
	// Create a structure to save to the file with easily accessible data to it and the current time
	var map = {
		bank : global.save.bank,
		enemy_diff : global.save.enemy_diff,
		enemy_num : global.save.enemy_num,
		enemy_augments : global.save.enemy_augments,
		card_unlocks : [false, false, false, false, false, false, false, false],
		enemy_hp : global.save.enemy_hp,
		last_save : date_create_datetime(current_year, current_month, current_day, current_hour, current_minute, current_second),
	};
	
	// If the game is paused, the cards will be deactivated so activate them
	if(global.paused) {
		instance_activate_object(obj_card_dock);
		instance_activate_object(obj_card);
	}
	
	// Find whether each card is unlocked
	for(var i = 0; i < 8; i++) {
		if(obj_card_dock.cards[i].flipped) {
			map.card_unlocks[i] = true;
		}
	}
	
	// If the game is paused, deactivate the cards again
	if(global.paused) {
		instance_deactivate_object(obj_card_dock);
		instance_deactivate_object(obj_card);
	}

	// Turn the save structure into a json string
	var json = json_stringify(map);

	// Create a buffer with length equal to the json string
	var buff = buffer_create(string_byte_length(json) + 1, buffer_fixed, 1);

	// Write the json string to the buffer
	buffer_write(buff, buffer_string, json);

	// Save the buffer to a file
	buffer_save(buff, "idle.sav");
}
	
// Function to reset the game back to its original state
function reset() {
	// Create a structure with all save information at where it started
	var map = {
		bank : 0,
		enemy_diff : 0,
		enemy_num : [0, 0, 0, 0, 0, 0, 0, 0, 0],
		enemy_augments : ["", "", "", "", "", "", "", "", ""],
		card_unlocks : [false, false, false, false, false, false, false, false],
		enemy_hp : [0, 0, 0, 0, 0, 0, 0, 0, 0],
		last_save : date_create_datetime(current_year, current_month, current_day, current_hour, current_minute, current_second),
	};
	
	// Resume and reactivate all the game instances
	resume_everything();
	
	// Re-lock each card
	with(obj_card) {
		unlocked = false;
		flipped = false;
		sprite_index = spr_card_back;
	}
	
	// Turn the structure into a json string
	var json = json_stringify(map);

	// Create a buffer with length equal to the json string
	var buff = buffer_create(string_byte_length(json) + 1, buffer_fixed, 1);

	// Write the json to the buffer
	buffer_write(buff, buffer_string, json);
	
	// Save the buffer to a file
	buffer_save(buff, "idle.sav");
}

// Create a time source to save every 5 seconds
save_source = time_source_create(time_source_game, 5, time_source_units_seconds, save, [], -1);
time_source_start(save_source);