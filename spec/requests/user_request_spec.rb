require 'rails_helper'

RSpec.describe "Users", type: :request do

  RSpec.shared_context 'with multiple companies' do
    let!(:company_1) { create(:company) }
    let!(:company_2) { create(:company) }

    before do
      5.times do
        create(:user, company: company_1)
      end
      5.times do
        create(:user, company: company_2)
      end
    end
  end

  describe "#index" do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching users by company' do
      include_context 'with multiple companies'

      it 'returns only the users for the specified company' do
        get company_users_path(company_1)

        expect(result.size).to eq(company_1.users.size)
        expect(result.map { |element| element['id'] } ).to eq(company_1.users.ids)
      end
    end

    context 'when fetching all users' do
      it 'returns all the users by given username' do
        user1 = create(:user, username: 'Gessivam')
        user2 = create(:user, username: 'Adileia')
        user3 = create(:user, username: 'Guilherme')

        get users_path(username: 'G')

        expect(result.size).to eq(2)
        expect(result.first['username'].start_with?('G')).to eq(true)
        expect(result.first['username'][0]).to eq('G')
        expect(result.map { |user| user['username'] }.exclude?('Adileia')).to eq(true)
      end
    end
  end
end
