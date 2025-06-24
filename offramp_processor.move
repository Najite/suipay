module suipay::offramp_processor;
use suipay::offramp_request::OfframpRequest;
use suipay::access_control;
use suipay::config::OfframpConfig;
use suipay::errors;
use suipay::errors::OFFRAMP_ALREADY_PROCESSED;
use sui::event;

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

    assert!(request.status == 0,errors::OFFRAMP_ALREADY_PROCESSED);

    let fiat_amount = request.sui_amount * 100;

    request.status = 1;
    transfer::transfer(request, tx_context::sender(ctx));

    event::emit(OfframpProcessed {
        request_id: object::uid_to_inner(&request.id),
        provider: b"Testitng card",
        fiat_amount,
        timestamp: tx_context::epoch_timestamp_ms(ctx);


    })

}