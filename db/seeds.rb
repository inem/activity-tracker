users = {
  justcxx: "skillgrid",
  socucius: "test-task",
  efelikanfuzin: "skillgrid"
}

users.each do |name, repo|
  User.create(name: name, repo: repo)
end
