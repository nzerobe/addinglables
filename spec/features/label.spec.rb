require 'rails_helper'
# On the right side of this RSpec.feature, write the test item name like "blog management feature" (grouped by do ~ end)
RSpec.feature "Label Management function", type: :feature do
 # In scenario (alias of it), write the processing of the test for each item you want to check.


 scenario "Can create label" do
   @user= User.create!(name: "mentor", email: 'rob@gmail.Com',  password: 'mrnoro' )
    @label = Label.create!(name: "TestLabel")
   assert @label
  end
  
  
end