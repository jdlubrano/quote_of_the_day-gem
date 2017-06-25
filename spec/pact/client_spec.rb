# frozen_string_literal: true

require 'quote_of_the_day/client'
require 'quote_of_the_day/quote'
require_relative './pact_helper'

RSpec.describe QuoteOfTheDay::Client, pact: true do
  let(:client) { QuoteOfTheDay::Client.new }
  let(:headers) { { 'Content-Type' => 'application/json' } }

  before { QuoteOfTheDay::Client.base_uri('localhost:1234') }

  describe 'get_quote' do
    before do
      quote_of_the_day_service
        .upon_receiving('a request for a quote')
        .with(method: :get, path: '/quote')
        .will_respond_with(
          status: 200,
          headers: headers,
          body: { quote: { content: Pact.like('Quote this') } })
    end

    subject(:quote) { client.get_quote }

    it 'returns a quote' do
      is_expected.to be_a(QuoteOfTheDay::Quote)
    end

    it "assigns the quote's content" do
      expect(quote.content).to eq('Quote this')
    end
  end

  describe 'create_quote' do
    let(:content) { 'Quote that' }

    subject(:quote) { client.create_quote(content) }

    context 'when the quote content is valid' do
      before do
        quote_of_the_day_service.given('the quote content is valid')
        .upon_receiving('a request to create a quote')
        .with(
          method: :post,
          path: '/quote',
          headers: headers,
          body: { quote: { content: content } })
        .will_respond_with(
          status: 201,
          headers: headers,
          body: { quote: { id: Pact.like(1), content: content } })
      end

      it 'returns a quote' do
        is_expected.to be_a(QuoteOfTheDay::Quote)
      end

      it 'assigns the content and id of the quote' do
        expect(quote.id).to eq(1)
        expect(quote.content).to eq(content)
      end
    end

    context 'when the quote content is invalid' do
      let(:content) { 'Invalid quote' }

      before do
        quote_of_the_day_service.given('the quote content is invalid')
        .upon_receiving('a request to create a quote')
        .with(
          method: :post,
          path: '/quote',
          headers: headers,
          body: { quote: { content: content } })
        .will_respond_with(
          status: 422,
          headers: headers,
          body: { error: Pact.like(message: 'message', type: 'error type') })
      end

      it 'raises a QuoteOfTheDay::Error' do
        expect { quote }.to raise_error(QuoteOfTheDay::Error, 'message')
      end
    end
  end
end
