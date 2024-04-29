// Verify the validity of a player's turn
fn verifyTurnValidity(player_id: Field, shot_details: [Field; 2]) {
    // Example: Check if the player ID is valid (1 or 2)
    let force = shot_details[0];
    let direc = shot_details[1];
    if( force as u32 <= 500 & direc as u32 <=360  ){
        true
    }
}

fn main(player_id: Field, shot_details: [Field; 2]) {
    verifyTurnValidity(player_id, shot_details);
}

#[test]
fn test_main() {
    let player_id = 1;
    let shot_details = [30, 45];
    main(player_id, shot_details)
}
