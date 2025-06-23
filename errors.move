module suipay::errors;

const NOT_ADMIN: u64 = 0;
const INVALID_API_KEY: u64 = 1;
const OFFRAMP_ALREADY_PROCESSED: u64 = 2;
const VIRTUAL_CARD_ISSUE_FAILED: u64 = 3;

public fun not_admin(): u64 {
    NOT_ADMIN
}