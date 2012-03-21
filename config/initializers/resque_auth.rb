Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user == "Its me Mario"
  password == "Its me Luigi"
end