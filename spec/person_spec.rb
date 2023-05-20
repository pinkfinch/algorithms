require_relative '../encryption'

describe Person do

  describe ".encrypted_password" do

    context "given empty password" do
      it "returns the encrypted pwd" do
        person = Person.new(name: "abc", password: "")
        expect(person.encrypted_password).to eq("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
      end
    end

    context "given different password" do
      it "returns the encrypted pwd" do
        person = Person.new(name: "abc", password: "baaaa")
        expect(person.encrypted_password).to eq("dbe786b99b474df75ffb6e0c2724d5e18691b602edfada07e9fe9d4514c3d40d")
      end
    end
  end
end
