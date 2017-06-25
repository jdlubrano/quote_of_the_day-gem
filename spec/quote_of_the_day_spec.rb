require 'spec_helper'

RSpec.describe QuoteOfTheDay do
  let(:client) { QuoteOfTheDay::Client.new }

  it 'has a version number' do
    expect(QuoteOfTheDay::VERSION).not_to be nil
  end

  describe 'ping' do
  end

  describe 'get_quote' do
  end
end
