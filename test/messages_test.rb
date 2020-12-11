require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/messages'

class MessagesTest < Minitest::Test

  def test_it_exists
    messages = Messages.new

    assert_instance_of Messages, messages
  end

  # def test_it_displayes_greeting
  #   messages = Messages.new
  #
  #   greeting = "Welcome to BATTLESHIP \n Enter p to play. Enter q to quit."
  #   require "pry"; binding.pry
  #   assert_equal greeting, messages.greeting
  # end
end
