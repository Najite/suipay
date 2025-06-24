module suipay::config;

public struct OfframpConfig has key {
    id: UID,
    alchemy_pay_api_key: vector<u8>,
    marqeta_api_key: vector<u8>,
    admin: address,
}

public entry fun initializer (
    alchemy_key: vector<u8>,
    marqeta_key: vector<u8>,
    ctx: &mut TxContext
) {
    let config = OfframpConfig {
        id: object::new(ctx),
        alchemy_pay_api_key: alchemy_key,
        marqeta_api_key: marqeta_key,
        admin: tx_context::sender(ctx),
    };
    transfer::transfer(config, tx_context::sender(ctx))
}

public fun admin(config: &OfframpConfig): address {
    config.admin
}