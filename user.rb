# This class is used to store user related things
class User
  attr_reader :lat, :lng, :name, :id
  def initialize(params)
    @lat = params['latitude'].to_f
    @lng = params['longitude'].to_f
    @id = params['user_id'].to_i
    @name = params['name']
  end

  def self.sort_by_asc(users)
    users.sort_by{ |user| user.id }
  end

  def self.find_valid_users(users)
    invited_people = nil
    office_location = Location.office_location
    users.each do |user|
      invited_people ||= []
      invited_people << user if user.distance_satisfied?(office_location)
    end
    invited_people
  end

  def distance_satisfied?(office_location)
    max_distance = 100_000
    user_location = Location.new(self.lat, self.lng, :degree)
    measured_dist = office_location.distance_from(user_location)
    measured_dist < max_distance
  end
end