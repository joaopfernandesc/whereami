# frozen_string_literal: true

module Http
  class WhereAmIService
    def self.call(ip)
      new(ip).call
    end

    def initialize(ip)
      @ip = ip
    end

    def call
      return { country: nil, ip: nil } if ip.nil?
      where_am_i?
    end

    private
    attr_reader :ip

    def where_am_i?
      {
        country: country,
        ip: ip
      }
    end

    def country
      make_request[:country]
    end

    def make_request
      @make_request ||= RestClient.get("https://jsonmock.hackerrank.com/api/ip/#{ip}") do |response, request, result|
        case response.code
        when 200
          JSON(response.body, symbolize_names: true)
        else
          {}
        end
      end
    end
  end
end