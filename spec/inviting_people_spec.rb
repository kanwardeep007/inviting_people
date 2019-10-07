require_relative '../inviting_people'
require_relative '../user'

describe 'People' do
  users = []
  for i in 1..4
    params = {}
    params['user_id'] = 10 - i
    users << User.new(params)
  end
  it 'should be sorted in ascending order for result' do
    expect(User.sort_by_asc(users).map(&:id)).to eq([6, 7, 8, 9])
  end
end

describe 'Integration test -' do
  it 'show valid users in ascending order' do
    expect(InvitingPeople.new.results('spec/sample_test.txt')).to eq([8, 12])
  end
end
