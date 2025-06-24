module suipay::offramp_processor;
use suipay::offramp_request::{OfframpRequest, get_status, set_status, transfer_request, get_id};
use suipay::access_control;
use suipay::config::OfframpConfig;
use suipay::errors;
use sui::event;
use suipay::offramp_request::get_sui_amount;

public struct OfframpProcessed has copy, drop {
    request_id: ID,
    provider: vector<u8>,
    fiat_amount: u256,
    timestamp: u64,
}


public entry fun process_offramp(
    mut request: OfframpRequest,
    config: &OfframpConfig,
    ctx: &mut TxContext
) {
    access_control::only_admin(config, ctx);

    assert!(get_status(&request) == 0,errors::OFFRAMP_ALREADY_PROCESSED());

    let request_id = *object::uid_as_inner(get_id(&request));


    let fiat_amount = get_sui_amount(&request) * 100;

    set_status(&mut request, 1);

    transfer_request(request, tx_context::sender(ctx));



    event::emit(OfframpProcessed {
        request_id,
        provider: b"Testitng card",
        fiat_amount,
        timestamp: tx_context::epoch_timestamp_ms(ctx),
    });

}