# frozen_string_literal: true

module QuoteOfTheDay
  class Quote
    attr_accessor :id, :content

    def initialize(id: nil, content: '')
      @id = id
      @content = content
    end

    def <=>(other)
      self.content <=> other.content
    end
  end
end
