require "rails_helper"

RSpec.describe Notifier, type: :mailer do
  describe "recipe_new" do
    let(:mail) { Notifier.recipe_new }

    it "renders the headers" do
      expect(mail.subject).to eq("Recipe new")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "user_new" do
    let(:mail) { Notifier.user_new }

    it "renders the headers" do
      expect(mail.subject).to eq("User new")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
