module suipay::acess_control;
use suipay::config::{OfframpConfig, admin};
use suipay::errors::NOT_ADMIN;

public fun only_admin(
    config: &OfframpConfig,
    ctx: &TxContext
) {
    assert!(
        tx_context::sender(ctx) == admin(config), NOT_ADMIN
    );
}