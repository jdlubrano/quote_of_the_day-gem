require 'pact/consumer/rspec'

Pact.service_consumer "Client Gem" do
  has_pact_with "Quote of the Day Service" do
    mock_service :quote_of_the_day_service do
      port 1234
    end
  end
end
