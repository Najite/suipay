module suipay::offramp_request;
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

public fun get_id(request: &OfframpRequest) : &UID {
    &request.id
}

public fun get_status(request: &OfframpRequest): u8 {
    request.status
}

public fun set_status(request: &mut OfframpRequest, status: u8) {
    request.status = status;
}

public fun get_sui_amount(request: &OfframpRequest): u256 {
    request.sui_amount
}

public fun transfer_request(request: OfframpRequest, recipient: address) {
    transfer::transfer(request, recipient)
}

