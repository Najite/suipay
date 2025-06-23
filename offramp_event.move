module suipay::offramp_event;
use sui::event;

public struct OfframpRequested has copy, drop {
    user: address,
    sui_amount: u256,
    fiat_currency: vector<u8>,
    timestamp: u64
}

public struct OfframpRequest has key {
    id: UID,
    user_address: address,
    sui_amount: u256,
    fiat_currency: vector<u8>,
    requested_at: u64,
    status: u8
}


public struct OfframpProcessed has copy, drop {
    request_id: ID,
    provider: vector<u8>,
    fiat_amount: u256,
    timestamp: u64,
}


public struct ConfigUpdated has copy, drop {
    updated_by: address,
    field: vector<u8>,
    timestamp: u64,
}

public entry fun request_offramp(
    amount: u256,
    currency: vector<u8>,
    ctx: &mut TxContext
) {
    let req = OfframpRequest {
        id: object::new(ctx),
        user_address: tx_context::sender(ctx),
        sui_amount: amount,
        fiat_currency: currency,
        requested_at: tx_context::epoch_timestamp_ms(ctx),
        status: 0,
    };

    event::emit(OfframpRequested {
        user: req.user_address,
        sui_amount: req.sui_amount,
        fiat_currency: req.fiat_currency,
        timestamp: req.requested_at
    });

    transfer::transfer(req, tx_context::sender(ctx));
}
