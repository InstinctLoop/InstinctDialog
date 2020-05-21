pages = ds_list_create();
components = ds_list_create();

nameplate = ds_list_create();
portrait = ds_list_create();
backdrop = ds_map_create();

page = 0;
last_cursor = 0;
cursor = 0;
answer = 0;

cursor_timer = 0;

cursor_speed = 1;

exiting = false;

waiting = false;
wait_arg = 0;
wait_time = 0;

displayed_string = "";
current_page = "";
