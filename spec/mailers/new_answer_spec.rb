require "rails_helper"

RSpec.describe NewAnswerMailer, type: :mailer do
  describe "send_answer" do
    let(:mail) { NewAnswerMailer.send_answer }

    it "renders the headers" do
      expect(mail.subject).to eq("Send answer")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["qna.qna@mail.ru"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
