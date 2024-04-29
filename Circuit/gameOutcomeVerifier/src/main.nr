// Verify the final game outcome (win, loss, or draw)
fn verifyGameOutcome(player_scores: [Field; 2], foul_count: Field)  {
    // Example: Check if the winning player has the highest score
    let winner_id = if player_scores[0] as u32 > player_scores[1] as u32 { 1 } else { 2 };

    // Example: Validate foul count (non-negative)
    let is_valid_foul_count = foul_count as u32  >= 0;

    // Ensure that the winner's score is greater than the loser's score
    assert(player_scores[winner_id - 1] as u32 > player_scores[2 - winner_id] as u32 & is_valid_foul_count);

}

fn main(player_scores: [Field; 2], foul_count: Field) {
    verifyGameOutcome(player_scores, foul_count);
}

#[test]
fn test_main() {
   let  player_scores = [1,2];
    let foul_count = 2;
    main(player_scores, foul_count);
}
