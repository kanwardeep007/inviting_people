require_relative '../location'

describe 'Location -', focus: true do
  let (:l1) { Location.new(52.986375, -6.043701, :degree) }
  let (:l2) { Location.new(53.339428, -6.257664, :degree) }

  it  'distance between 2 points' do
    expect(l1.distance_from(l2)).to be_within(100).of 41768.7600
  end

  it ' converting lat, lng from  degree to radians ' do
    expect(l1.convert_to_rad(l1.lat)).to be_within(0.01).of 0.9247867
  end
end