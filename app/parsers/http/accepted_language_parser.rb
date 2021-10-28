# frozen_string_literal: true

module Http
  class AcceptedLanguageParser
    def self.parse(accepted_languages)
      new(accepted_languages).parse
    end

    def initialize(accepted_languages)
      @accepted_languages = accepted_languages
    end

    def parse
      return if accepted_languages.nil?

      accepted_language
    end

    private

    attr_reader :accepted_languages

    def accepted_language
      sorted_by_quality.last.first
    end

    def sorted_by_quality
      parse_into_array.sort_by(&:last)
    end

    def parse_into_array
      accepted_languages.split(',').map do |lang|
        language, quality = lang.split(';q=')
        [language, (quality || '1').to_f]
      end
    end
  end
end
