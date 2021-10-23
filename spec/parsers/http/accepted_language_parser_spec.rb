# frozen_string_literal: true
require 'rails_helper'

RSpec.describe(Http::AcceptedLanguageParser) do
  let(:accepted_language) { 'en-US;q=0.7,en-AU,en;q=0.3' }

  it 'retrieves the highest quality language' do
    language = described_class.parse(accepted_language)

    expect(language).to(eq('en-AU'))
  end

  context 'when nil value is passed' do
    let(:accepted_language) { nil }

    it 'returns nil' do
      language = described_class.parse(accepted_language)

      expect(language).to(be_nil)
    end
  end
end