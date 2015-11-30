RSpec.describe User, type: :model do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_uniqueness_of :email }
    it { should have_one :cart }
    it { should have_many :identities }
    it { should have_many :comments }
    it { should have_many :recipes }
    it { should have_many :grades }

    it "is valid with email and password" do
        user = User.new(email: 'example@gmail.com', password: 'password')
        expect(user).to be_valid
    end

    it "is invalid without email" do
        user = User.new(email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without password" do
        user = User.new(password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid with a duplicate email" do
        User.create(email: 'example@gmail.com', password: 'password')
        user = User.new(email: 'example@gmail.com', password: 'password')
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
    end
end