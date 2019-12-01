require 'rails_helper'

describe SearchController, :type => :controller do
  describe "#index" do
    context "q with |" do
      before do
        stub_request(:get, "https://openstates.org/api/v1/bills/?apikey=no-such-key&page=1&per_page=10&q=foo%20%7C%20bar").
          to_return(status: 200, body: [], headers: {})
      end

      it "treats q string as-is" do
        get :index, params: { search: { q: "foo | bar" } }

        expect(response.status).to eq(200)
      end
    end
  end
end
