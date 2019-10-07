# This class is depicts a real life location.
class Location
  attr_accessor :lat, :lng, :measured_in

  MEASURE_TYPE = %i[degree radian].freeze

  def self.office_location
    office_lat = 53.339428
    office_lng = -6.257664
    Location.new(office_lat, office_lng, :degree)
  end

  def initialize(lat, lng, measured_in)
    @lat = lat
    @lng = lng
    @measured_in = measured_in
  end

  def distance_from(location)
    if self.measured_in == :degree
      lat_a = convert_to_rad(self.lat)
      lng_a = convert_to_rad(self.lng)
    end
    if location.measured_in == :degree
      lat_b = convert_to_rad(location.lat)
      lng_b = convert_to_rad(location.lng)
    end
    calculate_distance(lat_a, lng_a, lat_b, lng_b)
  end

  def convert_to_rad(degree)
    degree * (Math::PI / 180)
  end

  def calculate_distance(lat_a, lng_a, lat_b, lng_b)
    earth_radius = 6371_000
    lng_abs_difference = (lng_a - lng_b).abs
    central_angle = Math.acos((Math.sin(lat_a) * Math.sin(lat_b)) +
                              (Math.cos(lat_a) * Math.cos(lat_b) *
                               Math.cos(lng_abs_difference)))
    earth_radius * central_angle
  end
end
