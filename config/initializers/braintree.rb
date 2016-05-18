Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = ENV["BT_merch_id"]
Braintree::Configuration.public_key = ENV["BT_pub_key"]
Braintree::Configuration.private_key = ENV["BT_pri_key"]