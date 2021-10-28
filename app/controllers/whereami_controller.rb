# frozen_string_literal: true

class WhereamiController < ApplicationController
  def index
    language = Http::AcceptedLanguageParser.parse(request.env['HTTP_ACCEPT_LANGUAGE'])
    where_am_i = Http::WhereAmIService.call(request.remote_ip)
    json_response = where_am_i.merge(language: language)

    render(json: json_response, status: 200)
  end
end
