require 'json'
require_relative 'user'
require_relative 'location'
# This is the main class for finding 
# out people to invite to the party
# All measurements are in metric system.
class InvitingPeople
  def results(file_name)
    begin
      users_data = File.read(file_name)
      return 'Sorry, no user can be invited' if users_data.nil?

      users = convert_to_user_list(users_data)
      users = User.find_valid_users(users)
      users = User.sort_by_asc(users)
      print_output(users)
      users.map(&:id)
    rescue StandardError => e
      puts "#{e.message}"
    end
  end

  private

  def print_output(users)
    users.each do |user|
      puts "Name - #{user.name}, Id - #{user.id}"
    end
  end

  def convert_to_user_list(data)
    users = data.split("\n").map { |a| JSON.parse(a) }
    users.map { |user_detail| User.new(user_detail) }
  end
end
