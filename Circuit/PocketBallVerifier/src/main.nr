use dep::std;

// Verify whether a ball was pocketed legally
fn verifyPocketBall(ball_number: Field, pocket_position: Field) {
    // Assuming valid ball numbers are 1 to 15 (excluding cue ball)
    if (ball_number as u32 >= 1
        & ball_number as u32 <= 15
        & pocket_position as u32 >= 1
        & pocket_position as u32 <= 6) {
        true
    }
}
// Example usage:
fn main(ball_number: Field, pocket_position: Field) {
    verifyPocketBall(ball_number, pocket_position);
}

#[test]
fn main_test() {
    let ball_number = 5;
    let pocket_position = 3;
    main(ball_number, pocket_position);
}

