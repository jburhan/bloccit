require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:favorites) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to allow_value("user@bloccit.com").for(:email) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have name and email attributes with capitalized name" do
      expect(user).to have_attributes(name: user.name, email: user.email)
    end
# users will respond to role
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
# users will respond to admin? it will confirm whether user is an admin
    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
# users will respond to member?
    it "responds to member?" do
      expect(user).to respond_to(:member?)
    end

    it "responds to moderator?" do
      expect(user).to respond_to(:moderator?)
    end
  end

  describe "roles" do
# users will be assigned a role by default
    it "is member by default" do
      expect(user.role).to eql("member")
    end
# we are testing member and admin users within separate contexts
    context "member user" do
      it "returns true for #member?" do
        expect(user.member?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns false for #moderator?" do
        expect(user.moderator?).to be_falsey
      end
    end

# we are testing member and admin users within separate contexts
    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false for #moderator?" do
        expect(user.moderator?).to be_falsey
      end

    end


    context "moderator user" do
      before do
        user.moderator!
      end

      it "returns false for #member?" do
        expect(user.member?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end

      it "returns true for #moderator?" do
        expect(user.moderator?).to be_truthy
      end

    end

  end


  describe "invalid user" do
    let(:user_with_invalid_name) { build(:user, name: "") }
    let(:user_with_invalid_email) { build(:user, email: "") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end

  end

# . in .avatar_url is a class method
  describe ".avatar_url" do
     let(:known_user) { create(:user, email: "blochead@bloc.io") }

     it "returns the proper Gravatar url for a known email entity" do
       expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"
       expect(known_user.avatar_url(48)).to eq(expected_gravatar)
     end
   end

end
