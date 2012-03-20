When /^I submit a talk named "([^"]*)" with length of (\d+) minutes$/ do |title, duration|
  visit new_talk_url
  fill_in :title, :with => title
  fill_in :duration, :with => duration
  click_button "Submit Proposal"
end

Then /^I should see the talk was submitted successfully$/ do
  page.body.should match /submitted for review/
end
