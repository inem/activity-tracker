require "rails_helper"

describe User do
  context "create" do
    let(:user) { create(:user, name: "justcxx", repo: "skillgrid") }

    it "github url" do
      expect(user.github_url).to eq "https://github.com/justcxx/skillgrid.git"
    end

    it "clone repo" do
      repo_path = File.join("#{Rails.root}/tmp/justcxx_skillgrid")
      expect(File.exist?(repo_path)).to be true
    end
  end
end
