module suipay::errors;

public fun OFFRAMP_ALREADY_PROCESSED(): u64 { 2 }
public fun NOT_ADMIN(): u64 { 0 }
public fun INVALID_API_KEY(): u64 { 1 }
public fun VIRTUAL_CARD_ISSUE_FAILED(): u64 { 3 }

