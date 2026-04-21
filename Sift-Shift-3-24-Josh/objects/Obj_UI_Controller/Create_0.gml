inv_open       = false;   // is the inventory panel open?
inv_scroll        = 0;    // current scroll position
inv_scroll_target = 0;    // target scroll position (from mouse wheel)
inv_scroll_max    = 0;    // clamped max scroll, recomputed in Draw
 
// Clickable rects (populated in Draw_64, consumed by Step)
sell_rects     = [];      // one per visible row
input_rects    = [];      // one per visible row (text input boxes)
 
// Input state for sell-quantity text boxes
inv_focus      = -1;      // index of focused input (-1 = none)
inv_input      = [];      // strings — one per item, initialized below
 
// Error pop-up
inv_error_timer = 0;
inv_error_text  = "";
 
// Set a flag so Obj_Window_Controller can skip zoom when the
// mouse is over the inventory panel.
global._mouse_over_inv = false;
 
// Inventory item list with sell prices (gold per unit)
// Prices from the user's price sheet:
//   copper ore=1, tin ore=2, iron ore=4, bronze ingot=6, silver=8
inv_items = [
    { name: "Copper", sprite: Spr_CopperOre, key: "copper", sell_price: 1  },
    { name: "Iron",   sprite: Spr_IronOre,   key: "iron",   sell_price: 4  },
    { name: "Tin",    sprite: Spr_TinOre,    key: "tin",    sell_price: 2  },
    { name: "Bronze", sprite: Spr_BronzeOre, key: "bronze", sell_price: 6  },
    { name: "Silver", sprite: Spr_SilverOre, key: "silver", sell_price: 8  }
];
 
// Pre-fill input strings
for (var i = 0; i < array_length(inv_items); i++) {
    array_push(inv_input, "1");
}
 