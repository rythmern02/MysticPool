// Verify the overall game state
fn verifyGameState(table_state: Field, player_scores: [Field; 2]) {
    let valid_table_state_range = 1000;
    let player_score = player_scores[0] + player_scores[1];
    assert(valid_table_state_range as u32 < table_state as u32 & player_score as u32 > 0);
}

fn main(table_state: Field, player_scores: [Field; 2]) {
    verifyGameState(table_state, player_scores)
}

#[test]
fn test_main() {
    let table_state = 1100;
    let player_scores = [5, 3];
    main(table_state, player_scores);
}

