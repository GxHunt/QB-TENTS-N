local Translations = {
    error = {
        ["already_mission"] = "You already have a client, please take them to their destination.",
        ["not_in_taxi"] = "You are not in a Taxi Cab",
        ["missing_meter"] = "This vehicle does not have a meter",
        ["no_vehicle"] = "You are not in a motor vehicle",
        ["not_active_meter"] = "You have not activated your Taxi meter",
        ["no_meter_sight"] = "There is no Taxi meter in sight",
    },
    success = {},
    info = {
        ["person_was_dropped_off"] = "Your client was dropped off.",
        ["npc_on_gps"] = "Please pick up your client at the marked location.",
        ["go_to_location"] = "Take your client to where they wish to go.",
        ["vehicle_parking"] = "[E] - Vehicle Parking",
        ["job_vehicles"] = "[E] - Access Job Vehicles",
        ["drop_off_npc"] = "[E] - Drop Off client",
        ["call_npc"] = "[E] - Call over client",
        ["blip_name"] = "Downtown Cab",
        ["taxi_label_1"] = "Taxi Cab",
        ["no_spawn_point"] = "There are no free parking spaces, wait for one to access a cab.",
        ["taxi_returned"] = "Cab Parked"
    },
    menu = {
        ["taxi_menu_header"] = "Taxi Vehicles",
        ["close_menu"] = "⬅ Close Menu",
        ['boss_menu'] = "Boss Menu"
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true,
})