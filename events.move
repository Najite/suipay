module suipay::events;

public struct OfframpRequested has copy, drop {
    user: address,
    sui_amount: u256,
    fiat_currency: vector<u256>,
    timestamp: u64
}

public struct OfframpProcessed has copy, drop {
    request_id: ID,
    provider: vector<u8>,
    fiat_amount: u256,
    timestamp: u64,
}

public struct VirtualCardIssued has copy, drop {
    user: address,
    card_token: vector<u256>,
    request_id: ID,
    timestamp: u64
}

public struct ConfigUpdated has copy, drop {
    updated_by: address,
    field: vector<u8>,
    timestamp: u64,
}