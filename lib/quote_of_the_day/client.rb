# frozen_string_literal: true

require 'httparty'
require 'quote_of_the_day/quote'

module QuoteOfTheDay
  class Client
    include HTTParty
    base_uri 'http://quote-of-the-day.com'

    attr_accessor :base_uri

    def get_quote
      safe_request(method: :get, endpoint: '/quote') do |response|
        Quote.new(content: response['quote']['content'])
      end
    end

    def create_quote(content)
      body = { quote: { content: content } }.to_json

      safe_request(method: :post, endpoint: '/quote', body: body) do |response|
        Quote.new(id: response['quote']['id'],
                  content: response['quote']['content'])
      end
    end

    private

    def safe_request(method: :get, endpoint:, **opts)
      response = self.class.public_send(method, endpoint, opts.merge(headers))
      raise QuoteOfTheDay::Error, response.parsed_response['error']['message'] unless response.success?
      yield response.parsed_response
    rescue HTTParty::Error => e
      raise QuoteOfTheDay::Error, e
    end

    def headers
      { headers: { 'Content-Type' => 'application/json' } }
    end
  end
end

class QuoteOfTheDay::Error < RuntimeError; end
