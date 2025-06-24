module suipay::virtual_card;
use sui::event;

public struct VirtualCard has key {
    id: UID,
    user_address: address,
    card_token: vector<u8>,
    issued_at: u64,
    status: u8,
}

public struct VirtualCardIssued has copy, drop {
    user: address,
    card_token: vector<u8>,
    request_id: ID,
    timestamp: u64
}

public entry fun issue_virtual_card(
    request_id: ID,
    token: vector<u8>,
    ctx: &mut TxContext
) {
    let card = VirtualCard {
        id: object::new(ctx),
        user_address: tx_context::sender(ctx),
        card_token: token,
        issued_at: tx_context::epoch_timestamp_ms(ctx),
        status: 0,
    };

    event::emit(VirtualCardIssued {
        user: tx_context::sender(ctx),
        card_token: token,
        request_id,
        timestamp: tx_context::epoch_timestamp_ms(ctx)
    });

    transfer::transfer(card, tx_context::sender(ctx));
}