step "I am a logged in user with an event" do
  send "a user with an event"
  send "sign in"
end

step "I am at the event new income page" do
  visit "/events/#{@event.id}/incomes/new"
end


