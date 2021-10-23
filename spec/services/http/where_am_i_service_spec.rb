# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(Http::WhereAmIService) do
  let(:ip) { '149.202.249.255' }
  let(:country_name) { 'Country name' }
  let(:location_response) { { ip: ip, country: country_name } }

  it 'returns "ip" and "country" fields' do
    stub_request(:get, "https://jsonmock.hackerrank.com/api/ip/#{ip}")
      .to_return(status: 200, body: location_response.to_json)

    where_am_i = described_class.call(ip)

    expect(where_am_i).to(eq(location_response))
  end

  context 'when ip is nil' do
    let(:ip) { nil }
    let(:country_name) { nil }

    it 'returns nil to "country" and "ip" fields' do
      stub_request(:get, "https://jsonmock.hackerrank.com/api/ip/#{ip}")
        .to_return(status: 200, body: location_response.to_json)

      where_am_i = described_class.call(ip)

      expect(where_am_i).to(eq(location_response))
    end
  end

  context 'when country is not found by IP (404 response)' do
    let(:country_name) { nil }

    it 'returns "nil" for country field' do
      stub_request(:get, "https://jsonmock.hackerrank.com/api/ip/#{ip}").to_return(status: 404)

      where_am_i = described_class.call(ip)

      expect(where_am_i).to(eq(location_response))
    end
  end
end
