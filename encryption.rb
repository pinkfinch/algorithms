require 'digest'

module Encryption
  def encrypt(str)
    Digest::SHA2.hexdigest(str)
  end
end

class Person
  include Encryption


  attr_reader :name


  def initialize(name:, password:)
    @name = name
    @password = password
  end

  def encrypted_password
    encrypt(@password)
  end
end

p = Person.new(name: "blue", password: "plue")
p.name = "pent"
p p.encrypted_password
