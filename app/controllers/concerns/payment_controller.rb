get "/client_token" do
	Braintree::ClientToken.generate
end