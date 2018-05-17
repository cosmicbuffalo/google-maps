require File.expand_path('../google-maps/configuration', __FILE__)
require File.expand_path('../google-maps/logger', __FILE__)
require File.expand_path('../google-maps/route', __FILE__)
require File.expand_path('../google-maps/place', __FILE__)
require File.expand_path('../google-maps/location', __FILE__)

module Google
  module Maps
    extend Configuration
    extend Logger

    def self.route(from, to, options={})
      Route.new(from, to, options_with_defaults(options))
    end

    def self.distance(from, to, options={})
      Route.new(from, to, options_with_defaults(options)).distance.text
    end

    def self.duration(from, to, options={})
      Route.new(from, to, options_with_defaults(options)).duration.text
    end

    def self.places(keyword, language = self.default_language)
      Place.find(keyword, language)
    end

    def self.place(place_id, language = self.default_language)
      PlaceDetails.find(place_id, language)
    end

    def self.geocode(address, language = self.default_language)
      Location.find(address, language)
    rescue ZeroResultsException
      []
    end

    protected

    def self.options_with_defaults(options)
      { language: self.default_language, key: Google::Maps.api_key }.compact.merge(options)
    end
  end
end
